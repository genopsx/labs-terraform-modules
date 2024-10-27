variable "secrets" {
  description = "A map of secrets to fetch"
  type = map(object({
    name    = string
    version = optional(string, "AWSCURRENT")
  }))
  default = {}
}
