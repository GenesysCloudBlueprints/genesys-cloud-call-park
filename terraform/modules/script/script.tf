resource "genesyscloud_script" "orbit_queue_transfer" {
  script_name       = var.script_name
  filepath          = "${path.module}/orbit-queue-transfer.script"
  file_content_hash = filesha256("${path.module}/orbit-queue-transfer.script")
  substitutions = {
    data_action_name = var.data_action_name
    data_action_id   = var.data_action_id
  }

}
