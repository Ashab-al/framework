require_relative 'my_framework'
   
app = MyFramework.new

app.get '/' do |req|
  "Это главная страница"
end

app.get '/about' do |req|
  "Это страницап about"
end
    
app.post '/submit' do |req|
  "Запрос: #{req.body}"
end

app.start

