resource "aws_ecr_repository" "poc_main_service_repository" {
  name                 = "poc-main-service"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Environment = var.app_environment
  }
}

resource "aws_ecr_repository" "poc_transformer_service_repository" {
  name                 = "poc-transformer-service"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Environment = var.app_environment
  }
}