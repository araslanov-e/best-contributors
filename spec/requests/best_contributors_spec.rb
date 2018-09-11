require 'rack/test'
require_relative '../../best_contributors'

describe BestContributors do
  include Rack::Test::Methods

  def app
    described_class
  end

  describe 'GET /' do
    it 'responds successfully' do
      get '/'

      expect(last_response).to be_ok
      expect(last_response.body).to include('form')
    end
  end

  describe 'GET /search' do
    subject(:response_body) { last_response.body }

    context 'withot params' do
      it 'responds successfully' do
        get '/search'

        expect(last_response).to be_ok
        expect(response_body).to include('Repository invalid, try again')
        expect(response_body).to include('form')
      end
    end

    context 'with params' do
      let(:repository_url) { 'https://github.com/araslanov-e/best-contributors' }

      include_context 'request api github'

      it 'responds successfully' do
        get '/search', repository_url: repository_url

        expect(last_response).to be_ok
        expect(response_body.scan('<li>').length).to eq(3)
        expect(response_body.scan('download pdf').length).to eq(3)
        expect(response_body).to include('download zip (3)')
      end
    end
  end
end
