# Input variable definitions

variable "az_region" {
  type        = string
  description = "Set here the region where to deploy your resource"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}
