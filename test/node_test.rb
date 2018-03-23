require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/node'

class NodeTest < Minitest::Test
  def test_it_exists
    node = Node.new(nil)
    assert_instance_of Node, node
  end

  def test_it_has_value
    node = Node.new("a")
    assert_equal "a", node.value
  end

  def test_children_starts_as_empty_hash
    node = Node.new("b")
    expected = {}
    assert_equal expected, node.children
  end

  def test_children_can_be_added
    node_a = Node.new("a")
    node_b = Node.new("b")
    node_a.set_child("b", node_b)
    expected = {b: node_b}
    assert_equal expected, node_a.children

  end
end
