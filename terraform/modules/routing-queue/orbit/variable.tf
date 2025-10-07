variable "queue_name" {
  type        = string
  description = "Name to associate with queue"
}

variable "description" {
  type        = string
  description = "Description to associate with queue"
}


variable "classifier_queue_members" {
  type        = list(string)
  description = "A list of member ids you want added to each queue."
}
