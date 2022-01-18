resource "random_id" "server" {
  keepers = {
    # Generate a new id each time we switch to a new AMI id
    ami_id = var.ami_id
  }

  byte_length = 8
}

data "aws_ami" "ubuntu" {
  most_recent = true
  tags = merge(
        local.common_tags,

        tomap(
          {"Zoo" = "AWS R3Dfarm"
          "RESOURCE" = "ubuntu server"
          }
        )
        )
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20220110*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical

}

resource "aws_instance" "webserver" {
  tags = merge(
        local.common_tags,

        tomap(
          {"Zoo" = "AWS Zoofarm"
	   "Name" = "${var.myname}-${random_id.server.hex}-${count.index + 1}"
#	   "SSMManaged_UBNUNTU" = var.ssm_managed
           "RESOURCE" = "webserver AMI"
          }
        )
        )
  ami                         = data.aws_ami.ubuntu.id
  availability_zone           = var.avail_zone
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.terraform_pub_key.key_name
  vpc_security_group_ids      = [aws_security_group.allowall.id]
  subnet_id                   = aws_subnet.main.id
  associate_public_ip_address = true
#  iam_instance_profile = "${aws_iam_instance_profile.ssm_profile_nix.name}"
  user_data = "${file("install_userdata_XTerm.js.sh")}"
  count = var.instance_count

#  provisioner "remote-exec" {
#    inline = [
#      "sudo apt update",
#      "sudo apt-get -y install python",
#      "sudo apt-get -y install software-properties-common",
#      "sudo apt-add-repository --yes --update ppa:ansible/ansible",
#      "sudo apt-get -y install ansible",
#      "cd ansible; ansible-playbook -vvv -c local -i \"localhost,\" armor.yml",
#      "sudo apt-get install curl unzip",
#      "sudo apt-get jq"
#    ]

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
    }
  #}
  #Don't comment out this next line.
}
