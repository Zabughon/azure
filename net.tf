resource "azurerm_virtual_network" "vnet" {
  name                = "${var.Var_vnet}"
  address_space       = ["${var.Var_Addr_Space}"]
  location            = "${local.var_rglocation}"
  resource_group_name = "${local.var_rgname}"
}
resource "azurerm_subnet" "subnet" {
  name                 = "${var.Var_Subnet}"
  resource_group_name  = "${local.var_rgname}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${var.Var_Addr_Prefix}"
}
 
resource "azurerm_network_security_group" "SecGR" {
    name                = "SecurityGroup"
    location            = "eastus"
    resource_group_name = "${local.var_rgname}"
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
     security_rule {
        name                       = "HTTPD"
        priority                   = 1011
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}
