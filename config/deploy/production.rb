set :rails_env, "production"
set :puma_service_unit_name, :puma_pgac
set :puma_systemctl_user, :system
set :anycable_go_service_name, "pgac-anycable-go"
set :anycable_rpc_service_name, "pgac-anycable-rpc"

server "bandwagon", user: "pgac", roles: %w[app db web]

after "deploy:publishing", "anycable:restart"
