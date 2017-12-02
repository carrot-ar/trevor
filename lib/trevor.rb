require 'pp'
require_relative "trevor/cli"
require_relative "trevor/simulator"
require_relative "trevor/client"

class Trevor
  def initialize args = []
    cli = Cli.new
    options = cli.parse(args)
    Simulator.new(options)
  end
end


