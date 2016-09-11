require 'sinatra'
require 'sinatra/subdomain'

require 'slim'
Slim::Engine.set_default_options pretty: true

set :protection, :except => :frame_options

subdomain :message do
  get '/' do
    slim :'message/index'
  end

  post '/message' do
    slim :'message/message'
  end
end

# Register / Sign In app
subdomain :app do
  get '/' do
    slim :'app/index'
  end

  get '/register' do
    slim :'app/register'
  end

  post '/register' do
    slim :'app/registered'
  end

  get '/signin' do
    slim :'app/signin'
  end
end

# selenium-webdriver selectors
subdomain :example3 do
  get '/' do
    slim :'example3/index'
  end
end

subdomain :secret do
  get '/' do
    slim :'secret/index'
  end

  post '/message' do
    slim :'secret/message'
  end
end

subdomain :bomb do
  get '/' do
    slim :'bomb/index'
  end
end

subdomain :html do
  get '/' do
    File.read(File.join('views', 'html', 'index.html'))
  end

  get '/css' do
    File.read(File.join('views', 'html', 'css.html'))
  end
end

subdomain :slow do
  get '/' do
    slim :'slow/index'
  end

  get '/message' do
    slim :'slow/message'
  end

  get '/button' do
    slim :'slow/button'
  end
end
