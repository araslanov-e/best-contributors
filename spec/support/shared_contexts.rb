shared_context 'request api github' do
  before do
    stub_request(:get, 'https://api.github.com/repos/araslanov-e/best-contributors/contributors')
      .to_return(
        status: 200,
        body: [
          { login: 'araslanov-e' },
          { login: 'araslanova-a' },
          { login: 'araslanova-e' },
          { login: 'araslanova-l' }
        ].to_json
      )
  end
end
