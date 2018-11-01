require "roda"

require 'net/http'
require 'json'
require 'prawn'
require 'zip'

require_relative './models/repository.rb'
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

      root_path = opts[:public_root]
      files_storage_path = "files/#{@repository.path}"
      FileUtils.mkdir_p("#{root_path}/#{files_storage_path}")
      
      @contributors_pdf_files = PdfGenerator.(@repository.best_contributors, root_path, files_storage_path)

      files_for_archive = @contributors_pdf_files.values.map { |file_info| file_info[:full_file_path] }
      @zip_file_info = ZipGenerator.('best_contributors', files_for_archive, root_path, files_storage_path)

      view('search')
    end
  end
end

