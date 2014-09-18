require 'capistrano/scm'
require 'net/http'

class NexusTools
  def self.get_artifact_url(url, repository, group, artifact_id, extension, version)
    response = Net::HTTP.request_get("#{url}/service/local/artifact/maven/redirect?g=#{group}&a=#{artifact_id}&e=#{extension}&v=#{version}&r=#{repository}")
    response.fetch('location') rescue nil
  end
end

class Capistrano::Nexus < Capistrano::SCM
  module DefaultStrategy
    def check
      begin
        url = NexusTools.get_artifact_url(fetch(:nexus_url), fetch(:nexus_repository), fetch(:nexus_group), fetch(:nexus_artifact_id),
                                          fetch(:nexus_extension), fetch(:nexus_version))
        if url
          set(:artifact_url, url)
          true
        else
          false
        end
      rescue StandardError => e
        false
      end
    end

    def release
      execute :tar, '-xzf', "#{fetch(:nexus_version)}.#{fetch(:nexus_extension)}", '-C', fetch(:release_path)
    end

    def download
      execute :curl, '-o', "#{fetch(:nexus_version)}.#{fetch(:nexus_extension)}", fetch(:artifact_url)
    end

    def fetch_revision
      fetch(:nexus_version)
    end
  end
end
