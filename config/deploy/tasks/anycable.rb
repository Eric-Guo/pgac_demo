namespace :anycable do
  task :stop do
    on roles(:web) do
      execute :sudo, :systemctl, :stop, fetch(:anycable_rpc_service_name)
      execute :sudo, :systemctl, :stop, fetch(:anycable_go_service_name)
    end
  end

  task :start do
    on roles(:web) do
      execute :sudo, :systemctl, :start, fetch(:anycable_go_service_name)
      execute :sudo, :systemctl, :start, fetch(:anycable_rpc_service_name)
    end
  end

  task :restart do
    on roles(:web) do
      execute :sudo, :systemctl, :restart, fetch(:anycable_go_service_name)
      execute :sudo, :systemctl, :restart, fetch(:anycable_rpc_service_name)
    end
  end
end
