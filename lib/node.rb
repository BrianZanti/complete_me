class Node
  attr_reader :value,
              :children

  attr_accessor :word

  def initialize(value, word = false)
    @value = value
    @children = {}
    @word = word
  end

  def set_child(value, node)
    children[value.to_sym] = node
  end

  def child(key)
    children[key.to_sym]
  end

  def word?
    @word
  end
end
