resource "aws_instance" "jenkins_master"  {

  instance_type           = "t3.micro"
  vpc_security_group_ids  = [var.allow_everything] #replace your SG
  ami                     = data.aws_ami.ami_info.id
  subnet_id              = "subnet-0ea9a2005fdcc6695" 
  user_data               = file("${path.module}/install_jenkins_master.sh")

  # Define the root volume size and type
  root_block_device  {
    encrypted             = false
    volume_type           = "gp3"
    volume_size           = 60
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true
  }
  
    tags = {
    Name   = "Jenkins-Master"
  }
}
resource "aws_instance" "jenkins_agent" {

  instance_type           = "t3.micro"
  vpc_security_group_ids  = [var.allow_everything] #replace your SG
  ami                     = data.aws_ami.ami_info.id
  subnet_id              = "subnet-0ea9a2005fdcc6695" 
  user_data               = file("${path.module}/install_jenkins_agent.sh")
   
  # Define the root volume size and type
  root_block_device  {
    encrypted             = false
    volume_type           = "gp3"
    volume_size           = 120
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true
  }

  tags = {
    Name   = "Jenkins-Agent"
  }
}


# resource "aws_key_pair" "tools" {
#     key_name = "tools-key"
#     #you can paste the public key directly like this
#     #public_key = file("~/.ssh/openssh.pub")
#     # ~ means windows home directory
#     public_key = "${file("~/.ssh/tools.pub")}"
# }

# resource "aws_instance" "nexus" {

#   instance_type          = "t3.medium"
#   vpc_security_group_ids = [var.allow_everything] #replace your SG
#   ami                    = data.aws_ami.nexus_ami_info.id
#   key_name               = aws_key_pair.tools.key_name
#   subnet_id              = "subnet-0ea9a2005fdcc6695"  
 
#   tags = {
#     Name   = "Nexus"
#   }
# }
# resource "aws_instance" "sonarqube" {

#   instance_type          = "t3.medium"
#   vpc_security_group_ids = [var.allow_everything] #replace your SG
#   ami                    = data.aws_ami.sonarqube_ami_info.id
#   key_name               = aws_key_pair.tools.key_name
#   subnet_id              = "subnet-0ea9a2005fdcc6695" 
     
#   tags = {
#     Name   = "SonarQube"
#   }
# }
 
resource "aws_route53_record" "jenkins_master_r53" {
    zone_id = var.zone_id
    name    = "jenkins_master.${var.domain_name}"
    type    =  "A"
    ttl     = 1
    records = [aws_instance.jenkins_master.public_ip]
    allow_overwrite = true
}
resource "aws_route53_record" "jenkins_agent_r53" {
    zone_id = var.zone_id
    name    = "jenkins_agent.${var.domain_name}"
    type    = "A"
    ttl     = 1
    records = [aws_instance.jenkins_agent.public_ip]
    allow_overwrite = true
}
# resource "aws_route53_record" "nexus_r53" {
#     zone_id = var.zone_id
#     name    = "nexus.${var.domain_name}"
#     type    = "A"
#     ttl     = 1
#     records = [aws_instance.nexus.public_ip]
#     allow_overwrite = true
# }
# resource "aws_route53_record" "sonarqube_r53" {
#     zone_id = var.zone_id
#     name    = "sonarqube.${var.domain_name}"
#     type    = "A"
#     ttl     = 1
#     records = [aws_instance.sonarqube.public_ip]
#     allow_overwrite = true
# }

