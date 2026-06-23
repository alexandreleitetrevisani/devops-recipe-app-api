variable "tf_state_bucket" {
  description = "Name of S3 bucket in AWS for storing TF state"
  default     = "devops-terraform-djangodep1"
}

variable "tf_state_lock_table" {
  description = "Name of DynamoDB table for TF state locking"
  default     = "devops-recipe-app-api-tf-lock"
}

variable "project" {
  description = "Project name for tagging resources"
  default     = "devops-recipe-app-api"
}

variable "contact" {
  description = "Contact name for tagging resources"
  default     = "leitetrevisani@gmail.com"
}
