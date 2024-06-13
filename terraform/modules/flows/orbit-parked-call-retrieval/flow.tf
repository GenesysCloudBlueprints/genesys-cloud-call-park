resource "genesyscloud_flow" "orbit_inbound_call_flow" {
  filepath          = "${path.module}/orbit-parked-call-retrieval.yaml"
  file_content_hash = filesha256("${path.module}/orbit-parked-call-retrieval.yaml")
  substitutions = {
    flow_name            = "{{flow_name}}"
    division             = "{{division}}"
    default_language     = "{{default_language}}"
    data_action_category = var.data_action_category
    data_action_name_1   = var.data_action_name_1
    data_action_name_2   = var.data_action_name_2
    data_action_name_3   = var.data_action_name_3

  }
}

