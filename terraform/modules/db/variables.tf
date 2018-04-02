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

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-base-db"
}

variable machine_type {
  description = "GC Machine type"
  default     = "g1-small"
}

#variable db_internal_ip {
#  description = "Database IP"
#  default     = "0.0.0.0"
#}

