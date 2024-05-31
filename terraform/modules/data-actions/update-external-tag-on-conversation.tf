resource "genesyscloud_integration_action" "update-external-tag-on-conversation" {
  name                   = "Get Waiting Calls in specific Queue based on External Tag"
  category               = module.integration.integration_name
  integration_id         = module.integration.integration_id
  contract_input = jsonencode({
    "type" = "object",
    "required" = [
      "startDate", "endDate", "externalTag", "holdingQueueId"
    ],
    "properties" = {
      "startDate" = {
        "type" = "string"
      },
      "endDate" = {
        "type" = "string"
      }
    },
      "externalTag" = {
        "type" = "string"
      },
        "holdingQueueId" = {
        "type" = "string"
      }
  })
  contract_output = jsonencode({
    "type" = "object",
    "required" = [],
    "properties" = {
        "conversationID" = {
        "type" = "array"
        "items" = {
                "title" = "ID",
                "type" = "string"
            }
      },
        "participantID" = {
        "type" = "array"
        "items" = {
                "title" = "ID",
                "type" = "string"
            }
      }
    }
  })
  config_request {
    request_url_template = "/api/v2/conversations/${input.conversationId}/tags"
    request_type         = "POST"
    request_template     = "externalTag": "${input.externalTag}"
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