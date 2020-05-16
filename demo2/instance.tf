resource "aws_key_pair" "mypairkey"{
    key_name="mypairkey"
    public_key="${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "server"{
    ami ="${lookup(var.AMIS,var.AWS_REGION)}"
    instance_type="t2.micro"
    key_name="mypairkey"
    #Provisioner upload script.sh file
    provisioner "file"{
        connection{
            type="ssh"
            host="${aws_instance.server.public_ip}"
            user = "${var.AWS_INSTANCE_USERNAME}"
            private_key= "${file("${var.PATH_TO_PRIVATE_KEY}")}"
            #agent = false
        # timeout= "1m"
        }

      source="script.sh"
      destination="/tmp/script.sh"
    }
   
}