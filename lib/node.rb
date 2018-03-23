class Node
  attr_reader :value,
              :children

  def initialize(value)
    @value = value
    @children = {}
  end

  def set_child(value, node)
    children[value.to_sym] = node
  end
end
