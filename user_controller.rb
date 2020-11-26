require "httparty"
require "json"

class UserController
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com"

  def self.create_user(new_user)
    request = {
      "headers": { "Content-Type": "application/json" },
      "body": new_user.to_json
    }
    response = post("/signup", request)
    raise_and_send_response(response)
    # JSON.parse(response.body, symbolize_names: true)
  end

  def self.raise_and_send_response(response)
    raise Net::HTTPError.new(response.parsed_response["errors"], response) unless response.success?

    JSON.parse(response.body, symbolize_names: true) if response.body
  end
end
