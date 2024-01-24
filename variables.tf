# Copyright (c) Çetin ARDAL
# SPDX-License-Identifier: MIT

locals {
  formatted_timestamp = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
}

variable "default_tags" {
  type        = map(string)
  description = "a set of tags to watermark the resources you deployed with Terraform."
  default = {
    owner       = "richard" // update me
    terraformed = "Do not edit manually."
  }
}

variable "github_owner" {
  type        = string
  description = "Owner of the Github org"
  default     = ""
}

variable "iac_repo_template" {
  type        = string
  description = "Template to use for IAC repo creation"
  default     = "terraform-generic-template"
}

variable "mgmt_ws_prefix" {
  type        = string
  description = "String to prefix the archetype name to give mgmt workspace and repo names"
  default     = "nclz-mgmt"
}

variable "mgmt_ws_template_prefix" {
  type        = string
  description = "String to prefix the archetype name to give mgmt template repo name"
  default     = "nocode-lz-mgmt-template"
}

variable "oauth_token_id" {
  type        = string
  description = "Oauth token ID used for associating workspace to VCS"
  default     = ""
}

variable "tfc_organization" {
  type        = string
  description = "TFC organization"
  default     = ""
}

variable "project_name" {
  type        = string
  description = "Name of the project to create a landing zone for"
}

variable "project_prefix" {
  type        = string
  description = "Prefix for the TFE project name within the nocode module"
  default     = "nclz-project"
}
