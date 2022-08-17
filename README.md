[![published](https://static.production.devnetcloud.com/codeexchange/assets/images/devnet-published.svg)](https://developer.cisco.com/codeexchange/github/repo/bay-infotech/thousandeyes)

# Automate Thousandeyes via Terraform

# Terraform Provider for ThousandEyes [![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/thousandeyes/terraform-provider-thousandeyes?label=release)](https://github.com/thousandeyes/terraform-provider-thousandeyes/releases) [![license](https://img.shields.io/github/license/thousandeyes/terraform-provider-thousandeyes.svg)]()

The Terraform provider for ThousandEyes allows you to manage resources in [ThousandEyes](https://www.thousandeyes.com/).

## Requirements

- [Terraform](https://www.terraform.io/downloads.html) 0.12.x
- [Thousandeyes Virtual Appliances](https://app.thousandeyes.com/install/downloads/appliance/thousandeyes-appliance.ova)
- Thousandeyes Profile

## Installing Virtual Appliances

The virtual appliance is a virtual machine containing a pre-built ThousandEyes Enterprise Agent, which can be quickly imported into virtualization software, configured and made available for use in testing. This article describes the requirements and steps required to install and use the ThousandEyes virtual appliance.

## Overview

The installation process for a Virtual Appliance consists of two parts:

1. Import the virtual appliance into your virtualization software (hypervisor)
Installation instructions fall into one of two groups, depending on the type of hypervisor:
   - Virtualization software that supports Open Virtualization Format (OVA/OVF): Oracle VirtualBox, VMWare products, Microsoft Hyper-V for Windows Server 2012, 2016
    - Virtualization software that does not support Open Virtualization Format (OVA/OVF): Microsoft Hyper-V for Windows Server 2008
Configure the virtual appliance

## Importing the Virtual Appliance

### Where to Find What You Need
Before starting with the import it is necessary to know where these resources can be accessed.
  - Enterprise Agents are listed in the Agent Settings.
  - If no agents have been installed yet, the listing shows No Enterprise Agents Found
![thousandeye-agent](/assets/thousandeyes-agent.png)

  - To import a virtual appliance agent from this area, click Add New Enterprise Agent.
  - Follow the steps below to proceed with the import from this area of the ThousandEyes platform.

### Import with the Open Virtualization Format (OVA)

1. Download the latest thousandeyes-va-<version>.ova file from the Cloud & Enterprise Agents > Agent Settings > Enterprise Agents > Agents page.

2. Click Add New Enterprise Agent on the left side of the Agent Settings screen.

3. There are several package types and options under this Menu. Under the Package Type, “Appliance” should be selected: Click the button in the listing labeled Download - OVA for Virtual Appliance shown above the link for this Installation Guide.

4. Double-click the downloaded thousandeyes-va-latest.ova file, or import it based on the virtualization software if this does not occur automatically. Click the import button and the progress of the installation will be shown.

5. Go through the steps in the VM application you have. Note: We recommend at least 2GB RAM memory allocated for the virtual appliance.

6. No matter which platform you choose, you will need to configure your guest (virtual machine) to use a bridged network connection, so that the guest has unimpeded network and Internet access. (see the screenshot below). NOTE: For VMware hypervisors, the VMXNET 3 adapter type is recommended. Flexible adapters are currently not supported.

7. Configure the virtual appliance.

## Configuring the Virtual Appliance
In order to get a new agent to appear in the Agents Settings page listing the newly downloaded ThousandEyes Enterprise Agent, the virtual appliance will need to be configured.
1. After the system starts, a screen will appear that will show and IP address for the management console and default access credentials

2. Access the ThousandEyes virtual appliance interface through the URL in that screen and login with the credentials shown.
![agent-install](/assets/agent-install.png)

Open a browser entering the URL presented on the screen. Enter the default username and password given.

![thousandeyes-login_page](/assets/thousandeyes-login_page.png)

Change the virtual appliance management console Web Interface Password, and click Change Password.
![thousandeyes-login_password_change](/assets/thousandeyes-login_password_change.png)


  - Following that enter the Account Group Token in the field that will show up under the Agent section. This should appear automatically after changing the password.
  - Retrieve the Account Group token from Cloud & Enterprise Agents > Agent Settings > Enterprise Agents > Agents > Add New Enterprise Agents view. It can be found under the link labeled "Show Account Group Token for Installation". This will reveal the token so it may be copied for use.
![thousandeyes-token_page](/assets/thousandeyes-token_page.png)

Paste the Account Group Token into the Account Token field. The field should turn green.
![thousandeyes-add_token_group](/assets/thousandeyes-add_token_group.png)


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

### HTTP testing

below code will create two https test and will enterprise agent we setup earlier.
all variable must address based on the configuration.

```hcl
data "thousandeyes_agent" "ce_agent" {
  agent_name  = var.ce_agent_name
}
resource "thousandeyes_agent_to_server" "server_test" {
  test_name = "my agent test"
  interval = 120
  server = "www.google.com"
  port = 80
  agents {
      agent_id = data.thousandeyes_agent.ce_agent.agent_id
  }

}

resource "thousandeyes_http_server" "google_http_test" {
  test_name = "google test"
  interval = 120
  url = "https://google.com"
  agents {
      agent_id = data.thousandeyes_agent.ce_agent.agent_id
  }
  agents {
      agent_id = 467841
  }
}
```

## Deployment process

after adding repository on Github, Terraform will push the codes to the Thousandeyes API.
![thousandeyes-terraform_applied](/assets/thousandeyes-terraform_applied.png)

This will create 2 tests we created earlier.
![thousandeyes-test_added](/assets/thousandeyes-test_added.png)

All other setting for the tests can be configured via coding or it can be configured on the GUI. 

Below test can be deployed via Terraform 

- [X] agent-to-agent
- [X] agent-to-server
- [X] alert-rule
- [X] bgpS
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
