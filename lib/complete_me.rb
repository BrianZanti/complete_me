require_relative './node'

class CompleteMe
  attr_reader :root

  def initialize
    @root = Node.new(nil)
  end

  def insert(word, current = @root)
    return if word == ""
    first_char = word[0]
    word[0] = ""
    next_node = current.child(first_char)
    if next_node == nil
      next_node = Node.new(first_char)
      current.set_child(first_char, next_node)
    end
    insert(word, next_node)
  end

  def count(current = @root)
    return 1 if current.children.count == 0
    current.children.reduce(0) do |total, (value, node)|
      total + count(node)
    end
  end

  def populate(words)
    words.each_line do |word|
      insert(word)
    end
  end
end
