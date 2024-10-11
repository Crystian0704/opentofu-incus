variable "project_name" {
  type = string
}

variable "instance_names" {
  type = set(string)
}

variable "remote_name" {
  type = string
}

variable "memory" {
  type = string
}

variable "storage_pool" {
  type = string
}

variable "instance_images" {
  description = "Mapeia nomes de instâncias para suas respectivas imagens"
  type        = map(string)
}