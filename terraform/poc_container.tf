# nginx container | poc_container.tf
# container template
data "template_file" "nginx_app" {
  template = file("./poc_main.json")
  vars = {
    app_name = var.poc_ms_app_name
    app_image = var.poc_main_api_image
    app_port = var.poc_main_api_port
    fargate_cpu = var.poc_main_fargate_cpu
    fargate_memory = var.poc_main_fargate_memory
    aws_region = var.aws_region
  }
}
# ECS task definition
resource "aws_ecs_task_definition" "nginx_app" {
  family = "nginx-task"
  execution_role_arn = aws_iam_role.ecsTaskExecutionRole.arn
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = var.poc_main_fargate_cpu
  memory = var.poc_main_fargate_memory
  container_definitions = data.template_file.nginx_app.rendered
  tags = {
    Environment = var.app_environment
  }
}
# ECS service
resource "aws_ecs_service" "nginx_app" {
  name = "poc_app_go_service"
  cluster = aws_ecs_cluster.aws-ecs.id
  task_definition = aws_ecs_task_definition.nginx_app.arn
  desired_count = var.poc_main_api_count
  launch_type = "FARGATE"
  network_configuration {
    security_groups = [aws_security_group.aws-ecs-tasks.id]
    subnets = aws_subnet.aws-subnet.*.id
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_alb_target_group.poc_alb_app.id
    container_name = "poc_app_go_service"
    container_port = var.poc_main_api_port
  }
  depends_on = [aws_alb_listener.front_end]

}