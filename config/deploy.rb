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
set :user, "root" # 一個伺服器上的帳戶用來放你的應用程式，不需要有sudo權限，但是需要有權限可以讀取Git repository拿到原始碼
set :port, "22"

set :deploy_to, "/var/www/www.lehazi.com"
set :deploy_via, :remote_cache
set :use_sudo, false

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

# after "deploy:update_code", "deploy:copy_config_files" # 如果將database.yml放在shared下，請打開
# after "deploy:finalize_update", "deploy:update_symlink" # 如果有實作使用者上傳檔案到public/system，請打開