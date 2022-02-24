rgname = "rg-eus-dev-01"
location = "eastus"
vnetname = "vnet-eus-dev-01"
vnetcidr   = ["172.25.3.0/24"]
snetcidr   = ["172.25.3.0/28", "172.25.3.16/28", "172.25.3.32/28"]
snet1name = "snet-eus-dev-web-01"
snet2name = "snet-eus-dev-app-01"
snet3name = "snet-eus-dev-db-01"
nsgsnet1 = "nsg-eus-dev-snet-web-01"
nsgsnet2 = "nsg-eus-dev-snet-app-01"
nsgsnet3 = "nsg-eus-dev-snet-db-01"









/*

application = "Terraform"
environment = "dev"
location = "westeurope"
capacity = 2
address_space = "172.25.3.0/24"
snetdevweb = "172.25.3.0/28"
snetdevapp = "172.25.3.16/28"
snetdevdb = "172.25.3.32/28"

*/