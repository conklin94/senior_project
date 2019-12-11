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
    @entities.each do | entity |
      total_weight += entity.weight
    end
    random_weight = rand(total_weight)
    current_weight = 0

    @entities.each do | entity |
      if random_weight >= current_weight && random_weight < current_weight + entity.weight
        return entity
      else
        current_weight += entity.weight
      end
    end
  end
end
