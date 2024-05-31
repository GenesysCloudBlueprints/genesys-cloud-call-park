resource "genesyscloud_integration_action" "action-2" {
  name           = var.action_name
  category       = var.action_category
  integration_id = var.integration_id
  contract_input = jsonencode({
    "type" = "object",
    "required" = [
      "conversationId", "participantId", "address"
    ],
    "properties" = {
      "conversationId" = {
        "type" = "string"
      },
      "participantId" = {
        "type" = "string"
      },
      "address" = {
        "type" = "string"
      }
    }
  })
  contract_output = jsonencode({
    "type"       = "object",
    "properties" = {}
  })
  config_request {
    request_url_template = "/api/v2/conversations/$${input.conversationId}/participants/$${input.participantId}/replace"
    request_type         = "POST"
    request_template     = ""
    headers = {
      Cache-Control = "no-cache"
      Content-Type  = "application/json"
      UserAgent     = "PureCloudIntegrations/1.0"
    }
  }
  config_response {
    translation_map          = {}
    translation_map_defaults = {}
    success_template         = "$${rawResult}"
  }
}
