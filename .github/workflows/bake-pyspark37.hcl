target "docker-metadata-action" {}

target "bake-platform" {
  inherits   = ["docker-metadata-action"]
  context    = "jupyter-pyspark37"
  dockerfile = "Dockerfile"
  platforms  = [
    "linux/amd64",
  ]
}
