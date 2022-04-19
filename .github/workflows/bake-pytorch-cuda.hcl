target "docker-metadata-action" {}

target "bake-platform" {
  inherits = ["docker-metadata-action"]
  context = "pytorch"
  dockerfile = "cuda.Dockerfile"
  platforms = [
    "linux/amd64",
  ]
}
