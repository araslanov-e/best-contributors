class RepositoryPresenter
  def initialize(repository)
    @repository = repository
  end

  def repository_valid?
    @repository.valid?
  end

  def best_contributors(max_contributors = 3)
    @repository.contributors.first(max_contributors)
  end
end
