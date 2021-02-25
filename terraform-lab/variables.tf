variable "region" {
  description = "The region for deployment"
  default = "us-east-1"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = 1024
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = 2048
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "db_port" {
  description = "Port to access the database"
  default     = 3306
}

variable "docker_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "wordpress"
}

variable "task_count" {
  description = "Number of tasks to run"
  default     = 1
}

variable "subnets" {
  type        = "list"
  description = "The subnets for the ECS service"
  default     = ["subnet-6e431460", "subnet-65b12f3a"]
}

variable "vpc_id" {
  description = "The vpc used to deploy the SG"
  default     =  "vpc-7710be0a"
}

variable "db_storage" {
  description = "The DB storage value"
  default     = 10
}

variable "db_instance" {
  description = "The DB instance class"
  default     = "db.t2.micro"
}

variable "db_name" {
  description = "The DB name"
  default     = "wordpress"
}

variable "db_username" {
  description = "The DB username"
  default     = ""
}

variable "db_password" {
  description = "The DB password"
  default     = ""
}
