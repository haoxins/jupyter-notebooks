target "docker-metadata-action" {}

target "bake-platform" {
  inherits = ["docker-metadata-action"]
  context = "scipy"
  dockerfile = "Dockerfile"
  platforms = [
    "linux/amd64",
  ]
}
