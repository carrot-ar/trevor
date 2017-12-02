require 'websocket-eventmachine-client'

class Client
  attr_accessor :ws, :host, :rate, :time
  def initialize options 
     @host = options.host
     @rate = options.rate 
     @time = options.time
  end

  def run 
    puts host
    
    EM.run do 
      
      ws = WebSocket::EventMachine::Client.connect(:uri => @host)
      
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

