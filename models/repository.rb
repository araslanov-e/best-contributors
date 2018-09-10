class Repository
  def initialize(repository_url)
    @repository_url = repository_url.to_s
  end

  def valid?
    !(repo.empty? || owner.empty?)
  end

  def repo
    @repo ||= match_repository[:repo].to_s
  end

  def owner
    @owner ||= match_repository[:owner].to_s
  end

  def contributors
    @contributors ||= begin
      uri = URI("https://api.github.com/repos/#{owner}/#{repo}/contributors")

      request = Net::HTTP::Get.new(uri)
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request(request)
      end

      response.code.to_i == 200 ? JSON.parse(response.body) : []
    end
  end

  private

  def match_repository
    @match_repository ||= @repository_url.match(/.*github.com\/(?<owner>\w*)\/(?<repo>\w*)\/?/) || {}
  end
end
