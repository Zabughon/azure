output "Var_subid"{
   value = "${azurerm_subnet.subnet.id}"
}

output "Var_secgpid"{
   value = "${azurerm_network_security_group.SecGR.id}"
}
