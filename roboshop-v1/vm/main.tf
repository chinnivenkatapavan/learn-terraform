resource "azurerm_network_interface" "main" {


  name                = "${var.component}-nic"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_network_security_group" "main" {
  name                = "${var.component}-nsg"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name

  security_rule {
    name                       = "main"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.component
  }
}

resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_public_ip" "main" {
  name                = "${var.component}-ip"
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location
  allocation_method   = "Static"

  tags = {
    component = var.component
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = var.component
  location              = data.azurerm_resource_group.example.location
  resource_group_name   = data.azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_B2s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    id = "/subscriptions/b3406e49-0e16-456d-a3bb-c324f1dfb0d5/resourceGroups/project-setup-1/providers/Microsoft.Compute/galleries/Chinni/images/MyselfImage/versions/1.0.0"
  }
  storage_os_disk {
    name              = var.component
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.component
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    component = var.component
  }
}

resource "azurerm_dns_a_record" "main" {
  name                = "${var.component}-dev"
  zone_name           = "azdevops2704.online"
  resource_group_name = data.azurerm_resource_group.example.name
  ttl                 = 10
  records             = [azurerm_network_interface.main.private_ip_address]
}

resource "null_resource" "ansible" {

  depends_on = [azurerm_virtual_machine.main]

  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "testadmin"
      password = "Password1234!"
      host     = azurerm_public_ip.main.ip_address
    }

    inline = [
      "sudo dnf install python3.12-pip -y",
      "sudo pip3.12 install ansible",
      "ansible-pull -i localhost, -U https://github.com/chinnivenkatapavan/roboshop-ansible.git roboshop.yml -e app_name=${var.component} -e ENV=dev"
    ]
  }
}