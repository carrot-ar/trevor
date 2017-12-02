class Simulator
  attr_accessor :client_count, :clients, :options
 
  # spawn some threads or something and handle clients
 
 
  def initialize options
    @options = options
    @client_count = options.clients
    @clients = []    
    @client_count.times do |i|
      @clients << Thread.new do
        client = Client.new(@options)
        client.run
      end
    end

    @clients.each(&:join)
  end
end
