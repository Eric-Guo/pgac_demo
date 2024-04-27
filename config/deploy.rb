# config valid for current version and patch releases of Capistrano
lock "~> 3.18.1"

set :application, "pgac"
set :repo_url, "https://github.com/Eric-Guo/pgac_demo.git"

# Default branch is :master
set :branch, :master

# Default deploy_to directory is /var/www/pagila_portal
# set :deploy_to, "/var/www/pagila_portal"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, *%w[puma.rb config/database.yml]

# Default value for linked_dirs is []
append :linked_dirs, *%w[log tmp/pids tmp/cache tmp/sockets public/assets storage]

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :rbenv_type, :user
set :rbenv_ruby, "3.2.4"

set :puma_init_active_record, true
set :puma_phased_restart, true

# https://stackoverflow.com/a/59406693/262826
Rake::Task["deploy:assets:backup_manifest"].clear_actions
