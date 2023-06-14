target "docker-metadata-action" {}

target "bake-platform" {
  inherits = ["docker-metadata-action"]
  context = "jupyter-310"
  dockerfile = "Dockerfile"
  platforms = [
    "linux/amd64",
  ]
}
