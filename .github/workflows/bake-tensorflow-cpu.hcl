target "docker-metadata-action" {}

target "bake-platform" {
  inherits = ["docker-metadata-action"]
  context = "pytorch"
  dockerfile = "cpu.Dockerfile"
  platforms = [
    "linux/amd64",
  ]
}
