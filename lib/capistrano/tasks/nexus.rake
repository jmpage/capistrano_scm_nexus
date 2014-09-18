namespace :nexus do
  def strategy
    @strategy ||= Capistrano::Nexus.new(self, Capistrano::Nexus::DefaultStrategy)
  end

  desc 'Download the nexus artifact'
  task :download do
    on release_roles :all do
      within repo_path do
        strategy.download
      end
    end
  end

  desc 'Copy artifact contents to releases'
  task create_release: 'nexus:download' do
    on release_roles :all do
      within repo_path do
        execute :mkdir, '-p', release_path
        strategy.release
      end
    end
  end

  desc 'Check that Nexus is reachable'
  task :check do
    exit 1 unless strategy.check
  end

  desc 'Determine the revision that will be deployed'
  task :set_current_revision do
    on release_rolls :all do
      set :current_revision, strategy.fetch_revision
    end
  end
end
