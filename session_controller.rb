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

  # create_ logout

  def self.logout(token)
    options = { headers: { autorization: "Token token=#{token}" } }
    response = delete("/logout", options)
    raise_and_send_response(response)
  end

  def raise_and_send_response(response)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_name: true) if response.body
  end
end
