terraform {
  required_providers {
    genesyscloud = {
      source  = "mypurecloud/genesyscloud"
      version = "1.39.0"
    }
  }
}

/*
  Create a Data Action integration
*/
module "data_action" {
  source           = "git::https://github.com/GenesysCloudDevOps/public-api-data-actions-integration-module?ref=main"
  integration_name = "Orbit Data Actions OAuth Integration"
  # integration_creds_client_id     = var.client_id
  # integration_creds_client_secret = var.client_secret
  integration_creds_client_id     = "aa77235c-d413-4349-8330-c292247c58a6"
  integration_creds_client_secret = "2zJa-p-qcI2gLbEQDwy5y-uTWdDw0DifSk8n1h5Qr5o"
}

/*
  Get Waiting Calls
*/
module "get_waiting_calls" {
  source          = "./modules/data-actions/get-waiting-calls-in-specific-queue-based-on-external-tag"
  action_name     = "Get Waiting Calls on Specific Queue Base on External Tag"
  action_category = module.data_action.integration_name
  integration_id  = module.data_action.integration_id
}

/*
  Replace Participant With ANI
*/
module "replace_participant_with_ani" {
  source          = "./modules/data-actions/replace-participant-with-ani"
  action_name     = "Replace Participant with ANI"
  action_category = module.data_action.integration_name
  integration_id  = module.data_action.integration_id
}


/*
  Update External Tag Conversation
*/
module "update_external_tag_conversation" {
  source          = "./modules/data-actions/update-external-tag-on-conversation"
  action_name     = "Update External Tag on Conversation"
  action_category = module.data_action.integration_name
  integration_id  = module.data_action.integration_id
}

/*
  Default In-queue flow
*/
resource "genesyscloud_flow" "default-in-queue-flow" {
  filepath          = "./modules/flows/in-queue-flow/default-in-queue-flow.yaml"
  file_content_hash = filesha256("./modules/flows/in-queue-flow/default-in-queue-flow.yaml")
  substitutions = {
    flow_name = "Default In-Queue Flow 1"
  }

}

/*
  Call Park - Agent inbound Flow
*/
resource "genesyscloud_flow" "call-park-agent-inbound-flow" {
  filepath          = "./modules/flows/call-park-agent-inbound-flow/call-park-agent-inbound-flow.yaml"
  file_content_hash = filesha256("./modules/flows/call-park-agent-inbound-flow/call-park-agent-inbound-flow.yaml")
  substitutions = {
    flow_name = "Call Park - Agent inbound flow"
  }

}



/*
  In-queue flow orbit parked hold
*/
# resource "genesyscloud_flow" "flow-2" {
#   filepath          = "./modules/flows/in-queue-flow-orbit-park-hold/in-queue-orbit-call-park-hold.yaml"
#   file_content_hash = filesha256("./modules/flows/in-queue-flow-orbit-park-hold/in-queue-orbit-call-park-hold.yaml")
#   substitutions = {
#     flow_name = "InQueue - Orbit Call Park Hold"
#   }

# }


module "archy_flow" {
  source               = "./modules/flows/orbit-parked-call-retrieval"
  data_action_category = module.data_action.integration_name
  data_action_name_1   = module.get_waiting_calls.action_name
  data_action_name_2   = module.replace_participant_with_ani.action_name
  data_action_name_3   = module.update_external_tag_conversation.action_name

}

# # Add a Script
# resource "genesyscloud_script" "script" {
#   script_name       = "Schedule Callback"
#   filepath          = "${path.module}/schedule-callback-script.json"
#   file_content_hash = filesha256("${path.module}/schedule-callback-script.json")
#   substitutions = {
#     name = "Schedule Callback"
#     # queue_id  = data.genesyscloud_routing_queue.queue.id
#     # org_id    = var.org_id
#   }

# }






