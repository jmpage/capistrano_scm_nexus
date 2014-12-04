$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'capistrano_scm_nexus/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'capistrano_scm_nexus'
  s.version = CapistranoSCMNexus::VERSION
  s.summary = 'Capistrano SCM Nexus'
  s.description = 'Enables Capistrano 3 to download artifacts from Nexus and extract their contents to the release directory instead of using SCM to deploy an application'
  s.authors = ['Jen Page']
  s.email = ['jenipage1989@gmail.com']
  s.homepage = 'https://github.com/jmpage/capistrano_scm_nexus'
  s.license = 'MIT'
  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']
  s.add_dependency 'capistrano'
end
