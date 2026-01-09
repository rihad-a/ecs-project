# --- General Variables ---

variable "application-port" {
  type        = number
  description = "The port for the application"
}

# --- ECS Variables ---

variable "ecs-container-name" {
  type        = string
  description = "The name of the container in the task definition"
}

variable "ecs-image" {
  type        = string
  description = "The url for the latest docker image"
}

variable "ecs-dockerport" {
  type        = number
  description = "The port the docker image uses"
}

# --- Module Variables ---

variable "tg_arn" {
  type        = string
  description = "The target group arn from the alb module"
}

variable "subnetpri1_id" {
  type        = string
  description = "The private 1 subnet id from the vpc module"
}

variable "vpc_id" {
  type        = string
  description = "The vpc id from the vpc module"
}

