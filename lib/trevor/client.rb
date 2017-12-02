require 'websocket-eventmachine-client'

class Client
  attr_accessor :ws, :host, :rate, :time
  def initialize options 
     @host = options.host
     @rate = options.rate 
     @time = options.time
  end

  def run 
    ws = WebSocket::EventMachine::Client.connect(:uri => @host)
    
    EM.run do 
      ws.onopen do
       
      end 
      
      ws.onmessage do |msg, type|

      end

      ws.onclose do |code, reason|

      end

      EventMachine.next_tick do
        ws.send "test"
      end
    end
  end
end

