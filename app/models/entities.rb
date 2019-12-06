# Source: http://rubyquiz.com/quiz96.html
# Author: Boris Prinz
# Changed by: Seth Conklin
class Entities
  def initialize klass
    @entities = []
    @klass = klass
    yield(self)
  end

  def create *args
    @entities << @klass.new(*args)
  end

  def entities
    @entities
  end

  def entities=(entities)
    @entities = entities
  end

  def pick
    total_weight = 0
    @entities.each do |entity|
      total_weight += entity.weight
    end
    random_weight = rand(total_weight)
    current_weight = 0
    index = 0
    done = false
    until done do
      if current_weight + @entities[index].weight >= random_weight
        done = true
      else
        current_weight += @entities[index].weight
        index += 1
      end
    end
    return @entities[index]
  end
end
