target "docker-metadata-action" {}

target "bake-platform" {
  inherits = ["docker-metadata-action"]
  context = "jupyter-tensorflow"
  dockerfile = "cuda.Dockerfile"
  platforms = [
    "linux/amd64",
  ]
}
