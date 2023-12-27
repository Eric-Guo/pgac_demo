set :rails_env, "production"
set :puma_service_unit_name, :puma_pgac
set :puma_systemctl_user, :system

server "bandwagon", user: "pgac", roles: %w[app db web]
