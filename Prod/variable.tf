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

variable "snetcidr" {
  type = list(string)
}

variable "nsgsnet1" {
  type = string
}

variable "nsgsnet2" {
  type = string
}

variable "nsgsnet3" {
  type = string
}