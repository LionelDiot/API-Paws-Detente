require 'rails_helper'

RSpec.describe "the signup process", type: :request do
  it "returns a 422 status code for an invalid sign-in attempt" do
    headers = { 'Content-Type' => 'application/json' }
    params = { user: { email: 'test@example.com', password: 'wrongpassword' } }.to_json

    post '/users/sign_in', headers: headers, params: params

    expect(response).to have_http_status(422)
  end
end

RSpec.describe "the signup process", type: :request do
  it "returns a 200 status code for a valid sign-in attempt" do
    headers = { 'Content-Type' => 'application/json' }
    params = { user: { email: 'test@example.com', password: '12345678' } }.to_json

    post '/users/sign_in', headers: headers, params: params

    expect(response).to have_http_status(200)
  end
end




