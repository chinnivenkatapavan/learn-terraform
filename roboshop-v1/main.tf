module "component"{
    for_each = var.component
    source = "./vm"
    component = each.value["name"]
}


variable "component" {
    default = {

        frontend = {
            name = "frontend"
            }
        mongodb = {
            name = "mongodb"
            }
        catalogue = {
            name = "catalogue"
            }
        user = {
            name = "user"
            }
        cart = {
            name = "cart"
            }
        mysql = {
            name = "mysql"
            }
        shipping = {
            name = "shipping"
            }
        payment = {
            name = "payment"
            }
        rabbitmq = {
            name = "rabbitmq"
            }









        }

    }