#main.tf file

provider "aws" {
 region = "us-east-2"
}

terraform { 
 required_providers { 
  aws = { 
     source = "hashicorp/aws" 
     
     version = "~> 4.16"
   } 
  } 
required_version = ">= 1.2.0"
 }

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_manifest" "manifests" {
  for_each = toset(var.manifests)

  manifest = file(each.value)

  depends_on = [
    kubernetes_namespace.namespace,
  ]
} 