require 'lib/authorization'

#settings
UPLOAD_PATH = "public/system"

helpers do
  include Sinatra::Authorization
end

#basic routes
get '/' do
  @files = Dir.entries(UPLOAD_PATH)
  erb :index
end

post '/upload' do
  require_admin
  unless params[:file] && (tmpfile = params[:file][:tempfile]) && (name = "#{Time.now.to_i}_#{params[:file][:filename]}")
    redirect('/error/No%file%selected')
  end
  
  File.open(File.join(UPLOAD_PATH, name), "wb") { |f| f.write(tmpfile.read) }
  redirect('/')
end

get '/error/:msg' do
  @error = params[:msg]
  erb :index
end

not_found do
  redirect('/error/Page%20Not%20Found')
end
