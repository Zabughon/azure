variable "Var_Pip" {
  default = "public-ip"
}
variable "Var_Lb_Name" {
  default = "public-lb"
}

variable "Var_Lb_Backend_Pool" {
  default = "backend-pool"
}

variable "Var_Network_Interface" {
  default = "nic"
}

locals {
    var_rgname     = "${data.terraform_remote_state.Data_Common.outputs.Var_RGrp_Name}"
    var_rglocation = "${data.terraform_remote_state.Data_Common.outputs.Var_RGrp_Location}"
    var_secgpid    = "${data.terraform_remote_state.Data_Common2.outputs.Var_secgpid}"
    var_subid      = "${data.terraform_remote_state.Data_Common2.outputs.Var_subid}"
    }