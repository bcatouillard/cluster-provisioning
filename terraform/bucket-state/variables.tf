variable "project_id" {
  type        = string
  default     = "kubernetes-terraform-369708"
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "GCP Region"
}

variable "bucket_name" {
  type        = string
  default     = "bcatouillard-gke-cluster"
  description = "GCP Terraform State bucket name"
}
