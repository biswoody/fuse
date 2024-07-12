terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.56.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


provider "aws" {
  alias  = "new"
  region = "eu-west-1"
}
resource "aws_iam_user" "code" {
  name = "nat"
}


data "aws_iam_policy_document" "fuse" {
  statement {
    sid = "antwipolicy"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }

  
    

  
    

    
      
    }
  

  
  
  

resource "aws_iam_policy" "policy1" {
  name   = "AntwiPolicy"
  path   = "/"
  policy = data.aws_iam_policy_document.fuse.json
}



resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.code.name
  policy_arn = aws_iam_policy.policy1.arn
}


resource "aws_iam_user_policy_attachment" "test-attach2" {
  user       = aws_iam_user.code.name
policy_arn = "arn:aws:iam::767397863180:policy/AmazonEC2FullAccess"

}
resource "aws_instance" "web" {
  ami           = "ami-0b72821e2f351e396"
  instance_type = "t2.micro"

  tags = {
    Name = "natinstance1"
  }
}


resource "aws_instance" "weby" {
  ami           = "ami-0b995c42184e99f98"
  provider = aws.new
  instance_type = "t2.micro"

  tags = {
    Name = "natinstance2"
  }
}


output "ec2ip" {
  value = aws_instance.web.private_ip
}

output "natid" {
  value = aws_iam_user.code.arn
}

