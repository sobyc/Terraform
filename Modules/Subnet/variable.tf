variable "azurerm_subnet" {
  type = string
  default = "default"
}

variable "cidrsnet" {
  type = list(string)
}


variable "rgname" {
  type = string
}


variable "vnetname" {
  type = string
}


variable "tags" {
  type        = map(any)
  description = "(Optional) A map of tags to be applied globally on all Azure resource groups"
  default     = {}
}