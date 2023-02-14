#
# Variables Configuration
#

variable "cluster-name" {
  default = "tsp-cluster"
  type    = string
}
variable "key_pair_name" {
  default = "tspcloud"
}
variable "eks_node_instance_type" {
  default = "t2.micro"
}
