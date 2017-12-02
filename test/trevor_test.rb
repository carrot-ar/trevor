require "test_helper"
require 'pp'

class TrevorTest < Minitest::Test
  def test_cli_defaults
    trevor = Trevor.new
    assert_equal("http://localhost:8080/ws", trevor.options.host)
    assert_equal(false, trevor.options.verbose)
  end
  
  def test_cli_number_of_clients
    trevor = Trevor.new ["-c", "1000"]
    assert_equal(1000, trevor.options.clients)
  end

  def test_cli_request_rate
    trevor = Trevor.new ["-r", "1000"]
    assert_equal(1000, trevor.options.rate)
  end

  def test_cli_run_length
    trevor = Trevor.new ["-t", "1000"]
    assert_equal(1000, trevor.options.time)
  end
end
