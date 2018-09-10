require "roda"

require 'net/http'
require 'json'

require_relative './models/repository.rb'
require_relative './presenters/repository_presenter.rb'

class BestContributors < Roda
  plugin :render, engine: 'slim'

  route do |r|
    r.root do
      view('index')
    end

    r.get 'search' do
      @repository = Repository.new(r.params['repository_url'])
      @repository_presenter = RepositoryPresenter.new(@repository)

      view('search')
    end
  end
end

