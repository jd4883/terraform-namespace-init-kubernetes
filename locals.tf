locals {
  namespaces         = { for ns in distinct([for i in var.charts : i if !contains(var.skip_ns, i.namespace)].*.namespace) : ns => ns } # parses out all namespaces we need
  grant_role_binding = { for role in distinct(concat([for i in var.charts : i.namespace], var.fixed_role_ns)) : role => role }         # determines what namespaces we use and binds a role
}
