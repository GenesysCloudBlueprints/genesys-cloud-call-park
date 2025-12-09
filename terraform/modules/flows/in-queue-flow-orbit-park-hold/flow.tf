resource "genesyscloud_flow" "in_queue_flow_orbit_park_hold" {
  filepath          = "./modules/flows/in-queue-flow-orbit-park-hold/in-queue-orbit-call-park-hold.yaml"
  substitutions = {
    flow_name     = var.flow_name
    division_name = var.division_name
  }
}
