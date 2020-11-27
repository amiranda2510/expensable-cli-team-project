require "httparty"
require "json"

class TransactionsController
  require HTTParty
  base_uri "https://expensable-api.herokuapp.com"

  def self.add_transaction(user, transaction_info)
    request = {
      "headers": { "Content-Type": "application/json", "Authorization": "Token token=#{user.token}" },
      "body": transaction_info.to_json
    }
    category_id = transaction_info[:category_id]
    response = post("/categories/#{category_id}/transactions", request)

    raise Net::HTTPError.new("Sike Message", response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end
end
