resource "genesyscloud_routing_queue" "queue_callparkagentinboundqueue" {
  name                     = var.queue_name
  description              = var.description
  acw_wrapup_prompt        = "MANDATORY_TIMEOUT"
  acw_timeout_ms           = 300000
  skill_evaluation_method  = "BEST"
  auto_answer_only         = true
  enable_transcription     = true
  enable_manual_assignment = true

}
