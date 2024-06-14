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
  source                          = "git::https://github.com/GenesysCloudDevOps/public-api-data-actions-integration-module?ref=main"
  integration_name                = "Orbit Data Actions OAuth Integration"
  integration_creds_client_id     = var.client_id
  integration_creds_client_secret = var.client_secret
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

module "default_in_queue_flow" {
  source = "./modules/flows/default-in-queue-flow"
}

/*
  Call Park - Agent inbound Flow
*/
module "call_park_agent_inbound_flow" {
  source = "./modules/flows/call-park-agent-inbound-flow"

}



/*
  In-queue flow orbit parked hold
*/
module "in_queue_flow_orbit_park_hold" {
  source    = "./modules/flows/in-queue-flow-orbit-park-hold"
  flow_name = "InQueue - Orbit Call Park Hold"
  # queue_id  = module.in_queue_flow_orbit_park_hold.flow_id

}


module "orbit_parked_call_retrieval" {
  source               = "./modules/flows/orbit-parked-call-retrieval"
  data_action_category = module.data_action.integration_name
  data_action_name_1   = module.get_waiting_calls.action_name
  data_action_name_2   = module.replace_participant_with_ani.action_name
  data_action_name_3   = module.update_external_tag_conversation.action_name
  queue_id             = module.in_queue_flow_orbit_park_hold.flow_id
  flow_name            = "Orbit - Parked Call Retrieval"

}

# # Add a Script

module "genesyscloud_script" {
  source = "./modules/script"
}





