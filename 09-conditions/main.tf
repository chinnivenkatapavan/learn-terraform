variable "a"{}

output "fg"{
    value = var.a > 10 ? "a is greater than 10" : "a is less than 10"
    }