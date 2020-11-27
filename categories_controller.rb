require "json"
require "httparty"

class CategoriesController
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com"

  def self.categories(token)
    options = { headers: { authorization: "Token token=#{token}" } }
    response = get("/id", options)
    raise_and_send_response(response)
  end

  def self.raise_and_send_response(response)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true) if response.body
  end
end
