#--- loadbalancing/outputs.tf ---

output "elb" {
  value = aws_lb.two-tier-lb.id
}

output "alb_tg" {
  value = aws_lb_target_group.dec-tg.arn
}

output "alb_dns" {
  value = aws_lb.two-tier-lb.dns_name
}