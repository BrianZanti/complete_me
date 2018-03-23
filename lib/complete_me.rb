require_relative './node'

class CompleteMe
  attr_reader :root

  def initialize
    @root = Node.new(nil)
  end

  def insert(word, current_node = @root)
    return if word == ""
    first_char = word[0]
    word[0] = ""
    next_node = current_node.child(first_char)
    if next_node == nil
      new_node = Node.new(first_char)
      current_node.set_child(first_char, new_node)
      insert(word, new_node)
    else
      insert(word,next_node)
    end
  end
end
