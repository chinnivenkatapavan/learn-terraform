variable "a"{}

output "fg"{
    value = var.a > 10 ? "a is greater than 10" : "a is less than 10"
    }

# These conditions with combination of loop can be used to determine whether a resource to run or not.value

resource "null_resource" "test" {
    count = var.a > 10 ? 1 : 0
    }

# if the above expression var.a > 1 : o, lets say it needs to be used in 10 different places, tomorrow if we want to change the expression, it becomes a duplicate work to change in 10 places, to keep the code dry, terraform supports local resources. Which is like run time variables.value

local {
    count = var.a > 10 ? 1 : 0
    }

resource "null_resource" "test"{
    count = local.count
    }