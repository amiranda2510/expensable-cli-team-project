require "httparty"
require "json"

class TransactionsController
  require HTTParty
  base_uri "https://expensable-api.herokuapp.com"

  def self.add_transaction(user, transaction_info)
    # created transaction hash is returned
    request = {
      "headers": { "Content-Type": "application/json", "Authorization": "Token token=#{user.token}" },
      "body": transaction_info.to_json
    }
    category_id = transaction_info[:category_id]
    response = post("/categories/#{category_id}/transactions", request)

    raise Net::HTTPError.new("Sike Message", response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.update_transaction(user, transaction_info)
    # updated transaction hash is returned
    request = {
      "headers": { "Content-Type": "application/json", "Authorization": "Token token=#{user.token}" },
      "body": transaction_info.to_json
    }
    transaction_id = transaction_info[:transaction_id]
    category_id = transaction_info[:category_id]
    response = patch("/categories/#{category_id}/transactions/#{transaction_id}", request)

    raise Net::HTTPError.new("Sike Message", response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.delete_transaction(user, transaction_info)
    # this method returns nothing nil
    request = {
      "headers": { "Content-Type": "application/json", "Authorization": "Token token=#{user.token}" },
      "body": transaction_info.to_json
    }
    transaction_id = transaction_info[:transaction_id]
    category_id = transaction_info[:category_id]
    response = patch("/categories/#{category_id}/transactions/#{transaction_id}", request)

    raise Net::HTTPError.new("Sike Message", response) unless response.success?

    nil
  end
end
