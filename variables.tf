variable "region" {
    type = string
    description = "Region in which to launch the Vertex AI CustomJob that is used to create the Vertex AI Custom Code Service Agent"
    default = "europe-west2"
}

variable "project_id" {
    type = string
    description = "Project ID for the Vertex AI Custom Code Service Agent"
}