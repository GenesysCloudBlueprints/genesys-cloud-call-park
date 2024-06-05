/*
  Creates the action
*/
resource "genesyscloud_integration_action" "get_waiting_calls" {
  name           = var.action_name
  category       = var.action_category
  integration_id = var.integration_id
  contract_input = jsonencode({
    "type" = "object",
    "properties" = {
      "startDate" = {
        "type" = "string"
      },
      "endDate" = {
        "type" = "string"
      },
      "externalTag" = {
        "type" = "string"
      },
      "holdingQueueId" = {
        "type" = "string"
      }

    }
  })
  contract_output = jsonencode({
    "type" = "object",
    "properties" = {
      "conversationID" = {
        "type" = "array"
        "items" = {

          "type" = "string"

        }
      },
      "participantID" = {
        "type" = "array"
        "items" = {

          "type" = "string"

        }
      }
    }
  })


  config_request {
    # Use '$${' to indicate a literal '${' in template strings. Otherwise Terraform will attempt to interpolate the string
    # See https://www.terraform.io/docs/language/expressions/strings.html#escape-sequences
    request_url_template = "/api/v2/analytics/conversations/details/query"
    request_type         = "POST"
    request_template     = "{\n \"interval\": \"$${input.startDate}/$${input.endDate}\",\n \"order\": \"asc\",\n \"orderBy\": \"conversationStart\",\n \"paging\": {\n  \"pageSize\": 25,\n  \"pageNumber\": 1\n },\n \"segmentFilters\": [\n  {\n   \"type\": \"and\",\n   \"clauses\": [\n    {\n     \"type\": \"and\",\n     \"predicates\": [\n      {\n       \"type\": \"dimension\",\n       \"dimension\": \"disconnectType\",\n       \"operator\": \"notExists\",\n       \"value\": null\n      }\n     ]\n    }\n   ],\n   \"predicates\": [\n    {\n     \"type\": \"dimension\",\n     \"dimension\": \"queueId\",\n     \"operator\": \"matches\",\n     \"value\": \"$${input.holdingQueueId}\"\n    },\n    {\n     \"type\": \"dimension\",\n     \"dimension\": \"segmentType\",\n     \"operator\": \"matches\",\n     \"value\": \"interact\"\n    }\n   ]\n  }\n ],\n \"conversationFilters\": [\n  {\n   \"type\": \"and\",\n   \"predicates\": [\n    {\n     \"type\": \"dimension\",\n     \"dimension\": \"externalTag\",\n     \"operator\": \"matches\",\n     \"value\": \"$${input.externalTag}\"\n    }\n   ]\n  }\n ]\n}"
    headers              = {}
  }
  config_response {
    translation_map = {
      participantID  = "$..participants[?(@.purpose == 'acd' && @.sessions[0].flowInType == 'agent')].participantId"
      conversationID = "$..conversationId"
    }
    translation_map_defaults = {
      participantID  = "",
      conversationID = ""
    }
    success_template = "{\"conversationID\":$${conversationID},\"participantID\":$${participantID}}"
  }
}
