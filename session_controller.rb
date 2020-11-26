require "json"
require "httparty"

class SessionController
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com"

  def self.login(login_data)
    options = {
      headers: { "Content-Type": "application/json" },
      body: login_data.to_json
    }
    post("/login", options)
  end
end
