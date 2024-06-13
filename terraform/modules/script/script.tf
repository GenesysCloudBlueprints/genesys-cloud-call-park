resource "genesyscloud_script" "script" {
  script_name       = "Orbit Queue Transfer 1"
  filepath          = "${path.module}/orbit-queue-transfer.script"
  file_content_hash = filesha256("${path.module}/orbit-queue-transfer.script")
  substitutions = {
    name = "Orbit Queue Transfer"
    # queue_id  = data.genesyscloud_routing_queue.queue.id
    # org_id    = var.org_id
  }

}
