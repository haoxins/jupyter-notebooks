target "docker-metadata-action" {}

target "bake-platform" {
  inherits = ["docker-metadata-action"]
  context = "tensorflow"
  dockerfile = "Dockerfile"
  platforms = [
    "linux/amd64",
  ]
}
