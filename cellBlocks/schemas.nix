{ blockTypes }:
with blockTypes; [
  (data "schemas-jsonschemas")
  (data "schemas-openapi")
  (data "schemas-swagger")
  (files "schemas")
]
