#
# Variables Configuration
#

variable "cluster-name" {
  default = "project-cluster"
  type    = string
}
variable "key_pair_name" {
  default = "Marypearl"
}
variable "eks_node_instance_type" {
  default = "t2.medium"
}
