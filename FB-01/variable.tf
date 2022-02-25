variable "location" {
  type = string
}


variable "hubrg" {
  type = string
}

variable "spoke1rg" {
  type = string
}


variable "spoke2rg" {
  type = string
}

variable "spoke3rg" {
  type = string
}

variable "hubvnet" {
  type = string
}

variable "spoke1vnet" {
  type = string
}

variable "spoke2vnet" {
  type = string
}

variable "spoke3vnet" {
  type = string
}


variable "snethubmgmt" {
  type = string
}
variable "snethubad" {
  type = string
}
variable "snethubsec" {
  type = string
}
variable "snetspoke1web" {
  type = string
}
variable "snetspoke1app" {
  type = string
}
variable "snetspoke1db" {
  type = string
}
variable "snetspoke2web" {
  type = string
}
variable "snetspoke2app" {
  type = string
}
variable "snetspoke2db" {
  type = string
}
variable "snetspoke3web" {
  type = string
}
variable "snetspoke3app" {
  type = string
}
variable "snetspoke3db" {
  type = string
}





variable "nsghubmgmt" {
  type = string
}
variable "nsghubad" {
  type = string
}
variable "nsghubsec" {
  type = string
}
variable "nsgspoke1web" {
  type = string
}
variable "nsgspoke1app" {
  type = string
}
variable "nsgspoke1db" {
  type = string
}
variable "nsgspoke2web" {
  type = string
}
variable "nsgspoke2app" {
  type = string
}
variable "nsgspoke2db" {
  type = string
}
variable "nsgspoke3web" {
  type = string
}
variable "nsgspoke3app" {
  type = string
}
variable "nsgspoke3db" {
  type = string
}

variable "cidrvnet" {
  type = list(string)
}

variable "cidrhub" {
  type = list(string)
}

variable "cidrspoke1" {
  type = list(string)
}

variable "cidrspoke2" {
  type = list(string)
}

variable "cidrspoke3" {
  type = list(string)
}














