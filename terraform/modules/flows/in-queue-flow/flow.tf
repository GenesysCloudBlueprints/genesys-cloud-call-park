resource "genesyscloud_flow" "default-in-queue-flow" {
  filepath          = "./modules/flows/in-queue-flow/default-in-queue-flow.yaml"
  file_content_hash = filesha256("./modules/flows/in-queue-flow/default-in-queue-flow.yaml")
  substitutions = {
    flow_name = "Default In-Queue Flow 1"
  }

}
