require 'net/http'
require 'json'
require_relative '../../models/repository'

describe Repository do
  let(:repository_url) { 'https://github.com/araslanov-e/best-contributors' }
  let!(:repository) { described_class.new(repository_url) }

  describe '#valid?' do
    subject { repository.valid? }

    it { is_expected.to be_truthy }
  end

  describe '#best_contributors' do
    include_context 'request api github'

    it 'returns 3 contributors' do
      expect(repository.best_contributors.length).to eq 3
    end
  end
end
