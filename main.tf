provider "aws" {
  region = "eu-west-1"  # Changez selon votre région
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-backend-thomas"          # Nom de votre bucket S3
    key            = "eb-gh-prod.state"      # Chemin du fichier d'état
    region         = "us-east-2"          # Votre région
    #dynamodb_table = "terraform-lock"     # Pour le verrouillage de l'état
    encrypt        = true                 # Chiffrement
  }
}

# Création d'un dépôt ECR
resource "aws_ecr_repository" "my_app" {
  name = "EB-GH-ECR"  # Nom du dépôt ECR

  image_tag_mutability = "IMMUTABLE"  # Peut être "MUTABLE" ou "IMMUTABLE"
  tags = {
    Name        = "EB-GH-ECR"
    Environment = "production"
  }
}

# Création d'un rôle IAM pour accéder à ECR
resource "aws_iam_role" "ecr_role" {
  name = "ECRAccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"  # Pour ECS, ajustez selon vos besoins
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
}

# Politique IAM pour accéder à ECR
resource "aws_iam_policy" "ecr_policy" {
  name        = "ECRAccessPolicy"
  description = "Policy to allow access to ECR"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeRepositories",
          "ecr:CreateRepository"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attachement de la politique IAM au rôle
resource "aws_iam_role_policy_attachment" "ecr_role_attachment" {
  role       = aws_iam_role.ecr_role.name
  policy_arn = aws_iam_policy.ecr_policy.arn
}

output "ecr_repository_uri" {
  value = aws_ecr_repository.my_app.repository_url
}