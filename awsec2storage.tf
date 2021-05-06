provider  "aws" {
region = "ap-south-1"
profile = "default"

}
# Creating EC2 Instance - Step 1

resource "aws_instance"  "os1"{
ami = "ami-010aff33ed5991201"
instance_type = "t2.micro"
tags = {
     Name = "My first TF syed"	
      }
}
# Creating EBS Volume - Step 2
resource "aws_ebs_volume" "storage1" {
  availability_zone = aws_instance.os1.availability_zone 
  size              = 10

  tags = {
    Name = "LinuxWorld HD new"
  }
}

# Attach EBS volume - Step 3
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.storage1.id
  instance_id = aws_instance.os1.id
}

output "my_public_ip" {
  value = aws_instance.os1.public_ip
}
output "my_az" {
  value = aws_instance.os1.availability_zone
}
output "subnet" {
  value = aws_instance.os1.subnet_id
}
output "o2" {
  value = aws_ebs_volume.storage1.id
}
output "o3" {
  value = aws_volume_attachment.ebs_att.device_name
}
