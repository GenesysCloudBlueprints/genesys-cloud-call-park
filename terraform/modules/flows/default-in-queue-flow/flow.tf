resource "genesyscloud_flow" "default_in_queue_flow" {
  filepath          = "./modules/flows/default-in-queue-flow/default-in-queue-flow.yaml"
  file_content_hash = filesha256("./modules/flows/default-in-queue-flow/default-in-queue-flow.yaml")
  substitutions = {
    flow_name     = var.flow_name
    division_name = var.division_name
  }

}
