packer {
  required_plugins {
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
    incus = {
      source  = "github.com/bketelsen/incus"
      version = "~> 1"
    }
  }
}

variable "skip_publish" {
  type    = bool
  default = false
}

source "incus" "debian12" {
  image        = "images:debian/12"
  output_image = "debian12"
  publish_properties = {
    description = "Debian 12 (Bookworm) built with Packer"
  }
  reuse = true
}

source "incus" "ubuntu2404" {
  image        = "images:ubuntu/noble"
  output_image = "ubuntu2404"
  publish_properties = {
    description = "Ubuntu 24.04 (Noble) built with Packer"
  }
  reuse = true
}

build {
  sources = [
    "incus.debian12",
    "incus.ubuntu2404",
  ]

  provisioner "shell" {
    script = "${path.root}/setup.sh"
  }

  provisioner "ansible-local" {
    playbook_dir  = "ansible"
    playbook_file = "${path.root}/main.yml"
  }
}
