target "docker-metadata-action" {}

target "bake-platform" {
  inherits = ["docker-metadata-action"]
  context = "jupyter-pyspark"
  dockerfile = "cpu.Dockerfile"
  platforms = [
    "linux/amd64",
  ]
}
