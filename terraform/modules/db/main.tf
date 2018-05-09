resource "google_compute_instance" "db" {
  name         = "reddit-db"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  tags         = ["reddit-db"]

  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

#    provisioner "file" {
#      source = "${path.module}/files/mongod.conf"
#      destination = "/tmp/mongod.conf"
#    }

#    provisioner "remote-exec" {
#      inline = [
#        "sudo cp /tmp/mongod.conf /etc/mongod.conf",
#        "sudo service mongod restart",
#      ]
#  }
}


