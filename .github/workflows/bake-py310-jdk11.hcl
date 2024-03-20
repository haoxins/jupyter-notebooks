target "docker-metadata-action" {}

target "bake-platform" {
  inherits = ["docker-metadata-action"]
  context = "py310-jdk11"
  dockerfile = "py310-jdk11.Dockerfile"
  platforms = [
    "linux/amd64",
  ]
}
