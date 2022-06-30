![published](https://static.production.devnetcloud.com/codeexchange/assets/images/devnet-published.svg)](https://developer.cisco.com/codeexchange/github/repo/bay-infotech/thousandeyes)

# Automate Thousandeyes via Terraform
# Terraform Provider for ThousandEyes [![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/thousandeyes/terraform-provider-thousandeyes?label=release)](https://github.com/thousandeyes/terraform-provider-thousandeyes/releases) [![license](https://img.shields.io/github/license/thousandeyes/terraform-provider-thousandeyes.svg)]()

The Terraform provider for ThousandEyes allows you to manage resources in [ThousandEyes](https://www.thousandeyes.com/).

## Requirements

- [Terraform](https://www.terraform.io/downloads.html) 0.12.x


## Usage
The provider is on the Terraform registry. To use it, add the following code and run `terraform init`:

```hcl
terraform {
  required_providers {
    thousandeyes = {
      source = "thousandeyes/thousandeyes"
    }
  }
}
```

### Setting up provider
```hcl
provider "thousandeyes" {
  token = "xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx"
}

```

The provider requires a token. The token can be set on the `token` variable, as shown in the example, or it may instead be passed via the `TE_TOKEN` environment variable.

The provider also supports the following optional settings:

- `account_group_id` may be set to distinguish between affected account groups, if your ThousandEyes account supports more than one.  This may instead be set by the environment variable `TE_AID`.
- `timeout` may be set to specify the number of seconds to wait for responses from the ThousandEyes endpoints.  This may instead be set by the environment variable `TE_TIMEOUT`.  If this is unset or set to `0`, then the thousandeyes-sdk-go library will use its default settings.

### Examples
Example of an HTTP test:

```hcl
data "thousandeyes_agent" "arg_cordoba" {
  agent_name = "Cordoba, Argentina"
}

resource "thousandeyes_http_server" "www_thousandeyes_http_test" {
  test_name      = "Example HTTP test set from Terraform provider"
  interval       = 120
  alerts_enabled = false

  url = "https://www.thousandeyes.com"

  agents {
    agent_id = data.thousandeyes_agent.arg_cordoba.agent_id
  }
}
```
Below test has been deployed
- [X] agent-to-agent
- [X] agent-to-server
- [X] alert-rule
- [X] bgp
- [X] dnssec
- [X] dns-server
- [X] dns-trace
- [X] ftp-server
- [X] http-server
- [X] page-load
- [X] sip-server
- [X] voice-call
- [X] voice (RTP stream)
- [X] web-transactions

## BayInfotech Repositories

Please visit our repositories for more detail and other projects in automation and programability:

[https://github.com/bay-infotech](https://github.com/bay-infotech)


## BayInfotech website
We are working hard to bring more automation and programmability into community. Please contact us for more detail projects and solutions

[https://bay-infotech.com](https://bay-infotech.com)