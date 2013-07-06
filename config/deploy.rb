set :application, "basepro"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

default_run_options[:pty] = true 
set :scm, :git
set :repository,  "https://github.com/liuqi1024/basepro.git"
set :user, "liuqi"
# set :scm_passphrase, "myehome"  # The deploy user's password

role :web, "10.0.2.26"
role :app, "10.0.2.26"
role :db,  "10.0.2.26", :primary => true
# server "10.0.2.26", :app, :web, :db, :primary => true

# use rvm
require "rvm/capistrano"
set :rvm_ruby_string, :local              # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"       # more info: rvm help autolibs

before 'deploy:setup', 'rvm:install_rvm'  # install RVM
before 'deploy:setup', 'rvm:install_ruby' # install Ruby and create gemset, OR:

set :use_sudo, false

set :deploy_to, "/Users/liuqi/deployment/basepro"

set :normalize_asset_timestamps, false

set :deploy_via, :remote_cache

# set :default_environment, {
#   'PATH' => "/Users/liuqi/.rvm/rubies/ruby-1.9.3-p392/bin:$PATH",
#   'RUBY_VERSION' => 'ruby 1.9.3p392',
#   'GEM_HOME'     => '/Users/liuqi/.rvm/gems/ruby-1.9.3-p392@rails3',
#   'GEM_PATH'     => '/Users/liuqi/.rvm/gems/ruby-1.9.3-p392@rails3',
#   'BUNDLE_PATH'  => '/Users/liuqi/.rvm/gems/ruby-1.9.3-p392@rails3'  # If you are using bundler.
# }

namespace :deploy do

  task :start do 
    # run "sudo /opt/nginx/sbin/nginx"
  end
  
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  task :symlink_config, roles: :app do
    run "ruby -v"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  
  # task :precompile, :role => :app do  
  #   run "cd #{release_path}/ && rake assets:precompile -trace"  
  # end 
  
  after "deploy:finalize_update", "deploy:symlink_config"
end



# set :application, "basepro"
# set :repository,  "git@github.com:liuqi1024/basepro.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end