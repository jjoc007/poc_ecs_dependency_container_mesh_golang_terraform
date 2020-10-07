variable "poc_ms_app_name" {
  description = "Name of Application Container"
  default = "poc-ms-go"
}
variable "poc_main_api_image" {
  description = "Docker image to run in the ECS cluster"
  default = "167186109795.dkr.ecr.us-east-2.amazonaws.com/poc-main-service:hard"
}
variable "poc_main_api_port" {
  description = "Port exposed by the Docker image to redirect traffic to"
  default = 9000
}

variable "poc_main_api_count" {
  description = "Number of Docker containers to run"
  default = 4
}
variable "poc_main_fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default = "256"
}
variable "poc_main_fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default = "512"
}