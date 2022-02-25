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