variable "rgname" {
  type = string
}

variable "location" {
  type = string
}

variable "vnetname" {
  type = string
}

variable "vnetcidr" {
  type = list(string)
}

variable "snet1name" {
  type = string
}

variable "snet2name" {
  type = string
}

variable "snet3name" {
  type = string
}

variable "snet4name" {
  type = string
}

variable "snet5name" {
  type = string
}

variable "snet6name" {
  type = string
}

variable "snet7" {
  type = string
}

variable "snet8name" {
  type = string
}

variable "snet9name" {
  type = string
}

variable "snet10name" {
  type = string
}


variable "snetcidr" {
  type = list(string)
}
/*
variable "pip" {
  type        = string
  description = "(Required) Public IP for the Bastion Host"
}
*/


variable "nsgsnet1" {
  type = string
}

variable "nsgsnet2" {
  type = string
}

variable "nsgsnet3" {
  type = string
}

