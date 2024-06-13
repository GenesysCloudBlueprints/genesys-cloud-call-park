resource "genesyscloud_flow" "call-park-agent-inbound-flow" {
  filepath          = "./modules/flows/call-park-agent-inbound-flow/call-park-agent-inbound-flow.yaml"
  file_content_hash = filesha256("./modules/flows/call-park-agent-inbound-flow/call-park-agent-inbound-flow.yaml")
  substitutions = {
    flow_name = "Call Park - Agent inbound flow"
  }

}
