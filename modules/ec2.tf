resource "aws_security_group" "app_ec2_sg" {
  name        = "${var.app_name}_sg"
  description = "Security Group for blog"
  vpc_id      = "${var.vpc_id}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "http"
    security_groups = ["${aws_security_group.app_elb_sg.id}"]
  }
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = "${var.tags}"
}

resource "aws_security_group" "app_elb_sg" {
 name        = "${var.app_name}_elb_sg"
 description = "SG for ELB ${var.app_name}"
 vpc_id      = "${var.vpc_id}"  
 ingress {
   from_port = 80
   to_port   = 80
   protocol  = "tcp"
   cidr_blocks= ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags                  = "${var.tags}"
}

resource "aws_elb" "app_elb" {
  name                              = "${var.app_name}"
  subnets                           = [ "${var.app_subnet_public}" ]
  security_groups                   = ["${aws_security_group.app_elb_sg.id}"]
  cross_zone_load_balancing         = true
  idle_timeout                      = 60
  connection_draining               = true
  connection_draining_timeout       = 30
  listener {
    instance_port                   = 80
    instance_protocol               = "http"
    lb_port                         = 80
    lb_protocol                     = "http"
  }
  health_check {
    healthy_threshold               = 2
    unhealthy_threshold             = 2
    timeout                         = 5
    target                          = "TCP:80"
    interval                        = 10
  }
  tags                              = "${var.tags}"
}

resource "aws_instance" "app_ec2" {
  ami                         = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  vpc_security_group_ids      = ["${aws_security_group.app_ec2_sg.id}"]
  subnet_id                   = "${var.app_subnet_private}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true
  tags = "${var.tags}"
}

resource "aws_elb_attachment" "app_ec2_elb" {
    elb      = "${aws_elb.app_elb.id}"
    instance = "${aws_instance.app_ec2.id}"
}
