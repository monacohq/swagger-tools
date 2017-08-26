require 'sinatra'
require 'yaml'

set :bind, '0.0.0.0'

get '/' do
  'Hello'
end

get '/load' do
  data = File.read(File.expand_path('../data/swagger.yml', __FILE__))
  erb :load, locals: { data: data }
end

__END__

@@ layout
<html>
  <body><%= yield %></body>
</html>

@@ load
<div>Loading swagger.yml to localStorage, will auto refresh when done</div>
<script type="text/javascript">
  const CONTENT_KEY = "swagger-editor-content"
  let localStorage = window.localStorage

  localStorage.setItem(CONTENT_KEY, <%= data.inspect %>)
  console.log(localStorage.getItem(CONTENT_KEY))

  setTimeout(function() {
    window.location = 'localhost:8888'
  }, 10000)
</script>
