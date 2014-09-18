$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "capistrano_scm_nexus/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "capistrano_scm_nexus"
  s.version = CapistranoSCMNexus::VERSION
  s.authors = ["Jen Page"]
  s.email = ["jenipage1989@gmail.com"]
  s.homepage = "https://github.com/jmpage/capistrano_scm_nexus"
  s.license = 'MIT'
  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]
  s.add_dependency "capistrano"
end
