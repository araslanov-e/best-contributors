require "roda"

class BestContributors < Roda
  plugin :render, engine: 'slim'

  route do |r|
    r.root do
      view('index')
    end

    r.get 'search' do
      @repository_url = r.params['repository_url']
      view('search')
    end
  end
end

