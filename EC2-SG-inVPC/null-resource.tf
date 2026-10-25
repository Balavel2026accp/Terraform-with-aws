## creating null resource and for copying terrform-key.pem to /tmp/terraform-key.pem using ec2-user user credentials
resource "null_resource" "fille-copying-arches-job" {
  depends_on = [ module.ec2-instance-bashtion ]
  # adding connection block privisioners to connect with ec2
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = ""
    host     = aws_eip.Bashtion.public_ip
    private_key = file("private-key/terrafrom-key.pem")

  }

 # file provisioner to copy the pem to the bashtion host /tmp/terraform-key.pem
 provisioner "file" {
  source      = "private-key/terrafrom-key.pem"
  destination = "tmp/terrafrom-key.pem"

#   connection {
#     type     = "winrm"
#     user     = "Administrator"
#     password = var.admin_password
#     host     = var.host
#   }
 # remote exec to ececute the script 
 
}

provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 tmp/terrafrom-key.pem"
    ]
  }

provisioner "local-exec" {
    command    = "echo The resouce creation on: `date` and VPC ID: ${module.vpc-1.vpc_id} >> creationTime_vpc_id.txt"
    working_dir = "local-exec-output"
    on_failure = continue
    #when = destroy
  }  
}

