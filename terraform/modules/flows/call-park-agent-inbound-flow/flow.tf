resource "genesyscloud_flow" "call_park_agent_inbound_flow" {
  filepath          = "./modules/flows/call-park-agent-inbound-flow/call-park-agent-inbound-flow.yaml"
  file_content_hash = filesha256("./modules/flows/call-park-agent-inbound-flow/call-park-agent-inbound-flow.yaml")
  substitutions = {
    flow_name          = var.flow_name
    division_name      = var.division_name
    in_queue_flow_name = var.in_queue_flow_name
    queue_name         = var.queue_name

  }

}
