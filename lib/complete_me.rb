require_relative './node'

class CompleteMe
  attr_reader :root

  def initialize
    @root = Node.new(nil)
  end

  def insert(word, current = @root)
    first_char = word[0].downcase
    word[0] = ""
    next_node = current.child(first_char)
    if next_node == nil
      next_node = Node.new(first_char)
      current.set_child(first_char, next_node)
    end
    if(word == "")
      next_node.word = true
      return
    end
    insert(word, next_node)
  end

  def count(current = @root)
    a = current.value
    num_child_words = current.children.reduce(0) do |total, (char, child_node)|
      total + count(child_node)
    end
    return num_child_words + 1 if current.word?
    return num_child_words
  end

  def populate(words)
    words.each_line do |word|
      insert(word.chomp)
    end
  end

  def suggest(fragment)
    start_node = find(fragment)
    suffixes = traverse(start_node, "").flatten
    suffixes.map do |suffix|
      fragment + suffix
    end
  end

  def traverse(current, word)
    return word if current.children.count == 0
    current.children.reduce([]) do |words, (char, node)|
      words << traverse(node, word + char.to_s)
    end
  end

  def find(fragment, current = @root)
    return current if fragment == ""
    first_char = fragment[0]
    fragment[0] = ""
    next_node = current.child(first_char)
    return nil if next_node == nil
    find(fragment, next_node)
  end
end
