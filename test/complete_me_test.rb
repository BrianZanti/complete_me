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
    assert leaf.word?
    empty_children = {}
    assert_equal empty_children, leaf.children
  end

  def test_inserting_duplicates_has_no_effect
    @cm.insert("pizza")
    @cm.insert("Pizza")
    assert_equal 1, @cm.count
  end

  def test_inserting_superstring_words_will_maintain_substring_as_word
    @cm.insert("pizza")
    @cm.insert("pizzapizza")
    pizza = @cm.root.child("p")
                    .child("i")
                    .child("z")
                    .child("z")
                    .child("a")
    assert pizza.word?
    pizzapizza = pizza.child("p")
                      .child("i")
                      .child("z")
                      .child("z")
                      .child("a")
    assert pizzapizza.word?
    empty_children = {}
    assert_equal empty_children, pizzapizza.children
  end

  def test_values_are_lower_cased
    @cm.insert("PIZZA")
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
    @cm.insert("pizzapizza")
    @cm.insert("apple")
    @cm.insert("pizzicato")
    @cm.insert("pizzle")
    @cm.insert("banana")
    @cm.insert("aardvark")
    assert_equal 7, @cm.count
  end

  def test_populate
    words = "A\na\naa\naal\naalii\naam\nAani\naardvark\naardwolf\nAaron\n"
    @cm.populate(words)
    assert_equal 9, @cm.count
  end

  def test_find
    @cm.insert("pizza")
    @cm.insert("pizzicato")
    @cm.insert("pizzle")
    found_node = @cm.find("pizz")
    assert_instance_of Node, found_node
    assert_instance_of Node, found_node.child("l")
    assert_instance_of Node, found_node.child("a")
    assert_instance_of Node, found_node.child("i")
    assert_nil found_node.child("e")
  end

  def test_suggest
    skip
    @cm.populate(File.read("/usr/share/dict/words"))
    suggestions = ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"]
    assert_equal suggestions, @cm.suggest("piz")
  end
end
