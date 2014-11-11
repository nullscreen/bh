Padrino.configure_apps do
  set :session_secret, '95d177cde28c10318dce7c955cc7a047a410a9a9bed0cf2c4b6032803a223d43'
end

Padrino.mount('TestBh::App', app_file: Padrino.root('app/app.rb')).to('/')
