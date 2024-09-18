resource "genesyscloud_script" "script" {
  script_name       = var.script_name
  filepath          = "${path.module}/orbit-queue-transfer.json"
  file_content_hash = filesha256("${path.module}/orbit-queue-transfer.json")
  substitutions = {

    name             = var.script_name
    data_action_name = var.data_action_name
    data_action_id   = var.data_action_id
    org_id           = var.org_id
    queue_id         = var.queue_id
  }

}
