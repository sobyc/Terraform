
variable "location" {
  type = string
}

variable "hubvnetrgname" {
  type = string
}

variable "global_tags" {
  type        = map(any)
  description = "(Optional) A map of tags to be applied globally on all Azure resource groups"
  default     = {}
}

variable "vnetname" {
  type = string
}


variable "vnetcidr" {
  type = list(string)
}

