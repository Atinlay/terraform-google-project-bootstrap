locals {
  bucket_name_prefix = replace(var.google_project_id, "projects/", "")
}

resource "google_storage_bucket" "terraform-state" {
  name     = "${local.bucket_name_prefix}-terraform-state"
  location = "EU"

  uniform_bucket_level_access = true
}
