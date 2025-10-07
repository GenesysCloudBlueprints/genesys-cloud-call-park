resource "genesyscloud_flow" "orbit_parked_call_retrieval" {
  filepath          = "${path.module}/orbit-parked-call-retrieval.yaml"
  file_content_hash = filesha256("${path.module}/orbit-parked-call-retrieval.yaml")
  substitutions = {
    flow_name            = var.flow_name
    division_name        = var.division_name
    data_action_category = var.data_action_category
    data_action_name_1   = var.data_action_name_1
    data_action_name_2   = var.data_action_name_2
    data_action_name_3   = var.data_action_name_3
    queue_id             = var.queue_id
  }
}
