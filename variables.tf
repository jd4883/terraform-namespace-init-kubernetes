variable "charts" { type = any }

variable "labels" {
  default = {}
  type    = map(string)
}
