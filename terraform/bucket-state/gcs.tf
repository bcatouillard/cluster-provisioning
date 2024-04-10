resource "google_storage_bucket" "auto-expire" {
  name          = "bcatouillard-gke-tfstate"
  location      = "US"
  force_destroy = true
  labels = {
    created-by = "terraform"
  }
}
