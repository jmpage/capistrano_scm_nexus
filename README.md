A gem that enables Capistrano 3 to download artifacts from Artifactory or Nexus
and extract their contents to the release directory instead of using SCM to
deploy an application.

# Usage

Add `gem 'capistrano_scm_nexus'` to your Gemfile.

Add `require 'capistrano_scm_nexus'` to your Capfile.

Set the following configuration variables in `config/deploy.rb` or wherever relevant:

```ruby
set :scm, 'nexus'
set :nexus_endpoint, 'http://nexus.example.com/nexus/content/repositories'
set :nexus_artifact_name, 'my-application'
set :nexus_artifact_version, '1.0.2'
set :nexus_repository, 'releases'
set :nexus_group_id, 'com.example'
```

Based on the information you provide, the Nexus strategy will download a tgz
from the nexus repository and untar and ungzip it into the releases directory.

This gem expects that you have already tarred and gzipped your application and
uploaded it to nexus.
