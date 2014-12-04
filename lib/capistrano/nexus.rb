load File.expand_path('../tasks/nexus.rake', __FILE__)
require 'capistrano/scm'
require 'net/http'

class Capistrano::Nexus < Capistrano::SCM
  module DefaultStrategy
    def artifact_ext
      'tgz'
    end

    def artifact_url
      artifact_name = fetch(:nexus_artifact_name)
      artifact_version = fetch(:nexus_artifact_version)
      [ fetch(:nexus_endpoint), fetch(:nexus_repository), *fetch(:nexus_group_id).split('.'),
        artifact_name, artifact_version, "#{artifact_name}-#{artifact_version}.#{artifact_ext}" ].join('/')
    end

    def local_filename
      "#{fetch(:nexus_artifact_version)}.#{artifact_ext}"
    end

    def test
      test! " [ -d #{repo_path} ] "
    end

    def check
      begin
        uri = URI(artifact_url)
        res = Net::HTTP.new(uri.host).request_head(uri.path)
        if res.code.to_i == 200
          true
        else
          puts "Artifact not found at #{artifact_url}"
          false
        end
      rescue StandardError => e
        puts "Recieved error: #{e}, backtrace: \n#{e.backtrace}"
        false
      end
    end

    def download
      context.execute :curl, '-o', local_filename, artifact_url
    end

    def release
      context.execute :tar, '-xzf', local_filename, '-C', fetch(:release_path)
    end

    def cleanup
      if test! " [ -f #{local_filename} ] "
        context.execute :rm, local_filename
      end
    end

    def fetch_revision
      fetch(:nexus_artifact_version)
    end
  end
end
