RSpec.describe 'User Registration', type: :request do
    let(:headers) { { HTTP_ACCEPT: 'application/json' } }

    context 'with valid credentials' do 
        it 'returns an user and a token' do
            post '/api/v1/auth', params: 
            { email: 'johndoe@email.com',
            password: 'password',
            password_confirmation: 'password' },
            headers: headers

            expect(response_json['status']).to eq 'success'
            expect(response.status).to eq 200
        end
    end

    context 'returns an error message when user submits' do
        it 'non-matching password confirmation' do
            post '/api/v1/auth', params: 
            { email: 'johndoe@email.com',
            password: 'password',
            password_confirmation: 'wrong_password' },
            headers: headers
            expect(response_json['errors']['password_confirmation']).to eq ["doesn't match Password"]
            expect(response.status).to eq 422
        end
        
        it 'an invalid email address' do
            post '/api/v1/auth', params: 
            { email: 'johndoe@emailcom',
            password: 'password',
            password_confirmation: 'password' },
            headers: headers

            expect(response_json['errors']['email']).to eq ['is not an email']
            expect(response.status).to eq 422
        end
        it 'an already registered email address' do
            FactoryBot.create(:user, 
            email: 'johndoe@email.com')

            post '/api/v1/auth', params: 
            { email: 'johndoe@email.com',
            password: 'password',
            password_confirmation: 'password' },
            headers: headers
            
            expect(response_json['errors']['email']).to eq ['has already been taken']
            expect(response.status).to eq 422
        end
    end
end