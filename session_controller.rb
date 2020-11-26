require "json"
require "HTTParty"

class SessionController
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com/"

  # def self.login(_login_data)
  #   options = {
  #     headers: { "Content-Type" => "application/json" }
  #   }
  # end
end
