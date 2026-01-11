output "s3_bucket_name" {
  description = "Name of the S3 bucket for storing Terraform state"
  value       = aws_s3_bucket.s3.id
}

output "ecr_registry" {
  description = "URL of the Amazon ECR registry for pushing Docker images"
  value       = aws_ecr_repository.ecs-project.repository_url
}
