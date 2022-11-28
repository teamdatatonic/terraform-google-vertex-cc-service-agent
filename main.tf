terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }

    http = {
      source  = "hashicorp/http"
      version = ">= 2.2.0"
    }
  }
}

# Auth token for HTTP request to Vertex API
data "google_client_config" "default" {

}

# Get project number from project ID - used to create output
data "google_project" "project" {
    project_id = var.project_id
}

locals {
    custom_job = {
        jobSpec = {
            workerPoolSpecs = [
                {
                    containerSpec = {
                        imageUri = "busybox:latest"
                        command = ["sh"]
                        args = []
                    }
                    replicaCount = 1
                    machineSpec = {
                        machineType = "n1-standard-4"
                    }
                }
            ]
        }
        displayName = "(Created by Terraform) Vertex AI Custom Code Service Agent activation"
    }
}

resource "null_resource" "service_agent" {
  provisioner "local-exec" {
    command = "curl -d '${jsonencode(local.custom_job)}' -H \"Content-Type: application/json\" -H \"Authorization: Bearer ${data.google_client_config.default.access_token}\" -X POST https://${var.region}-aiplatform.googleapis.com/v1/projects/${var.project_id}/locations/${var.region}/customJobs"
    when = create
  }
}
