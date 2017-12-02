require 'optparse'
require 'pp'
require 'ostruct'

class Cli 
  attr_reader :parser, :options
  
  class Options
    attr_accessor :verbose, :clients, :rate, :time, :host
    
    def initialize
      self.verbose = false
      self.host = "http://localhost:8080/ws"
    end

    def define_options(parser)
      parser.banner = "Usage: trevor [options]"
      parser.separator ""
      parser.separator "Common options:"

      # enable option that can be parsed
      number_of_clients(parser)
      request_rate(parser)
      run_length(parser)
      carrot_host(parser)
      
      # Tail options, aren't arguments but they change the output
      parser.on_tail("-h", "--help", "Show this message") do
        puts parser
        exit
      end

      parser.on_tail("--version", "Show version") do
        puts "0.0.1"
        exit
      end
    end
    
    # sets the number of clients to connect to carrot server
    def number_of_clients(parser)
      parser.on("-c", "--clients N", Integer, "Connect N clients to the carrot server") do |clients|
        self.clients = clients.to_i
      end
    end

    def request_rate(parser)
      parser.on("-r", "--rate N", Integer, "Have clients send requests at a rate of N req/sec") do |rate|
        self.rate = rate.to_i
      end
    end

    def run_length(parser)
      parser.on("-t", "--time N", Integer, "Send/Receive requests for N seconds") do |time|
        self.time = time.to_i
      end
    end

    def carrot_host(parser)
      parser.on("-h", "--host [HOST]", String, "Set the host for which to send requests to") do |host|
        self.host = host
      end
    end
  end

  def parse(args)
    @options = Options.new
    @args = OptionParser.new do |parser|
      # option parsing happens here
      @options.define_options(parser)
      parser.parse!(args)
    end
    @options
  end
end
