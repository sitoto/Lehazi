# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.    
#require "rvm/capistrano"

set :rvm_ruby_string, '1.9.2'
set :rvm_type, :user
set :rake,"/usr/local/rvm/bin/rake"

# require 'hoptoad_notifier/capistrano'




set :application, "Lehazi"

set :branch, "master"
set :repository,  "git@github.com:sitoto/Lehazi.git"
set :scm, "git"
set :user, "root" # һ���ŷ����ϵĎ����Á����đ��ó�ʽ������Ҫ��sudo���ޣ�������Ҫ�Й��޿����xȡGit repository�õ�ԭʼ�a
set :port, "22"


set :deploy_to, "/var/www/www.lehazi.com"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, "production"

role :web, "www.lehazi.com"
role :app, "www.lehazi.com"
role :db,  "www.lehazi.com", :primary => true

namespace :deploy do

  task :copy_config_files, :roles => [:app] do
    db_config = "#{shared_path}/database.yml"
    run "cp #{db_config} #{release_path}/config/database.yml"
  end
  
  task :update_symlink do
    run "ln -s {shared_path}/public/system {current_path}/public/system"
  end
  
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

# after "deploy:update_code", "deploy:copy_config_files" # ���database.yml����shared�£�Ո���_
# after "deploy:finalize_update", "deploy:update_symlink" # ����Ќ���ʹ�����ς��n����public/system��Ո��