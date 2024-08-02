variable "ssh_public_key_file" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}


variable "bootstrap" {
  description = "build and push the docker image"
  type        = bool
  default     = false
}
