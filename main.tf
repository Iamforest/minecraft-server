# create a resource group called 'rg-minecraftserver' in US east

resource "azurerm_resource_group" "rg-mc" {
  name = "rg-minecraftserver"
  location = "US East"
}

# create the container group and in that group create a container
 