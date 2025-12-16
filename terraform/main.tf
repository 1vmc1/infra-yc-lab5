terraform {
  required_version = ">= 1.3.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.107.0"
    }
  }
}

# ИСПРАВЛЕНО: Использование service_account_key_file вместо token
provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_vpc_network" "this" {
  name = "${var.project_name}-network"
}

resource "yandex_vpc_subnet" "this" {
  name           = "${var.project_name}-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = ["10.0.0.0/24"]
}

resource "yandex_compute_instance" "vm" {
  name        = "${var.project_name}-vm"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 20
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.this.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key)}"
  }

  # ДОБАВЛЕНО: Явное указание на использование сервисного аккаунта (опционально)
  # service_account_id = "ajes8tm7itqqr60helq"
}

output "vm_external_ip" {
  value       = yandex_compute_instance.vm.network_interface.0.nat_ip_address
  description = "External IP of the VM"
}

output "vm_internal_ip" {
  value       = yandex_compute_instance.vm.network_interface.0.ip_address
  description = "Internal IP of the VM"
}
