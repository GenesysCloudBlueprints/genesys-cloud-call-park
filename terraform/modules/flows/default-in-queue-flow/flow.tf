resource "genesyscloud_flow" "default_in_queue_flow" {
  filepath          = "./modules/flows/default-in-queue-flow/default-in-queue-flow.yaml"
  file_content_hash = filesha256("./modules/flows/default-in-queue-flow/default-in-queue-flow.yaml")
  substitutions = {
    flow_name = "Default In-Queue Flow 1"
  }

}
