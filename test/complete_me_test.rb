require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/complete_me'

class CompleteMeTest < Minitest::Test
  def test_it_exists
    cm = CompleteMe.new
    assert_instance_of CompleteMe, cm
  end
end
