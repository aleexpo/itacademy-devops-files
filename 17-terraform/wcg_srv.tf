resource "kubernetes_service" "wcg" {
  metadata {
    name = "wcg-service"
  }
  spec {
    selector = {
      App = "wcg"
    }
    port {
      node_port   = 30088
      port        = 8888
      target_port = 8888
    }

    type = "NodePort"
  }
}