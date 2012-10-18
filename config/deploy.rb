require "bundler/capistrano"

set :application, "Self assessment"
set :repository, "file:///var/www/git/self_assessment.git"
set :local_repository,  "ssh://rnic@wvtcent1/var/www/git/self_assessment.git"

set :scm, :git
set :deploy_to, '~/public_html'

# run 'bundle cache' and commit the gems put into vendor/cache to git master before running deploy
set :bundle_flags, '--local'

role :web, "wvtcent1"                          # Your HTTP server, Apache/etc
role :app, "wvtcent1"                          # This may be the same as your `Web` server
role :db,  "wvtcent1", :primary => true        # This is where Rails migrations will run

set :user, 'rnic'
set :use_sudo, false
set :scm_username, 'rnic'

load 'deploy/assets'

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

