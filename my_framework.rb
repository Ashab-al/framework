require 'webrick'

class MyFramework
  def initialize
    @routes = {} # Все маршруты в виде Hash
  end

  #обработчик get запроса
  def get(path, &block)
    return unless block_given?
    @routes[path] = {method: 'GET', block: block}
  end

  #обработчик post запроса
  def post(path, &block)
    return unless block_given?
    @routes[path] = {method: 'POST', block: block}
  end

  # запуск сервера webrick
  def start(port = 8000)
    server = WEBrick::HTTPServer.new(:Port => port)

    # обрабатываем каждый запрос
    server.mount_proc '/' do |req, res|
      handle_request(req, res)
    end

    trap('INT') { server.shutdown }

    server.start
  end

  private

  def handle_request(req, res)
    route = @routes[req.path]
    if route && req.request_method == route[:method]
      # возврат ответа с существующего route
      response = route[:block].call(req)
      res.body = response
    else
      # Возврат 404
      res.status = 404
      res.body = ['Not found']
    end
  end
end