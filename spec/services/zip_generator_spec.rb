require 'zip'
require_relative '../../services/zip_generator'

describe ZipGenerator do
  describe '#generate' do
    let(:current_path) { File.dirname(__FILE__) }
    let(:folder_path) { '../../public' }
    let(:zip_file_name) { 'best_contributors' }
    let(:zip_file) { "#{zip_file_name}.zip" }
    let(:zip_file_path) { [current_path, folder_path, zip_file].join('/') }

    let(:file) { [current_path, '../../spec', 'fixtures', 'example.pdf'].join('/') }
    let(:files) { [file] }

    let(:zip_generator) { described_class.new(current_path, folder_path) }

    after do
      File.delete(zip_file_path) if File.exist?(zip_file_path)
    end

    it 'create zip file' do
      expect(File.exist?(zip_file_path)).to be_falsey
      
      zip_file_info = zip_generator.generate(zip_file_name, files)

      expect(File.exist?(zip_file_path)).to be_truthy
      expect(zip_file_info[:files_counts]).to eq(1)
    end
  end
end

