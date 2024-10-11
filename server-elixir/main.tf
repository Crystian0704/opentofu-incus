module "dhcp-containers-elixir" {
  source = "./dhcp-containers-elixir"

  project_name   = "elixir-dev"
  instance_names = ["sql1", "sql2"]
  memory         = "2GiB"
  storage_pool   = "btrfs-pool"
  remote_name = "elixir"
  instance_images = {
    sql1 = "images:ubuntu/22.04"
    sql2 = "images:debian/12"
  }
}
