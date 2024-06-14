resource "genesyscloud_flow" "in_queue_flow_orbit_park_hold" {
  filepath          = "./modules/flows/in-queue-flow-orbit-park-hold/in-queue-orbit-call-park-hold.yaml"
  file_content_hash = filesha256("./modules/flows/in-queue-flow-orbit-park-hold/in-queue-orbit-call-park-hold.yaml")
  substitutions = {
    flow_name = "InQueue - Orbit Call Park Hold"
  }

}
