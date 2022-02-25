variable "name" {
    type = string
    default= "Soby"
}

variable "location" {
    type = string
    default = "Central India"
  
}

variable "users" {
    type = list
    default = ["souRAbh","Manvik","Swati"]
}

variable "mapusers" {
    type = map
    default = {
    Sourabh = 37
    Manvik = 7
    }
}


variable "username" {
    type = string
}