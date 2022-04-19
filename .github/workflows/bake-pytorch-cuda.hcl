target "docker-metadata-action" {}

target "bake-platform" {
  inherits = ["docker-metadata-action"]
  context = "tensorflow-full"
  dockerfile = "cuda.Dockerfile"
  platforms = [
    "linux/amd64",
  ]
}
