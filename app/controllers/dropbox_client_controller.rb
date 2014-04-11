
#create new client with provided session token and secret.

def new 
  @client = Dropbox::API::Client.new(:token  => ACCESS_TOKEN, :secret => ACCESS_SECRET)
end

def upload
end 
