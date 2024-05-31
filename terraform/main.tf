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
module "action-1" {
  source          = "./modules/data-actions/get-waiting-calls-in-specific-queue-based-on-external-tag"
  action_name     = "Get Waiting Calls on Specific Queue Base on External Tag"
  action_category = module.data_action.integration_name
  integration_id  = module.data_action.integration_id
}

/*
  Replace Participant With ANI
*/
module "action-2" {
  source          = "./modules/data-actions/replace-participant-with-ani"
  action_name     = "Repalce Participant with ANI"
  action_category = module.data_action.integration_name
  integration_id  = module.data_action.integration_id
}


/*
  Replace Participant With ANI
*/
module "action-3" {
  source          = "./modules/data-actions/update-external-tag-on-conversation"
  action_name     = "Update External Tag on Conversation"
  action_category = module.data_action.integration_name
  integration_id  = module.data_action.integration_id
}


# resource "genesyscloud_flow" "Default In-Queue_Flow" {
#   filepath          = "./terraform-ivr/Default In-Queue_Flow.yaml"
#   file_content_hash = filesha256("./terraform-ivr/Default In-Queue_Flow.yaml")
# }

# resource "genesyscloud_flow" "InQueue -Orbit_ Call_Park_Hold" {
#   filepath          = "./terraform-ivr/InQueue -Orbit_ Call_Park_Hold.yaml"
#   file_content_hash = filesha256("./terraform-ivr/InQueue -Orbit_ Call_Park_Hold.yaml")
# }

# // add queue here

# resource "genesyscloud_flow" "Orbit-Parked_Call_Retrieval" {
#   filepath          = "./terraform-ivr/Orbit-Parked_Call_Retrieval.yaml"
#   file_content_hash = filesha256("./terraform-ivr/Orbit-Parked_Call_Retrieval.yaml")
# }








