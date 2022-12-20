class List
  def initialize(list)
    @list = list
  end

  def move(current)
    index = @list.index(current)
    new_index = index + current.last
    #new_index -= 1 if new_index <= 0
    new_index = new_index % (@list.length - 1)
    if new_index == 0
      new_index = -1
    end

    @list.delete_at(index)
    @list.insert(new_index, current)
    @list
  end
end
