$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.2-p290@rails311'
set :application, "shaoxingjie"
set :user, "deploy"
set :use_sudo, false
set :repository,  "git://github.com/mmxi/shaoxingjie.git"
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :deploy_to, "/var/www/apps/#{application}"
 
set :domain, "61.164.140.203"
role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db, domain, :primary => true # This is where Rails migrations will run
 
set :rails_env, "production"
 
# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts
 
set :rvm_type, :user
default_run_options[:pty] = true
set :default_environment, {
  #'PATH' => "/home/deploy/.rvm/gems/ruby-1.9.2-p290@rails311/bin:/home/deploy/.rvm/gems/ruby-1.9.2-p290@global/bin:/home/deploy/.rvm/rubies/ruby-1.9.2-p290/bin:/home/deploy/.rvm/bin:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/home/deploy/bin",
  'LANG' => "en_US.UTF-8",
  'LC_ALL' => "en_US.UTF-8",
  'RUBY_VERSION' => 'ruby 1.9.2p290',
  'GEM_HOME'     => '/home/deploy/.rvm/gems/ruby-1.9.2-p290',
  'GEM_PATH'     => '/home/deploy/.rvm/gems/ruby-1.9.2-p290',
  'BUNDLE_PATH'  => '/home/deploy/.rvm/gems/ruby-1.9.2-p290'
}

after "deploy", "deploy:bundle_gems"
after "deploy:bundle_gems", "deploy:link_shared_config_yaml"
#after "deploy:bundle_gems", "deploy:compile_assets"
#after "deploy:compile_assets", "deploy:restart"
# If you are using Passenger mod_rails uncomment this:
#bundle install vendor/gems
namespace :deploy do
  task :bundle_gems do
    run "cd #{deploy_to}/current && bundle install --local"
  end
  
  task :link_shared_config_yaml do
    run "ln -sf #{deploy_to}/shared/config/*.yml #{deploy_to}/current/config/"
  end

#  task :compile_assets do
#    run "cd #{deploy_to}/current && bundle exec rake assets:precompile"
#  end
end