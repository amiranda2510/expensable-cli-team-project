require "httparty"
require "json"

class CategoriesController
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com"

  def self.index(token)
    options = {
      headers: { authorization: "Token token=#{token}" }
    }
    response = get("/categories", options)

    raise_and_send_response(response)
  end

  # delete method

  def self.destroy(id, token)
    options = {
      headers: { authorization: "Token token=#{token}" }
    }
    response = delete("/categories/#{id}", options)
    raise_and_send_response(response)
  end

  def self.raise_and_send_response(response)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true) if response.body
  end
end
