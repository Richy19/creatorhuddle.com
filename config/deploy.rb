set :application, 'creatorhuddle'
set :repo_url, 'git@github.com:arehberg/creatorhuddle.com.git'
set :user, 'deploy'
set :deploy_to, '/home/deploy/apps/creatorhuddle'

set :rbenv_type, :system
set :rbenv_ruby, '2.1.0'

set :unicorn_pid, "#{fetch(:deploy_to)}/shared/tmp/pids/unicorn.pid"
set :unicorn_default_pid, "#{fetch(:deploy_to)}/shared/tmp/pids/unicorn.pid"
set :unicorn_roles, :app

# unicorn is not picking up the rbenv settings at the moment so we're manually adding them to the bundle command
rbenv_prefix = "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :unicorn_bundle, "#{rbenv_prefix} bundle"

# notify rollbar of our deploy
# set :rollbar_token, '<key>'

# we need to explicitly set this here because for some reason
# it is trying to use the symlinked current directory for the Gemfile
# instead of the actual release folder, which isn't going to load
# the correct gemfile
set :bundle_gemfile, -> { release_path.join('Gemfile') }

# debug
set :bundle_flags, '--deployment'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set this to help unicorn use the right paths
set :app_path, "#{fetch(:deploy_to)}/current"

set :scm, :git
set :format, :pretty
set :log_level, :info

set :linked_files, %w{config/database.yml config/unicorn.rb}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'
end

# task :notify_rollbar do
#   on roles(:app) do
#     set :revision, `git log -n 1 --pretty=format:"%H"`
#     set :local_user, `whoami`
#     rails_env = fetch(:rails_env, 'production')
#     rollbar_token = fetch(:rollbar_token, '')
#     execute "curl https://api.rollbar.com/api/1/deploy/ -F access_token=#{rollbar_token} -F environment=#{rails_env} -F revision=#{fetch(:revision)} -F local_username=#{fetch(:local_user)} >/dev/null 2>&1"
#   end
# end
# after :deploy, 'notify_rollbar'

after 'deploy:restart', 'unicorn:restart'

namespace :sidekiq do
  desc "Start sidekiq workers"
  task :start do
    on roles(:app) do
      sudo "/sbin/start workers"
    end
  end

  desc "Stop sidekiq workers"
  task :stop do
    on roles(:app) do
      sudo "/sbin/stop workers"
    end
  end

  desc "Restart sidekiq workers"
  task :restart do
    on roles(:app) do
      sudo "/sbin/restart workers"
    end
  end
end

# after  'deploy:stop',        'sidekiq:stop'
# after  'deploy:start',       'sidekiq:start'
before 'deploy:restart',     'sidekiq:restart'
