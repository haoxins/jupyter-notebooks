target "docker-metadata-action" {}

target "bake-platform" {
  inherits = ["docker-metadata-action"]
  context = "tensorflow-full"
  dockerfile = "Dockerfile"
  platforms = [
    "linux/amd64",
  ]
}
