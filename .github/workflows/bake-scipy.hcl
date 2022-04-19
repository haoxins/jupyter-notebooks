target "docker-metadata-action" {}

target "bake-platform" {
  inherits = ["docker-metadata-action"]
  context = "jupyter-scipy"
  dockerfile = "Dockerfile"
  platforms = [
    "linux/amd64",
  ]
}
