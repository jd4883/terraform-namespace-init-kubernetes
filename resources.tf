resource "kubernetes_namespace" "ns" {
  for_each = local.namespaces
  metadata {
    annotations = { name = each.value }
    name        = each.value
  }
}

resource "kubernetes_role_binding" "role_binding" {
  # used to ensure priveleged containers can be created
  for_each = local.grant_role_binding
  metadata {
    name      = lower(join("_", ["rolebinding-default-privileged-sa-ns", each.value]))
    namespace = each.value
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "psp:vmware-system-privileged"
  }
  subject {
    kind = "Group"
    name = "system:serviceaccounts"
  }
  depends_on = [kubernetes_namespace.ns]
}

resource "kubernetes_secret" "docker_config" {
  for_each = toset(concat(keys(local.namespaces), ["kube-system", "default"]))
  metadata {
    name      = "docker-cfg"
    namespace = each.value
  }
  data = {
    ".dockerconfigjson" = file(pathexpand("~/.docker/config.json"))
  }
  type = "kubernetes.io/dockerconfigjson"
}
