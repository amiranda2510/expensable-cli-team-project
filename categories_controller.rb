require "httparty"
require "json"

class CategoriesController
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com"

  def self.category(token, id)
    options = { headers: { authorization: "Token token=#{token}" } }
    response = get("/categories/#{id}", options)
    raise_and_send_response(response)
  end

  def self.index(token)
    options = {
      headers: { authorization: "Token token=#{token}" }
    }
    response = get("/categories", options)
    raise_and_send_response(response)
  end

  def self.create(token, data)
    options = {
      headers: { "Content-Type": "application/json", "Authorization": "Token token=#{token}" },
      body: data.to_json
    }
    response = post("/categories", options)
    raise_and_send_response(response)
  end

  def self.update(token, data, id)
    options = {
      headers: { "Content-Type": "application/json", "Authorization": "Token token=#{token}" },
      body: data.to_json
    }
    response = patch("/categories/#{id}", options)
    raise_and_send_response(response)
  end

  # delete method

  def self.destroy(id, token)
    options = {
      headers: { authorization: "Token token=#{token}" }
    }
    response = delete("/categories/#{id}", options)
    error_message = "Category Not Found"
    raise Net::HTTPError.new(error_message, response) unless response.success?
  end

  def self.raise_and_send_response(response)
    response_body = JSON.parse(response.body, symbolize_names: true)
    raise Net::HTTPError.new(response_body[:errors].join, response) unless response.success?

    response_body
  end
end
