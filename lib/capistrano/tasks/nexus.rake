namespace :nexus do
  def strategy
    @strategy ||= Capistrano::Nexus.new(self, Capistrano::Nexus::DefaultStrategy)
  end

  desc 'Copy artifact contents to releases'
  task :create_release do
    on release_roles :all do
      within repo_path do
        strategy.download
        execute :mkdir, '-p', release_path
        strategy.release
        strategy.cleanup
      end
    end
  end

  desc 'Check that Nexus is reachable'
  task :check do
    exit 1 unless strategy.check
  end

  desc 'Create the repository folder'
  task :clone do
    on release_roles :all do
      if strategy.test
        info 'Repository folder exists'
      else
        info 'Repository folder does not exist: creating #{repo_path}'
        within deploy_path do
          execute :mkdir, '-p', repo_path
        end
      end
    end
  end

  desc 'Determine the revision that will be deployed'
  task :set_current_revision do
    on release_roles :all do
      set :current_revision, strategy.fetch_revision
    end
  end
end
