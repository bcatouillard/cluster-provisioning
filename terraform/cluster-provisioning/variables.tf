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

variable "instances" {
  type        = list(any)
  default     = [{ name : "compute-controlplane", label : "controlplane" }, { name : "compute-node01", label : "node" }, { name : "compute-node02", label : "node" }, ]
  description = "GCP Compute Engines instances list"
}
