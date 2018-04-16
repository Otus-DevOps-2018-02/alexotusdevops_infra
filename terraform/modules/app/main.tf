data "template_file" "reddit_app" {
    template = "${file("${path.module}/files/puma.service.tpl")}"

    vars {
	reddit_db_addr = "${var.reddit_db_addr}"
    }
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

#  provisioner "file" {
#    content     = "${data.template_file.reddit_app.rendered}"
#    destination = "/tmp/puma.service"
#  }

#  provisioner "remote-exec" {
#    script = "${path.module}/files/deploy.sh"
#  }
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}
