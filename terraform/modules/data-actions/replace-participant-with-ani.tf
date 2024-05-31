resource "genesyscloud_integration_action" "replace-participant-with-ani" {
  name                   = "Replace participant with ANI"
  category               = module.integration.integration_name
  integration_id         = module.integration.integration_id
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
    "type" = "object",
    "required" = [],
    "properties" = {}
  })
  config_request {
    request_url_template = "/api/v2/conversations/${input.conversationId}/transferType/"Attended""
    request_type         = "POST"
    request_template     = ""
    headers = {
      Cache-Control = "no-cache"
      Content-Type  = "application/json"
      UserAgent     = "PureCloudIntegrations/1.0"
    }
  }
  config_response {
    translation_map = {}
    translation_map_defaults = { }
    success_template = ${rawResult}
  }
}