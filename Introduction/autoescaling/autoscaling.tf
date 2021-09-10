resource "aws_launch_configuration" "test_lc" {
  name          = "web_config"
  image_id      = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
  user_data     = file("userdata.sh")
}


 

resource "aws_autoscaling_group" "test_asg" {
  name                      = "test_asg"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  load_balancers            = [aws_elb.asg-elb.id ]
  launch_configuration      = aws_launch_configuration.test_lc.name
  vpc_zone_identifier       = [aws_subnet.private-b.id, aws_subnet.private-a.id]


  timeouts {
    delete = "15m"
  }


}