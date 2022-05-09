resource "kubernetes_service" "wcg" {
  metadata {
    name = "wcg-service"
  }
  spec {
    selector = {
      App = kubernetes_deployment.wcg-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30088
      port        = 8888
      target_port = 8888
    }

    type = "NodePort"
  }
}