require 'zip'
require_relative '../../services/zip_generator'

describe ZipGenerator do
  describe '.call' do
    let(:current_path) { File.dirname(__FILE__) }
    let(:folder_path) { '../../public' }
    let(:file_name) { 'best_contributors' }
    let(:file) { "#{file_name}.zip" }
    let(:file_path) { [current_path, folder_path, file].join('/') }

    let(:file_for_archive) { [current_path, '../../spec', 'fixtures', 'example.pdf'].join('/') }
    let(:files_for_archive) { [file_for_archive] }

    after do
      File.delete(file_path) if File.exist?(file_path)
    end

    it 'create zip file' do
      expect(File.exist?(file_path)).to be_falsey
      
      zip_file_info = described_class.(file_name, files_for_archive, current_path, folder_path)

      expect(File.exist?(file_path)).to be_truthy
      expect(zip_file_info[:files_counts]).to eq(1)
    end
  end
end

