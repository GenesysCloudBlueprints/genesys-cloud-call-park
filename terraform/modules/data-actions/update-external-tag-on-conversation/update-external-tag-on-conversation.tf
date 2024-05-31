resource "genesyscloud_integration_action" "action-3" {
  name           = var.action_name
  category       = var.action_category
  integration_id = var.integration_id
  contract_input = jsonencode({
    "type" = "object",
    "properties" = {
      "conversationId" = {
        "type" = "string"
      },
      "externalTag" = {
        "type" = "string"
      }
    }
  })
  contract_output = jsonencode({
    "type"       = "object",
    "properties" = {}
  })
  config_request {
    request_url_template = "/api/v2/conversations/$${input.conversationId}/tags"
    request_type         = "PUT"
    request_template     = "{\n  \"externalTag\": \"$${input.externalTag}\"\n}"
    headers = {
      Cache-Control = "no-cache"
      Content-Type  = "application/json"
      UserAgent     = "PureCloudIntegrations/1.0"
    }
  }
  config_response {
    translation_map          = {}
    translation_map_defaults = {}
    success_template         = "{rawResult}"
  }
}
