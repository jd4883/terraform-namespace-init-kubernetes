locals {
  namespaces         = { for ns in distinct([for i in var.charts : i if !contains(["default", "kube-system"], lookup(i, "namespace", "default"))].*.namespace) : ns => ns } # parses out all namespaces we need
  grant_role_binding = { for role in distinct(concat([for i in var.charts : lookup(i, "namespace", "default")], ["default"])) : role => role }                              # determines what namespaces we use and binds a role
}
