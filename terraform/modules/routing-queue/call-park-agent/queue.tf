resource "genesyscloud_routing_queue" "queue_call_park_agent" {
  name                     = var.queue_name
  description              = var.description
  acw_wrapup_prompt        = "MANDATORY_TIMEOUT"
  acw_timeout_ms           = 300000
  skill_evaluation_method  = "BEST"
  auto_answer_only         = true
  enable_transcription     = true
  enable_manual_assignment = true

  #Dynamically adding the members based on the pre-defined list of users
  dynamic "members" {
    for_each = var.classifier_queue_members

    content {
      user_id  = members.value
      ring_num = 1
    }
  }

}
