resource "genesyscloud_flow" "call_park_agent_inbound_flow" {
  filepath          = "./modules/flows/call-park-agent-inbound-flow/call-park-agent-inbound-flow.yaml"
  file_content_hash = filesha256("./modules/flows/call-park-agent-inbound-flow/call-park-agent-inbound-flow.yaml")
  substitutions = {
    flow_name = "Call Park - Agent inbound flow"
  }

}
