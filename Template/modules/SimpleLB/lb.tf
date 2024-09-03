resource "aws_elb" "SimpleLB-LB" {
  name            = var.lb_name
  subnets         = [aws_subnet.SimpleLB-Subnets["AZ-A"].id, aws_subnet.SimpleLB-Subnets["AZ-B"].id, aws_subnet.SimpleLB-Subnets["AZ-C"].id]
  security_groups = [aws_security_group.LbNSG.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = [aws_instance.SimpleLB-Instance["AZ-A-Machine"].id, aws_instance.SimpleLB-Instance["AZ-B-Machine"].id, aws_instance.SimpleLB-Instance["AZ-C-Machine"].id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = var.lb_name
  }
}

