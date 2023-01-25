provider "aws" {
  region = "ap-southeast-2"

}

resource "aws_vpc" "myvpc_use_internally" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.sss
    Name = var.mylist[1]
    Name = var.mymap["Key2"]
  }
}
