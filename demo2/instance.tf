resource "aws_key_pair" "mykey"{
    key_name="mykey"
    public_key="${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "server"{
    ami ="${lookup(var.AMIS,var.AWS_REGION)}"
    instance_type="t2.micro"
    key_name="${aws_key_pair.mykey.key_name}"
    #Provisioner upload script.sh file
    provisioner "file"{
        source="script.sh"
        destination="/tmp/script.sh"
    }
    #Provisioner to add permision and execute script file
    provisioner "remote-exec"{
        inline=[
            "chmod +x /tmp/script.sh",
            "sudo /tmp/script.sh"
        ]
    }
    connection{
        host="${self.public_ip}"
        user = "${var.AWS_INSTANCE_USERNAME}"
        password= "${file("${var.PATH_TO_PRIVATE_KEY}")}"
    }
}