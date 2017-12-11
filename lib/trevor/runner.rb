require 'json'

# TODO: eventually make message accept the whole parameter map
# TODO: have DSL defined behavior of the runner
class Runner

  attr_accessor :session_token, :ws, :message

  def initialize
    @ws = nil
    @message = message
  end

  def acknowledge
    puts "Starting runner!"
    run
  end

  def run
    Thread.new do
    # TODO: need to get the tick rate of the ruby core reactor
      @count = 0
      loop do
        #sleep(0.01)

        #json = message[:data]
        #puts json.is_a?(String)
        #puts JSON.pretty_generate(json)
        json = "{ \"session_token\": \"#{@session_token}\", \"endpoint\": \"draw\", \"payload\": { \"offset\": { \"x\": 1, \"y\": 1, \"z\": 0, \"params\": { \"foo\": \"bar\" } } } }"
        #puts "Sending: "
        #puts " -- #{JSON.pretty_generate(JSON.parse(json))}"
        @count += 1
        puts "Sent Count #{@count}"

        @ws.send json
        #ws.send "Hello, world!"
      end
    end
  end
end
