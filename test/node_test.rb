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
    node_b = Node.new("b")
    node_b = Node.new("b")
    node_a.set_child("b", node_b)
    expected = {b: node_b}
    assert_equal expected, node_a.children
  end

  def test_child
    node_a = Node.new("a")
    node_b = Node.new("b")
    node_c = Node.new("c")
    node_d = Node.new("d")
    node_a.set_child("b", node_b)
    node_a.set_child("c", node_c)
    node_a.set_child("d", node_d)
    assert_equal node_c, node_a.child("c")
    assert_equal node_d, node_a.child("d")
  end

  def test_is_not_word_node_by_default
    node = Node.new("a")
    refute node.word?
  end

  def test_can_be_created_as_word_node
    node = Node.new("a", true)
    assert node.word?
  end

  def test_non_word_node_can_be_set_as_word_node
    node = Node.new("a")
    node.set_as_word
    assert node.word?
  end
end
