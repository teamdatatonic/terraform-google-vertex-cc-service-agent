output "email" {
  value = "service-${data.google_project.project.number}@gcp-sa-aiplatform-cc.iam.gserviceaccount.com"
  depends_on = [
    null_resource.service_agent
  ]
}
