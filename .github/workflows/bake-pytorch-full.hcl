target "docker-metadata-action" {}

target "bake-platform" {
  inherits = ["docker-metadata-action"]
  context = "pytorch-full"
  dockerfile = "Dockerfile"
  platforms = [
    "linux/amd64",
  ]
}
