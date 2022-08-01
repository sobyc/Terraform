variable "rgname" {
    type = string
    description = "Name of resource group"
}

variable "location" {
    type = string
    description = "location of resource group"
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A map of tags to be applied globally on all Azure resource groups"
  default     = {}
}


