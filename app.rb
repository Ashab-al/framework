require_relative 'my_framework'
   
app = MyFramework.new

app.get '/' do |req|
  "<h2>Hello in Style!</h2>"
end

app.get '/about' do |req|
  "This page about"
end
    
app.post '/submit' do |req|
  "Request: #{req.body}"
end

app.start

