# load "deploy/assets"
require "rvm/capistrano"
require "delayed/recipes" 
require "bundler/capistrano"  # Execute "bundle install" after deploy, but only when really needed

set :application, "basepro"

default_run_options[:pty] = true  # Must be set for the password prompt from git to work

set :scm, :git
set :repository,  "https://github.com/liuqi1024/basepro.git"
set :branch, "master"
set :deploy_via, :remote_cache # In most cases you want to use this option, otherwise each deploy will do a full repository clone every time.

# role :web, "10.0.1.189"
# role :app, "10.0.1.189"
# role :db,  "10.0.1.189", :primary => true
server "192.168.192.70", :app, :web, :db, :primary => true
set :user, "liuqi"
set :use_sudo, false
# set :scm_passphrase, "myehome"  # The deploy user's password

# use rvm
set :rvm_ruby_string, :local              # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"       # more info: rvm help autolibs

before 'deploy:setup', 'rvm:install_rvm'  # install RVM
before 'deploy:setup', 'rvm:install_ruby' # install Ruby and create gemset, OR:

# use delayed_job
set :rails_env, "production"

set :deploy_to, "/Users/liuqi/deployment/basepro"

set :normalize_asset_timestamps, false

# set :default_environment, {
#   'PATH' => "/Users/liuqi/.rvm/rubies/ruby-1.9.3-p392/bin:$PATH",
#   'RUBY_VERSION' => 'ruby 1.9.3p392',
#   'GEM_HOME'     => '/Users/liuqi/.rvm/gems/ruby-1.9.3-p392@rails3',
#   'GEM_PATH'     => '/Users/liuqi/.rvm/gems/ruby-1.9.3-p392@rails3',
#   'BUNDLE_PATH'  => '/Users/liuqi/.rvm/gems/ruby-1.9.3-p392@rails3'  # If you are using bundler.
# }

after "deploy:update_code", "deploy:migrate"
after "deploy:finalize_update", "deploy:symlink_config"

after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"
after "deploy:restart", "deploy:cleanup"     # Clean-up old releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "#{current_path}/config/unicorn_init.sh #{command}"
    end
  end
  
  task :symlink_config, roles: :app do
    run "ruby -v"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end
