variable "project_id" {
  description = "project id"
  type        = string
  default     = "kubernetes-terraform-369708"
}

variable "region" {
  description = "region"
  type        = string
  default     = "us-central1"
}

variable "instances" {
  description = "instances list"
  type        = list(any)
  default     = [{ name : "compute-controlplane", label : "controlplane" }, { name : "compute-node01", label : "node" }, { name : "compute-node02", label : "node" }, ]
}
