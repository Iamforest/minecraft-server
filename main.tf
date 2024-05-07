provider "azurerm" {
  features {}
}

# create a resource group called 'rg-minecraftserver' in US east

resource "azurerm_resource_group" "rg-mc" {
  name = "rg-minecraftserver"
  location = "eastus"
}

# Create the azure file share https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share
resource "azurerm_storage_account" "storage-mc" {
  name = "storageminecraft"
  resource_group_name = azurerm_resource_group.rg-mc.name
  location = azurerm_resource_group.rg-mc.location
  account_tier = "Standard"
  account_replication_type = "LRS"
}
# File share that houses minecraft world
resource "azurerm_storage_share" "share-mc" {
  name = "share-minecraft-worlds"
  storage_account_name = azurerm_storage_account.storage-mc.name
  quota = 20
}

# create the container group and in that group create a container
resource "azurerm_container_group" "cg-mc" {
  name = "cg-minecraft"
  location = azurerm_resource_group.rg-mc.location
  resource_group_name = azurerm_resource_group.rg-mc.name
  ip_address_type = "Public"
  os_type = "Linux"

  # this is the container
  container {
    name = "container-minecraft"
    image = "iamforest/azure-minecraft:latest"
    cpu = "4"
    memory = "4" #### THIS WAS 2gb before
    
    # the port that minecraft servers use
    ports {
      port = 25565
      protocol = "TCP"
    }

    # the persistant storage where the minecraft files will be stored
    volume {
      name = "volume-minecraft"
      mount_path = "/minecraft/worlds"
      storage_account_name = azurerm_storage_account.storage-mc.name
      share_name = azurerm_storage_share.share-mc.name
      storage_account_key = azurerm_storage_account.storage-mc.primary_access_key
    }
  }
 }


 