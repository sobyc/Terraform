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
    default = [ "172.21.0.0/24" ]
 
}