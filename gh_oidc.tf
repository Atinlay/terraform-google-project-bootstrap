module "gh_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = var.google_project_id
  pool_id     = "${var.name}-pool"
  provider_id = "${var.name}-gh-provider"
  sa_mapping = {
    "${var.name}-service-account" = {
      sa_name   = google_service_account.github_service_account.id
      attribute = "attribute.repository/${local.gh_username}/${var.name}"
    }
  }
}

resource "google_service_account" "github_service_account" {
  account_id   = "${var.name}-gh-service-account"
  display_name = "Service Account for GitHub project ${var.name}"
}

resource "google_project_iam_member" "project" {
  project = var.google_project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.github_service_account.email}"
}
