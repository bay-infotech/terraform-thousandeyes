terraform {
  required_providers {
    thousandeyes = {
      source = "william20111/thousandeyes"
      version = "0.6.0"
    }
  }
}

provider "thousandeyes" {
  token = "de8bb13f-1c0d-4b1b-8f0c-0de6b6a29234"
}

data "thousandeyes_agent" "test_agent" {
  name  = "thousandeyes-va"
}

resource "thousandeyes_agent_to_server" "thousandeyes-va" {
  name = "my agent test"
  interval = 120
  server = "8.8.8.8"
  agents {
      agent_id = data.thousandeyes_agent.thousandeyes-va.agent_id
  }

}


resource "thousandeyes_http_server" "google_http_test" {
  name = "google test"
  interval = 120
  url = "https://google.com"
  agents {
      agent_id = data.thousandeyes_agent.test_agent.agent_id
  }
  agents {

      agent_id = 12345
  }
}
