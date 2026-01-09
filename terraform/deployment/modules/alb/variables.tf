# --- General Variables ---

variable "application-port" {
  type        = number
  description = "The port for the application"
}

variable "https-port" {
  type        = number
  description = "The port for the HTTPS listener"
}

variable "http-port" {
  type        = number
  description = "The port for the HTTP listener"
}

# --- Module Variables ---

variable "vpc_id" {
  type        = string
  description = "The VPC id from the vpc module"
}

variable "subnetpub1_id" {
  type        = string
  description = "The public 1 subnet id from the vpc module"
}

variable "subnetpub2_id" {
  type        = string
  description = "The public 2 subnet id from the vpc module"
}

variable "certificate_arn" {
  type        = string
  description = "The certificate arn from the route53 module"
}
