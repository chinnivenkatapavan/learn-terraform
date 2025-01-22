variable "a"{}

output "fg"{
    value = var.a > 10 ? "a is greater than 10" : "a is less than 10"
    }

# These conditions with combination of loop can be used to determine whether a resource to run or not.value

resource "null_resource" "test" {
    count = var.a > ? 1 : 0
    }