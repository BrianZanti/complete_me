require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/complete_me'

class CompleteMeTest < Minitest::Test
  def setup
    @cm = CompleteMe.new
  end

  def test_it_exists
    assert_instance_of CompleteMe, @cm
  end

  def test_it_has_empty_root
    @cm = CompleteMe.new
    assert_nil @cm.root.value
    assert_instance_of Node, @cm.root
  end

  def test_insert
    @cm.insert("pizza")
    leaf = @cm.root.child("p")
                   .child("i")
                   .child("z")
                   .child("z")
                   .child("a")
    assert_instance_of Node, leaf
    empty_children = {}
    assert_equal empty_children, leaf.children
  end

end
