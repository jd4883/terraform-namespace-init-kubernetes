variable "charts" { type = map(object({ namespace = optional(string, "default") })) }
variable "docker_config" { type = string }

variable "labels" {
  default = {}
  type    = map(string)
}

variable "skip_ns" {
  default = [
    "default",
    "kube-system"
  ]
  type = list(string)
}

variable "fixed_role_ns" {
  default = ["default"]
  type    = list(string)
}
