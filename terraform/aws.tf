module "data-plane-aws" {
  source                    = "iomete/data-plane-aws/aws"
  version                   = "~> 2.2.0"


  # Change below values to your preferred values

  # AWS region
  region                    = "us-east-1"
  # Cluster name: used as a prefix for all the resources created by the module (VPC, subnets, EKS, etc.)
  cluster_name              = "lakehouse"
  # Lakehouse Bucket Name. Make sure it is unique
  lakehouse_bucket_name     = "lakehouse-bucket"
}


# Outputs. You can use these outputs to connect to your EKS cluster using kubectl
output "cluster_name" {
  description = "Kubernetes cluster name"
  value       = module.data-plane-aws.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = module.data-plane-aws.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate cluster with the IOMETE controlplane"
  value       = module.data-plane-aws.cluster_certificate_authority_data
}