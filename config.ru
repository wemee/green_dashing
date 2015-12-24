require 'dashing'

configure do
  set :auth_token, '21935dadb69edf3443d315daccd3f6ad'

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
