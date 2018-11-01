require 'prawn'
require_relative '../../services/pdf_generator'

describe PdfGenerator do
  describe '.call' do
    let(:current_path) { File.dirname(__FILE__) }
    let(:folder_path) { '../../public' }
    let(:file) { 'araslanov-e.pdf' }
    let(:file_path) { [current_path, folder_path, file].join('/') }
    let(:contributors) { [{ 'login' => 'araslanov-e' }] }

    after do
      File.delete(file_path) if File.exist?(file_path)
    end

    it 'create pdf file' do
      expect(File.exist?(file_path)).to be_falsey

      contributors_pdf_files = described_class.(contributors, current_path, folder_path)
      contributors_pdf_files.each do |_, file|
        expect(File.exist?(file[:full_file_path])).to be_truthy
      end
    end
  end
end
