require 'websocket-eventmachine-client'
require 'json'
require 'byebug'
require_relative 'observer.rb'
require_relative 'runner.rb'

class Client
  include Observer

  attr_accessor :session_token, :runner, :ws, :host, :initialized, :connected, :rate, :time

  def initialize options
    super
    @host = options.host
    @rate = options.rate
    @time = options.time
    @connected = false
    @initialized = false
    @session_token = ""
    @runner = Runner.new

    add(self)
    add(@runner)
    # begin the timeout thread
    Thread.new do
      sleep(time)
      Kernel::exit
    end
  end

  def acknowledge

    puts

    puts "ACK: Calling carrot_transform"

    json = "{ \"session_token\": \"#{@session_token}\", \"endpoint\": \"carrot_transform\", \"payload\": { \"offset\": { \"x\": 0, \"y\": 0, \"z\": 0 } } }"
    # send the acknowledgement message here
    puts "Content: "
    puts "  #{JSON.pretty_generate(JSON.parse(json))}"
    @ws.send json

    puts
  end

  def receive_handshake msg
    message = JSON.parse("#{msg}")
    unless @initialized && message["endpoint"] == "carrot_beacon"
      is_primary = false
      puts
      puts JSON.pretty_generate(message)
      puts
      puts "Processing handshake signal"
      #puts handshakeHash
      @session_token = message["session_token"].to_s
      @runner.session_token = @session_token
      @primary_id = message["payload"]["params"]["uuid"].to_s
      if @sesssion_token == @primary_id
        puts "We are the primary"
        is_primary = true
        @offset = { "x" => 1, "y" => 0, "z" => 0 }
      end
      puts "Am I the primamry? #{is_primary}"
      @connected = true
      @initialized = true
      puts " -- Session token: #{@session_token}"
      puts " -- Connected: #{@connected}"
      puts " -- Initialized: #{@initialized}"
      notify
      puts "Handshake Completed"
    else
      puts JSON.pretty_generate(JSON.parse("#{msg}"))
    end
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
        begin
          receive_handshake msg
        rescue
          puts "Could not find method"
        end
      end

      @ws.onclose do |code, reason|
        puts "Disconnected with code: #{code}"
      end
    end
  end
end
