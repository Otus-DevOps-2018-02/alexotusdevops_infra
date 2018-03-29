resource "google_compute_instance_group" "reddit-group" {
  name        = "reddit-group"
  zone        = "${var.zone}"
  description = "Reddit app group"

  instances = ["${google_compute_instance.app.*.self_link}"]

  named_port {
    name = "reddit-port"
    port = "9292"
  }
}

resource "google_compute_global_forwarding_rule" "reddit-forward-rule" {
  name       = "reddit-forward-rule"
  target     = "${google_compute_target_http_proxy.reddit-proxy.self_link}"
  port_range = "80"
}

resource "google_compute_target_http_proxy" "reddit-proxy" {
  name        = "reddit-proxy"
  description = "Reddit proxy"
  url_map     = "${google_compute_url_map.reddit-url-map.self_link}"
}

resource "google_compute_url_map" "reddit-url-map" {
  name            = "reddit-url-map"
  description     = "Reddit url map"
  default_service = "${google_compute_backend_service.reddit-backend.self_link}"

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = "${google_compute_backend_service.reddit-backend.self_link}"

    path_rule {
      paths   = ["/*"]
      service = "${google_compute_backend_service.reddit-backend.self_link}"
    }
  }
}

resource "google_compute_http_health_check" "app-health-check" {
  name               = "app-health-check"
  request_path       = "/"
  port               = "9292"
  timeout_sec        = 5
  check_interval_sec = 5
}

resource "google_compute_backend_service" "reddit-backend" {
  name        = "reddit-backend"
  port_name   = "reddit-port"
  protocol    = "HTTP"
  timeout_sec = "5"

  health_checks = ["${google_compute_http_health_check.app-health-check.self_link}"]

  backend {
    group = "${google_compute_instance_group.reddit-group.self_link}"
  }
}
