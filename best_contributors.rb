require "roda"

require 'net/http'
require 'json'
require 'prawn'
require 'zip'

require_relative './models/repository.rb'
require_relative './services/folders_creator.rb'
require_relative './services/pdf_generator.rb'
require_relative './services/zip_generator.rb'

class BestContributors < Roda
  plugin :render, engine: 'slim'
  plugin :public
  plugin :not_found do
    view('404')
  end

  route do |r|
    r.public

    r.root do
      view('index')
    end

    r.get 'search' do
      @repository = Repository.new(r.params['repository_url'])

      public_folder_path = opts[:public_root]
      files_folder_path = "files/#{@repository.path}"

      FoldersCreator.call("#{public_folder_path}/#{files_folder_path}")
      
      files = PdfGenerator.new(public_folder_path, files_folder_path).generate(@repository.best_contributors)
      @zip_file_info = ZipGenerator.new(public_folder_path, files_folder_path).generate('best_contributors', files)

      view('search')
    end
  end
end

