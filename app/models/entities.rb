# Source: http://rubyquiz.com/quiz96.html
# Author: Boris Prinz
# Edited by: Seth Conklin
class Entities
  def initialize klass
    @entities = []
    @klass = klass
    yield(self)
  end

  def create *args
    @entities << @klass.new(*args)
  end

  def pick
    @entities[rand(@entities.size)]
  end
end
