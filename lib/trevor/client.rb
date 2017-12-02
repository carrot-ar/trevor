require 'websocket-eventmachine-client'
require 'json'

class Client
  attr_accessor :session_token, :ws, :host, :initialized,  :connected, :rate, :time
  def initialize options 
     @host = options.host
     @rate = options.rate 
     @time = options.time
     @connected = false
     @initialized = false
  end

  def run 
    puts host
    
    EM.run do 
      
      ws = WebSocket::EventMachine::Client.connect(:uri => @host)
      
      ws.onopen do
        puts "Connected"
        @connected = true
      end 
      
      ws.onmessage do |msg, type|
        if @initialized
          handshakeHash = JSON.parse(msg)
          puts handshakeHash
          @session_token = handshakeHash["session_token"]
          puts @session_token
          @initialized = true
        end
      end

      ws.onclose do |code, reason|
        puts "Disconnected with code: #{code}"
      end

      EventMachine.next_tick do
        if @connected 
          ws.send "Hello, World!"
        end
        #ws.send "Hello, world!"
      end
    end
  end
end

