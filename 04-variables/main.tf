variable "name" {
    default = "Hello"
}

variable "n1" {
    default = 2
}

variable "b1"{
    default = true
}

#Data types that terraform supports
#1.String
#2. Number
#3. Boolean

# String only require quotes, That to be only double quotes. Terraform does not have single quotes support.

variable "v1" {
    default = "Hello"
    }

variable "v2" {
    default = [
        "Hello",
        2,
        false
        ]
    }

variable "v3" {
    deafult = {
        course = "devops"
        cloud = "azure"
        }
    }

# variable type that terraform supports
# 1. plain
# 2. List (A key having multiple values, and each value can be a different data type)
# 3. map (A key having again keys and values)

## Access your variable
output "o1" {
    value = var.v1
    }

# While accessing variable, if we have some string combination then we can access it with ${}
output "o2" {
    value = "${var.v1} - John"
    }

# Access a value of list
output "o3"{
    value = var.v2[0]
    }

# Access a value of map
output "o4"{
    value = var.v3["Cloud"]
    }

# So far we are handcording the value in variables, most times those come as input

variable "v10"{
    output "o10"{
        value = var.v10
        }
    }