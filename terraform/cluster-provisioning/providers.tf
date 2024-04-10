terraform {
  backend "gcs" {
    bucket = "bcatouillard-gke-tfstate"
    prefix = "tfstate"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.17.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
