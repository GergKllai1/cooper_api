RSpec.describe Api::V1::PerformanceDataController, type: :request do
    let(:user) { FactoryBot.create(:user) }
    let(:credentials) { user.create_new_auth_token }    
    let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

    describe 'POST /api/v1/perfomarnce_data' do
        it 'creates a data entry' do
            post '/api/v1/performance_data', params:
            { performance_data: { data: { message: 'Average' } } },
            headers: headers

            entry = PerformanceData.last
            expect(entry.data).to eq 'message' => 'Average'
        end
    end

    describe 'Get /api/v1/performance_data' do
        before do
            FactoryBot.create(:user, email: 'anotheruser@email.com')
            5.times { user.performance_data.create(data: { message: 'Average' }) }
        end

        it 'returns a collection of peromance data' do
            get '/api/v1/performance_data', headers: headers
            expect(response_json['entries'].count).to eq 5
        end
        it 'only belongs to the current user' do
            get '/api/v1/performance_data', headers: headers
            response_json['entries'].each do |hash|
                expect(hash['user_id']).to eq user['id']
            end
        end
        
    end
end