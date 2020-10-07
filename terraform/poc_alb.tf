# Define Application Load Balancer - alb.tf
resource "aws_alb" "main" {
  name = "${var.poc_ms_app_name}-load-balancer"
  subnets = aws_subnet.aws-subnet.*.id
  security_groups = [aws_security_group.aws-lb.id]
  tags = {
    Environment = var.app_environment
  }
}
resource "aws_alb_target_group" "poc_alb_app" {
  name = "${var.poc_ms_app_name}-target-group"
  port = 9000
  protocol = "HTTP"
  vpc_id = aws_vpc.aws-vpc.id
  target_type = "ip"
  health_check {
    healthy_threshold = "4"
    interval = "300"
    protocol = "HTTP"
    matcher = "200"
    timeout = "40"
    path = "/health"
    unhealthy_threshold = "2"
  }
  tags = {
    Environment = var.app_environment
  }

}
# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port = var.poc_main_api_port
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.poc_alb_app.id
    type = "forward"
  }
}
# output nginx public ip
output "nginx_dns_lb" {
  description = "DNS load balancer"
  value = aws_alb.main.dns_name
}