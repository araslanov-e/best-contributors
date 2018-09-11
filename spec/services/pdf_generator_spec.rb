require 'prawn'
require_relative '../../services/pdf_generator'

describe PdfGenerator do
  describe '#generate' do
    let(:current_path) { File.dirname(__FILE__) }
    let(:folder_path) { '../../public' }
    let(:pdf_file) { 'araslanov-e.pdf' }
    let(:pdf_file_path) { [current_path, folder_path, pdf_file].join('/') }

    let(:pdf_generator) { described_class.new(current_path, folder_path) }
    let(:contributors) { [{ 'login' => 'araslanov-e' }] }

    after do
      File.delete(pdf_file_path) if File.exist?(pdf_file_path)
    end

    it 'create pdf file' do
      expect(File.exist?(pdf_file_path)).to be_falsey

      files = pdf_generator.generate(contributors)
      files.each do |file|
        expect(File.exist?(file)).to be_truthy
      end
    end
  end
end
