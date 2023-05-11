load("@io_bazel_rules_docker//container:image.bzl", "container_image")
load("@package_bundle//file:packages.bzl", "packages")

container_image(
    name = "elixir_base_image",
    base = "@distroless//base",
    debs = [
        packages["bash"],
        packages["coreutils"],
    ],
)
