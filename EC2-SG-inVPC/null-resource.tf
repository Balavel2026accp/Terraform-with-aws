## creating null resource and for copying terrform-key.pem to /tmp/terraform-key.pem using ec2-user user credentials
resource "null_resource" "fille-copying-arches-job" {
  depends_on = [ module.ec2-instance-bashtion ]
  # adding connection block privisioners to connect with ec2
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = ""
    host     = aws_eip.Bashtion.public_ip
    private_key = file("private-key/terraform-key.pem")

  }

 # file provisioner to copy the pem to the bashtion host /tmp/terraform-key.pem
 provisioner "file" {
  source      = "private-key/terraform-key.pem"
  destination = "/tmp/terraform-key.pem"

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
      "ls -l /tmp/terraform-key.pem",
      "sudo chmod 400 /tmp/terraform-key.pem",
      "ls -l /tmp/terraform-key.pem"
  ]
  }

provisioner "local-exec" {
    command    = "echo The resouce creation on: `date` and VPC ID: ${module.vpc-1.vpc_id} >> check_folder/creationTime_vpc_id.txt"
    working_dir = "check_folder/"
    on_failure = continue
    #when = destroy

    /* 
    This destroy when prtovisioners need to be configured with self count.index for each; 
    Here the null resource have any self.ip. 
    */
  }  


  provisioner "local-exec" {
    command    = "echo The resouce creation on: `date` and VPC ID: ${module.vpc-1.vpc_id} >> check_folder/creationTime_vpc_id.txt"
    working_dir = "check_folder/"
    on_failure = continue
    when = destroy

    /* 
    This destroy when prtovisioners need to be configured with self count.index for each; 
    Here the null resource have any self.ip. 
    */
  }  
}

