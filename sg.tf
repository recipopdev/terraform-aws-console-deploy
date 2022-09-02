resource "aws_security_group" "main" {
  name        = "${var.service}"
  description = "${var.service} security group"
  vpc_id      = var.network.vpc
}

resource "aws_security_group_rule" "main_egress_traffic" {
  description       = "Allows Egress traffic to outside world"
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  security_group_id = aws_security_group.main.id
  cidr_blocks       = ["0.0.0.0/0"]
}