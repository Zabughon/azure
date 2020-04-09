
        resource "azurerm_public_ip" "RGrp_VM_PbIp1" {
        name                = "public_ip1"
        location            = "${local.var_rglocation}"
        resource_group_name = "${local.var_rgname}"
        allocation_method   = "Static"
        }

        resource "azurerm_network_interface" "nic1" {
        name                = "nic1"
        location            = "eastus"
        resource_group_name = "project1"
        network_security_group_id = "${local.var_secgpid}"


        ip_configuration {
            name                          = "testconfiguration1"
            subnet_id                     = "${local.var_subid}"
            private_ip_address_allocation = "Dynamic"
            public_ip_address_id          = "${azurerm_public_ip.RGrp_VM_PbIp1.id}"
        }
        }

        resource "azurerm_virtual_machine" "test1" {
        name                  = "acctvm1"
        location              = "eastus"
        resource_group_name   = "project1"
        network_interface_ids = ["${azurerm_network_interface.nic1.id}"]
        vm_size               = "Standard_DS1_v2"
        availability_set_id   = "${azurerm_availability_set.availability_set.id}"

        storage_image_reference {
        publisher = "OpenLogic"
        offer     = "CentOS"
        sku       = "7.7"
        version   = "latest"
        }

        storage_os_disk {
        name              = "osdisk1"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
        }


        os_profile {
        computer_name  = "acctvm1"
        admin_username = "project1"
        custom_data    = "${file("cloudinit.yml")}"
        }

        os_profile_linux_config {
        disable_password_authentication ="true"
        ssh_keys {
            path       = "/home/project1/.ssh/authorized_keys"
            key_data   = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAgEAlYe2LE0V8dULIx4NFttaDQelZDpldULQbU3GwUuFl/3RQDfolfyiDYO1Lj8niypBI8+5j0Tgvfgmer+3SzfKYXCrT+TpbFD0lGGAo4BLXx0h4qQRwgljfxSnKClhhV9xBC4pYkky0/CF0SJ0SyEIzuKGUQQLY8//QwWgyI2/CfIprGKyuk61QPhdF9YLpV4WVQ1X+b/saneAjExfXKta3N10nk2lIwTzOySqkEy5oYd5V3QmcmVlUBlU8MwovKD1A2KNqT3unNAYP5je5yBwBdh836QmOOYLyt0PwkJmbLxVFyBaGmyg7DqhxfQFUDkmMGzgT2iTsseZdCYO0n9Mpv5WrwdkCydOfX0muVJ5k69ATPnFQMdMWu1bS/04CfoGu76Qc3td3EjNsk3csV8JX3+SMqtUKPc69uuA8hBScdx7HekhSEh/4c/vC0c2GYxRn3mkVbMJUXIpAf2zEMDwDMNp1oPaoSzmqj5e7Mv80d32P4pHbmNPQu8MxEIEkCXNtOsBk4aG5g74BJMJzBLvH/gmHv4PJtNC/av+AyZCO1RbOl9BjpkAJjnK3jd/pKfcqUsIKl13nKbrXtMMfHdcudkBKFBBFN/NMymBtoV0Qqc8VuO34I8x2UfgyXjPEg6ugJpZHvoBRsdOFmhox4vQKOPZ7JM71gPc+U/O/uHpzPE= i-davidm@dom-daniel.com"
        }
        }
        }

        resource "azurerm_network_interface_backend_address_pool_association" "nic_backend_pool_assoc1" {
        
        network_interface_id    = "${azurerm_network_interface.nic1.id}"
        ip_configuration_name   = "testconfiguration1"
        backend_address_pool_id = "${azurerm_lb_backend_address_pool.lb_backend_pool.id}"
        }



        