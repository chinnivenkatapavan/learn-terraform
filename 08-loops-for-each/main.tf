resource "local_file" "foo"{
    for_each = var.demo
    content = each.value["content"]
    filename = "/tmp/${each.key}"

    }

variable "demo" {
    default = {
        APPLE  = {
            content = "Nested Mapping for APPLE"
            }
        ORANGE = {
            content = "Nested Mapping for organe"
            }
        BANANA = {
            content = "Nested Mapping for banana"
            }
        }
    }