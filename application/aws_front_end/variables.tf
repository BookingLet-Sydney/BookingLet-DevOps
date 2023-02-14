# variable "wtf" {
#     type = map
#     default = {
#         Key1 = "value1"
#         Key2 = "value2"
#     }
# }

# variable "wtf" {
#     type = tuple([string,number,string])
#     default = ["true",1,"wtf"]
# }

# variable "wtf" {
#     type = object({name =string ,port =number , wtf = list(number)})
#     default = {
#         name = "sss"
#         port = 1123   var.wtf["port"]
#         wtf = [80,443,8080]

#     }
#}