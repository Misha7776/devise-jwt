require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Users' do
  header "Content-Type", "application/json"

  post '/signup' do
    let(:params) do
      {
          user: {
              email: 'user@example.com',
              password: 'password',
              password_confirmation: 'password'
          }
      }.to_json
    end
    it 'should sign up new user' do
      expect { do_request }.to change { User.count }.from(0).to(1)
      expect(response_status).to eq 200
      expect(json['email']).to eq 'user@example.com'
    end
  end

  post '/login' do

    let!(:user) { create(:user, email: 'test@mail.com', password: '123456')}
    let(:params) do
      { session: {
          user: {
              email: 'test@mail.com',
              password: '123456'
          }
      }
      }.to_json
    end

    it 'should login user' do
      binding.pry
      do_request
      binding.pry
      expect(response_status).to eq 200
      expect(json['jwt_token']).to be_present
      expect(json['user']['email']).to eq user.email
    end
  end
end
