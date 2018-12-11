RSpec.describe Api::V1::PerformanceDataController, type: :request do
    let(:headers) { { HTTP_ACCEPT: 'application/json' } }

    describe 'POST /api/v1/perfomance_data' do
        it 'creates a data entry' do
            post '/api/v1/performance_data', params:
            { perfomance_data: { data: { message: 'Average' } } }, headers: headers

            entry = PerfomanceData.last
            expect(entry.data).to eq 'message' => 'Average'
        end
    end
end