variable "cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
  default     = "b1gp31d2a5js0d286632"
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID"
  default     = "b1gslb67oosr9ejfib5i"
}

variable "zone" {
  type        = string
  default     = "ru-central1-d"
  description = "Yandex Cloud zone"
}

variable "project_name" {
  type        = string
  default     = "yc-lab5"
  description = "Project name prefix"
}

variable "image_id" {
  type        = string
  description = "ID образа в Yandex Cloud (например Ubuntu 22.04)"
}

variable "ssh_public_key" {
  description = "Path to SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa_yc.pub"
}
