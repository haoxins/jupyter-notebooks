target "docker-metadata-action" {}

target "bake-platform" {
  inherits = ["docker-metadata-action"]
  context = "base"
  dockerfile = "Dockerfile"
  platforms = [
    "linux/amd64",
  ]
}
