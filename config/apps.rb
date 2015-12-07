
Padrino.configure_apps do
	myconfig = {
		title: 'KpcKara',
		meta_description: '',
	}

  # enable :sessions
  set :session_secret, '1894af350a30343fda1648fb3290177f45291d63aa14502496c5d49ab9cae0dcad9e'
  set :protection, :except => :path_traversal
  set :protect_from_csrf, true

  # アプリごとの設定
  set :config, myconfig

end

# Mounts the core application for this project
Padrino.mount('Kpckara::App', :app_file => Padrino.root('app/app.rb')).to('/')
