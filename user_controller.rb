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
  end

  def self.raise_and_send_response(response)
    response_body = JSON.parse(response.body, symbolize_names: true)
    raise Net::HTTPError.new(response_body[:errors].join, response) unless response.success?

    response_body
  end
end
