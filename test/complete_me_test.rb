require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/complete_me'
require 'pry'

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

  def test_count
    @cm.insert("pizza")
    @cm.insert("apple")
    @cm.insert("pizzicato")
    @cm.insert("pizzle")
    @cm.insert("banana")
    @cm.insert("aardvark")
    assert_equal 6, @cm.count
  end

  def test_populate
    words = "A\na\naa\naal\naalii\naam\nAani\naardvark\naardwolf\nAaron\n"
    @cm.populate(words)
    assert_equal 10, @cm.count
  end

  def test_suggest
    @cm.populate(File.read("/usr/share/dict/words"))
    suggestions = ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"]
    assert_equal suggestions, @cm.suggest("piz")
  end
end
