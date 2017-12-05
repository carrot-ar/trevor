class Simulator
  attr_accessor :client_count, :clients, :options

  # spawn some threads or something and handle clients


  def initialize options
    @options = options
    @client_count = options.clients
#=begin
    @clients = []
    @client_count.times do |i|
      # @clients << Thread.new do
      #   client = Client.new(@options)
      #   client.run
      # end
      #@clients <<  Proc.new do
      #  client = Client.new(@options)
      #  client.run
      #end
      pid = fork {
        client = Client.new(@options)
        client.run
      }

      @clients << pid
    end
#=end

  #client = Client.new(@options)
  #client.run
  end
end
