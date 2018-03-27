require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/complete_me'
require 'pry'

class CompleteMeTest < Minitest::Test
  def setup
    @cm = CompleteMe.new
    @cm.insert("pizza")
    @cm.insert("pize")
    @cm.insert("pizzapizza")
    @cm.insert("apple")
    @cm.insert("pizzicato")
    @cm.insert("pizzle")
    @cm.insert("banana")
    @cm.insert("aardvark")
  end

  def test_it_exists
    assert_instance_of CompleteMe, @cm
  end

  def test_it_has_empty_root
    cm = CompleteMe.new
    assert_nil cm.root.value
    assert_instance_of Node, cm.root
  end

  def test_insert
    cm = CompleteMe.new
    cm.insert("pizza")
    leaf = cm.root.child("p")
                   .child("i")
                   .child("z")
                   .child("z")
                   .child("a")
    assert_instance_of Node, leaf
    assert leaf.word?
    empty_children = {}
    assert_equal empty_children, leaf.children
  end

  def test_count
    assert_equal 8, @cm.count
  end

  def test_inserting_duplicates_has_no_effect
    @cm.insert("pizza")
    assert_equal 8, @cm.count
  end

  def test_inserting_superstring_words_will_maintain_substring_as_word
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

  def test_populate
    words = "A\na\naa\naal\naalii\naam\nAani\naardwolf\nAaron\n"
    @cm.populate(words)
    assert_equal 17, @cm.count
  end

  def test_find
    fragment = "pizz"
    found_node = @cm.find(fragment)
    assert_instance_of Node, found_node
    assert_instance_of Node, found_node.child("l")
    assert_instance_of Node, found_node.child("a")
    assert_instance_of Node, found_node.child("i")
    assert_nil found_node.child("e")
  end

  def test_methods_arent_destructive
  end

  def test_traverse
    start_node = @cm.root.child("p")
                    .child("i")
                    .child("z")
                    .child("z")

    traversals = @cm.traverse(start_node, "pizz")
    assert traversals.include? "pizzapizza"
    assert traversals.include? "pizzicato"
    assert traversals.include? "pizzle"

  end

  def test_suggest
    suggestions = ["pize", "pizza", "pizzapizza", "pizzicato", "pizzle"]
    suggestions.each do |suggestion|
        assert @cm.suggest("piz").include? suggestion
    end
    suggestions = ["pizza", "pizzapizza", "pizzicato", "pizzle"]
    suggestions.each do |suggestion|
        assert @cm.suggest("pizz").include? suggestion
    end
  end

  def test_suggest_whole_dictionary
    skip
    @cm.populate(File.read("/usr/share/dict/words"))
    suggestions = ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"]
    suggestions.each do |suggestion|
        assert @cm.suggest("piz").include? suggestion
    end
  end
end
