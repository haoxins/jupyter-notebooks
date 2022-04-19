target "docker-metadata-action" {}

target "bake-platform" {
  inherits = ["docker-metadata-action"]
  context = "jupyter-tensorflow"
  dockerfile = "cpu.Dockerfile"
  platforms = [
    "linux/amd64",
  ]
}
