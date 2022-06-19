provider "aws" {
  region = "ap-south-1"
}

module "webserver_cluser" {
  source = "../../modules/services/webserver-cluster"

  region = "ap-south-1"
  ami = "ami-079b5e5b3971bd10d"
  tags = {
      "Name" = "webserver"
      "Application" = "CRM"
  }
  ingress_source_cidr = ["182.75.184.32/29", "0.0.0.0/0"]
  min_server_count = 1
  max_server_count = 2
  cluster_name = "lms-stg"
  db_remote_state_bucket = "rtc2022q3-terraform-state-1"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"
}

output "lb-dns" {
  value = module.webserver_cluser.alb_dns_name
  description = "Load Balancer DNS name"
}