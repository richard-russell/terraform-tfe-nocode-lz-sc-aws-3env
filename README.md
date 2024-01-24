# terraform-tfe-nocode-lz

## About
A no-code module to create landing zone resources.
The no-code workspace is the project LZ management workspace (service catalog model), meaning the LZ is very prescriptive, and fully controlled by the platform team. To support multiple LZ archetypes, create multiple versions of this module and publish as no-code modules to the private registry.

No-code workspace to be placed in a project with varset including:
- TFE_TOKEN - capable of creating projects and teams
- GITHUB_TOKEN - capable of creating repos and webhooks

<!-- BEGIN_TF_DOCS -->

### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.6.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [github_branch.extra_envs](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/branch) | resource |
| [github_repository.iac](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/repository) | resource |
| [tfe_project.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project) | resource |
| [tfe_project_variable_set.project](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project_variable_set) | resource |
| [tfe_team.team](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team) | resource |
| [tfe_team_project_access.levels](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_project_access) | resource |
| [tfe_variable.project_name](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable_set.project](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set) | resource |
| [tfe_workspace.extra_envs](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |
| [tfe_workspace.main](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_tags | a set of tags to watermark the resources you deployed with Terraform. | `map(string)` | <pre>{<br>  "owner": "richard",<br>  "terraformed": "Do not edit manually."<br>}</pre> | no |
| envs | Comma-separated list of environments needing workspaces and branches. Last one maps to main branch. | `string` | n/a | yes |
| github\_owner | Owner of the Github org | `string` | `""` | no |
| iac\_repo\_template | Template to use for IAC repo creation | `string` | `"terraform-generic-template"` | no |
| oauth\_token\_id | Oauth token ID used for associating workspace to VCS | `string` | `""` | no |
| project\_name | Name of the project to create a landing zone for | `string` | n/a | yes |
| project\_prefix | Prefix for the TFE project name within the nocode module | `string` | `"nclz-project"` | no |
| tfc\_organization | TFC organization | `string` | `""` | no |

### Outputs

No outputs.

<!-- END_TF_DOCS -->