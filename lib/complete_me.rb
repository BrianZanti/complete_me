require_relative './node'

class CompleteMe
  attr_reader :root,
              :selections

  def initialize
    @root = Node.new(nil)
    @selections = Hash.new do |hash, key|
      hash[key] = Hash.new(0)
    end
  end

  def insert(word, current = @root)
    first_char = word[0]
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
    suggestions = traverse(start_node, fragment)
    selections = weigh_selections(fragment)
    combined_suggestions = selections + suggestions
    combined_suggestions.uniq
  end

  def weigh_selections(fragment)
    selections = @selections[fragment.to_sym]
    sorted = selections.sort_by do |word, count|
      count
    end.reverse
    sorted.map do |word, count|
      word.to_s
    end
  end

  def traverse(current, word)
    child_words = []
    if current.word?
      child_words << word
    end
    child_words + current.children.reduce([]) do |words, (char, node)|
      words + traverse(node, word + char.to_s)
    end
  end

  def find(fragment, current = @root)
    return current if fragment == ""
    first_char = fragment[0]
    fragment = fragment[1..-1]
    next_node = current.child(first_char)
    return nil if next_node == nil
    find(fragment, next_node)
  end

  def include?(word)
    node = find(word)
    return false unless node
    node.word?
  end


  def select(fragment, word)
    @selections[fragment.to_sym][word.to_sym] += 1
    insert(word)
  end

  def delete(current = @root, word)
    if word == ""
      if current.children.empty?
        return true
      else
        current.word = false
        return false
      end
    else
      first_char = word[0]
      next_node = current.child(first_char)
      word = word[1..-1]
      delete_next_node = delete(next_node, word)
      return false unless delete_next_node
      current.children.delete(first_char.to_sym)
      return current.children.empty? && !current.word?
    end
  end
    # if word is found and node has no children
      #return true
    # elsif if word is found and node has children
      #set node to not a word
      # return false
    # else node is not found, current node is a parent of the word node
      # figure out what the next node is
      # recursively call delete on next node
      # if recursive call returned false
        # return false
      # else
        # delete the next node
        # return true if current node is not word && has no children
        # otherwise return false
end
