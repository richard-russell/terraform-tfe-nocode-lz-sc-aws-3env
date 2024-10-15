# Copyright (c) Çetin ARDAL
# SPDX-License-Identifier: MIT

terraform {
  # Terraform cli version
  required_version = ">= 1.6.0"
  # Backend on Terraform Cloud or Terraform Enterprise
  # comment the cloud{} block to work with local state.
}

provider "github" {}
provider "tfe" {
  hostname = var.tfe_hostname
}

locals {
  envs     = [for env in split(",", var.envs) : trimspace(env)]
  num_envs = length(local.envs)

  # environment/workspace mapped to main branch
  main_env = local.envs[local.num_envs - 1]
  # list of extra environments needing workspaces and branches
  extra_envs = slice(local.envs, 0, local.num_envs - 1)
}

locals {
  project_fullname = "${var.project_prefix}-${var.project_name}"
  repo_name        = local.project_fullname
  teams            = toset(["admin", "write", "maintain", "read"])
}

# AWS resources - not included in the demo, but typically:
# - AWS account for project
# - OIDC connection for dynamic provider credentials/workload identity
# - roles and policies for DPC
# - add these as env vars to project variable set

resource "tfe_project" "this" {
  organization = var.tfc_organization
  name         = local.project_fullname
}

resource "tfe_team" "team" {
  for_each = local.teams

  organization = var.tfc_organization
  name         = "proj-${local.project_fullname}-${each.key}"
}

resource "tfe_team_project_access" "levels" {
  for_each = tfe_team.team

  access     = each.key
  team_id    = each.value.id
  project_id = tfe_project.this.id
}

resource "github_repository" "iac" {
  name        = local.repo_name
  description = "IAC repo for project ${var.project_name}"

  visibility = "private"

  template {
    owner                = var.github_owner
    repository           = var.iac_repo_template
    include_all_branches = false
  }
}

resource "tfe_workspace" "main" {
  name         = "${local.repo_name}-${local.main_env}"
  organization = var.tfc_organization
  project_id   = tfe_project.this.id
  tag_names    = [local.main_env, "iac", "lz", var.project_name]
  vcs_repo {
    branch         = "main"
    identifier     = github_repository.iac.full_name
    oauth_token_id = var.oauth_token_id
  }
}

resource "github_branch" "extra_envs" {
  for_each   = toset(local.extra_envs)
  repository = github_repository.iac.name
  branch     = each.key
}

resource "tfe_workspace" "extra_envs" {
  for_each     = toset([for branch in github_branch.extra_envs : branch.branch])
  name         = "${local.project_fullname}-${each.key}"
  organization = var.tfc_organization
  project_id   = tfe_project.this.id
  tag_names    = [each.key, "iac", "lz", var.project_name]
  vcs_repo {
    branch         = each.key
    identifier     = github_repository.iac.full_name
    oauth_token_id = var.oauth_token_id
  }
}

# Common variables for project
resource "tfe_variable_set" "project" {
  name         = local.project_fullname
  organization = var.tfc_organization
}

resource "tfe_variable" "project_name" {
  key             = "project_name"
  value           = var.project_name
  category        = "terraform"
  variable_set_id = tfe_variable_set.project.id
  sensitive       = false
}

resource "tfe_project_variable_set" "project" {
  variable_set_id = tfe_variable_set.project.id
  project_id      = tfe_project.this.id
}
