provider "cloudinit" {}
#we start creating templates of file
data "template_file" "init-cfg-script" {
  template = "${file("init.cfg")}"
}

data "template_file" "shell-script" {
  template = "${file("volumes.sh")}"
  vars = {
    DEVICE = "/dev/xvdh"
  }
}

#create template of cloudinit_config data source
data "template_cloudinit_config" "cloudinit_example" {
  gzip          = false #true by default
  base64_encode = false #true by default

  part {
    filename    = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.init-cfg-script.rendered}"
  }
  part {
    filename    = "volumes.sh"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.shell-script.rendered}"
  }
}