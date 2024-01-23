# Copyright (c) Çetin ARDAL
# SPDX-License-Identifier: MIT

terraform {
  # Terraform cli version
  required_version = ">= 1.5.0"
  # Backend on Terraform Cloud or Terraform Enterprise
  # comment the cloud{} block to work with local state.
  cloud {
    organization = "richard-russell-org"
    hostname     = "app.terraform.io" # Optional; defaults to app.terraform.io. Update with TFE hostname if required
    workspaces {
      name = "your-workspace" //update me
    }
  }
}
