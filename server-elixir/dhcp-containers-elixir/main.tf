
resource "incus_project" "this" {
  name        = var.project_name
  description = "Project used to test incus-deploy"
  remote = var.remote_name
  config = {
    "features.images"          = false
    "features.networks"        = false
    "features.networks.zones"  = false
    "features.profiles"        = true
    "features.storage.buckets" = false
    "features.storage.volumes" = false
  }
}

resource "incus_profile" "this" {
  project     = incus_project.this.name
  name        = "tofu"
  remote      = var.remote_name
  description = "Profile usado para testar o OpenTofu"

  config = {
    "limits.cpu"    = "2"
    "limits.memory" = var.memory
  }

  device {
    type = "disk"
    name = "root"

    properties = {
      "pool" = var.storage_pool
      "path" = "/"
    }
  }

  device {
    type = "nic"
    name = "eth0"

    properties = {
      "network" = "incusbr0"
      "name"    = "eth0"
    }
  }
}

resource "incus_instance" "instances" {
  for_each = var.instance_names

  project  = incus_project.this.name
  name     = each.value
  image    = var.instance_images[each.value]  # Usando o mapa de imagens
  profiles = ["default", incus_profile.this.name]
  remote = var.remote_name

  lifecycle {
    ignore_changes = [running]
  }
}

