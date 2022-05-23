resource "kubernetes_deployment" "wcg-deployment" {
    metadata {
        name = "wcg-deployment"
        labels = {
            App = "wcg"
        }
    }

    spec {
        replicas = 1
        selector {
            match_labels = {
                App = "wcg"
            }
        }
        template {
            metadata {
                labels = {
                    App = "wcg"
                }
            }
            spec {
                container {
                    image = "wcg-big:latest"
                    name  = "wcg"
                    image_pull_policy = "IfNotPresent"

                    port {
                        container_port = 8888
                    }
                    resources {
                        limits = {
                            cpu    = "0.5"
                            memory = "512Mi"
                        }
                        requests = {
                            cpu    = "250m"
                            memory = "50Mi"
                        }
                    }
                }
            }
        }
    }
}