

output "location" {
    value = "I live in ${var.location}"
}

output "name" {
    value = "My name is ${var.name}"
} 

output "users" {
    value = "Primary user is ${var.users[0]}"
}


output "Functions" {
    value = "${join("-->",var.users)}"
}


output "Upper" {
    value = "${upper(var.users[2])}"
}

output "Lower" {
    value = "${lower(var.users[1])}"
}

output "Title" {
    value = "${title(var.users[0])}"
}


output "Mapage" {
    value = "My name is ${var.name} and my age is ${lookup(var.mapusers, "Sourabh")}"
}


output "username" {
    value = "My name is ${var.username} and my age is ${lookup(var.mapusers, "${var.username}")}"
}



