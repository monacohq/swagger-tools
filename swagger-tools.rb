require 'sinatra'
require 'yaml'

set :bind, '0.0.0.0'

def data_file
  File.expand_path('../data/swagger.yml', __FILE__)
end

get '/' do
  'Hello'
end

get '/load' do
  data = File.read(data_file)
  erb :load, layout: :layout, locals: { data: data }
end

get '/please' do
  erb :please, layout: :layout
end

post '/save' do
  request.body.rewind
  data = request.body.read
  File.open(data_file, 'w') do |f|
    f.write(data)
  end
end

__END__

@@ layout
<html>
  <head>
    <script type="text/javascript">
      const CONTENT_KEY = "swagger-editor-content"
      let localStorage = window.localStorage
    </script>
  </head>
  <body><%= yield %></body>
</html>

@@ load
<div>Loading swagger.yml to localStorage, will auto refresh when done</div>
<script type="text/javascript">
  localStorage.setItem(CONTENT_KEY, <%= data.inspect %>)
  setTimeout(function() { window.location = "/" }, 5000)
</script>

@@ please
<div>Posting localStorage content to server for saving to swagger.yml, close this yourself when done (check Terminal)</div>
<script type="text/javascript">
  let data = localStorage.getItem(CONTENT_KEY)
  let req = new XMLHttpRequest()
  req.open("POST", "/save", true)
  req.setRequestHeader("Content-Type", "text/plain")
  req.send(data)
</script>
