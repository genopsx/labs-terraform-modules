output "buildspecs" {
  description = "The available buildspecs"
  value       = { for bspecfile in fileset(path.module, "buildspecs/*.yml") : basename(trimsuffix(bspecfile, ".yml")) => file("${path.module}/${bspecfile}") }
}
