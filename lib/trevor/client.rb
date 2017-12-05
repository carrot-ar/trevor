require 'websocket-eventmachine-client'
require 'json'
require 'byebug'
require_relative 'observer.rb'
require_relative 'runner.rb'

class Client
  include Observer

  attr_accessor :session_token,
                :runner,
                :ws,
                :host,
                :initialized,
                :connected,
                :rate,
                :time,
                :messages

  def initialize options
    super
    @host = options.host
    @rate = options.rate
    @time = options.time
    @connected = false
    @initialized = false
    @session_token = ""
    @messages = options.messages
    @runner = Runner.new

    add(@runner)

    # begin the timeout thread
    Thread.new do
      sleep(time)
      Kernel::exit
    end
  end

  def handle_handshake msg
    message = JSON.parse("#{msg}")

    if message["endpoint"] == "carrot_beacon"
      @session_token = message["session_token"]
      inject_session_tokens
      resolve_primary_token(message)

      # we should be making sure that the ack process works correctly
      # for primary and non primary devices
      #if !primary?
      #  ack_handshake_received
      #end

      ack_handshake_received

      @initialized = true

      notify
    else
      puts JSON.pretty_generate(JSON.parse("#{msg}"))
      raise ArgumentError.new("Received endpoint was not carrot_beacon")
    end
  end

  def primary?
    @sesssion_token == @primary_token
  end

  def resolve_primary_token message
    @primary_token = message["payload"]["params"]["uuid"].to_s
  end

  def inject_session_tokens
    set_message_token
    @runner.session_token = @session_token
    @runner.message = @messages[:default_message]
  end

  def ack_handshake_received
    puts "ACK: Calling carrot_transform"
    json = @messages["carrot_transform"]["data"].to_json
    # send the acknowledgement message here
    puts "Content: "
    puts "  #{JSON.pretty_generate(JSON.parse(json))}"
    @ws.send json
  end

  def set_message_token
    @messages["carrot_transform"]["data"]["session_token"] = @session_token
    @messages["default_message"]["data"]["session_token"] = @session_token
  end

  def run
    puts "Running client... "

    print "Connecting to #{host} \n"
    EM.run do
      @ws = WebSocket::EventMachine::Client.connect(:uri => @host)
      @runner.ws = @ws
      @ws.onopen do
        puts "Connected"
        @connected = true
      end

      @ws.onmessage do |msg, type|
        if !@initialized
          handle_handshake msg
        end
      end

      @ws.onclose do |code, reason|
        puts "Disconnected with code: #{code}"
      end
    end
  end
end
