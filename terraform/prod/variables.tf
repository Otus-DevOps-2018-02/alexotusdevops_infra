variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable public_key_path {
  description = "Path to the public key user for ssh access"
}

variable private_key_path {
  description = "Path to the private key user for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-base-app"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-base-db"
}

variable machine_type {
  description = "GC machine type"
  default     = "g1-small"
}
