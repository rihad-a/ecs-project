# --- General ---

variable "domain_name" {
  type        = string
  description = "The domain name for the infrastructure"
  default     = "networking.rihad.co.uk"
}

# --- ALB_TG VARIABLES ---

variable "albtg-port" {
  type        = number
  description = "The port for the target group"
  default     = 3000
}

# --- ALB ---

variable "alb-port-1" {
  type        = number
  description = "The port for the first listener (HTTPS)"
  default     = 443
}

variable "alb-port-2" {
  type        = number
  description = "The port for the second listener (HTTP)"
  default     = 80
}

# --- aws vpc ---

variable "vpc-cidr" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet-cidrblock-pub1" {
  type        = string
  description = "The CIDR block for public subnet 1"
  default     = "10.0.101.0/24"
}

variable "subnet-cidrblock-pub2" {
  type        = string
  description = "The CIDR block for public subnet 2"
  default     = "10.0.102.0/24"
}

variable "subnet-cidrblock-pri1" {
  type        = string
  description = "The CIDR block for private subnet 1"
  default     = "10.0.1.0/24"
}

variable "subnet-cidrblock-pri2" {
  type        = string
  description = "The CIDR block for private subnet 2"
  default     = "10.0.2.0/24"
}

variable "subnet-az-2a" {
  type        = string
  description = "Availability zone for the 'a' subnets"
  default     = "eu-west-2a"
}

variable "subnet-az-2b" {
  type        = string
  description = "Availability zone for the 'b' subnets"
  default     = "eu-west-2b"
}

variable "routetable-cidr" {
  type        = string
  description = "Destination CIDR for the route table"
  default     = "0.0.0.0/0"
}

variable "subnet-map_public_ip_on_launch_public" {
  type        = bool
  description = "Boolean to map public IP on launch for public subnets"
  default     = true
}

variable "subnet-map_public_ip_on_launch_private" {
  type        = bool
  description = "Boolean to map public IP on launch for private subnets"
  default     = false
}

# --- ecs creation ---

variable "ecs-container-name" {
  type        = string
  description = "The name of the container in the task definition"
  default     = "threat-composer"
}

variable "ecs-containerport" {
  type        = number
  description = "The port the container listens on"
  default     = 3000
}