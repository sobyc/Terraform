variable "rgname" {
  type        = string
  description = "(Required) Name of Resource Group"
}

variable "location" {
  type        = string
  description = "(Required) Location where we want to implement code"
}

variable "vnetname" {
  type        = string
  description = "(Required) Name of Virtual Network"
}


# Define bastion subnet addr prefix
variable "cidrsnet" {
  type = list(string)
  description = "(Required) Ip address range of subnet"
}

variable "pip" {
  type        = string
  description = "(Required) Public IP for the Bastion Host"
}

variable "bastionhost" {
  type        = string
  description = "(Required) Public IP for the Bastion Host"
}

variable "ip_allocation" {
  type        = string
  default     = "Static"
  description = "(Required) IP allocation method"
}

variable "sku" {
  type        = string
  default     = "Standard"
  description = "(Required) SKU type"
}

variable "bastion_tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) Tag which will associated to the Bastion Host."
}