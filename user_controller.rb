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

    # raise error here
    JSON.parse(response.body, symbolize_names: true)
  end
end
