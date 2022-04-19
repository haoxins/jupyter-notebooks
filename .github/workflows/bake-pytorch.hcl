target "docker-metadata-action" {}

target "bake-platform" {
  inherits = ["docker-metadata-action"]
  context = "jupyter-pytorch"
  dockerfile = "cpu.Dockerfile"
  platforms = [
    "linux/amd64",
  ]
}
