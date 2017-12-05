require 'json'

# TODO: eventually make message accept the whole parameter map
# TODO: have DSL defined behavior of the runner
class Runner

  attr_accessor :session_token, :ws, :message

  def initialize
    @ws = nil
    @message = ""
  end

  def acknowledge
    puts "Starting runner!"
    run
  end

  def run
    Thread.new do
    # TODO: need to get the tick rate of the ruby core reactor
      loop do
        sleep(1)
        puts
        puts "-- New Tick --"
        puts "I belong to #{@id}"
        puts " -- Session token: #{@session_token}"
        puts
        # generate message
        #ws.send "Hello, World!"
        json = "{\"session_token\":\"#{@session_token}\",\"endpoint\":\"draw\",\"origin\":{\"longitude\":45.50169,\"latitude\":-73.56725},\"payload\":{\"offset\":{\"x\":3,\"y\":1,\"z\":4},\"params\":{\"rick\":\"morty\"}}}"
        puts "Sending: "
        puts " -- #{JSON.pretty_generate(JSON.parse(json))}"
        @ws.send json
        #ws.send "Hello, world!"
      end
    end
  end
end
