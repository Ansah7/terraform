locals {
  ts = timestamp()  #Returns date and timestamp
  current_month = formatdate("MMMM", local.ts)
  tomorrow = formatdate("DD", timeadd(local.ts, "24h"))
}

output "date_time" {
  value = "${local.current_month} ${local.tomorrow}"
}
##ITERATION##
#HCL has a "for" syntax for iterating over list of values
locals {
  l = ["one", "two", "three"]
  upper_list = [for item in local.l: upper(item)] # go through list and apply upper function on each item, it will output a list
  upper_map = {for item in local.l: item => upper(item)} # this will output a map
}
output "iterations" {
  value = local.upper_list
}
# the 'for' can take an 'if' clause
locals {
  n = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  evens = [for i in local.n: i if i % 2 == 0]
}
output "filtered" {
  value = local.evens
}
## the minus(-) in front of EOT helps to ignore indentation below the sentence
output "heredoc" {
  value = <<-EOT
    This is called a 'Heredoc'. It's string literal
    that can span multiple lines.
  EOT
}

locals {
  person = "Abraham Ansah-Cudjoe"
}
output "Directives" {
  value = <<-EOT
    This is a 'heredoc' with Directives.
    %{ if local.person == "" }
    Sorry, I do not know your name.
    %{ else }
    Hi ${local.person}
    %{ endif }
  EOT
}

output "ITERATION" {
  value = <<-EOT
  Directives can also iterate...
  %{ for number in local.evens }
  ${number} is even.
  %{ endfor }
  EOT
}
