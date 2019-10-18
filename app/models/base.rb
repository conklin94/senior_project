# Source: http://rubyquiz.com/quiz96.html
# Author: Boris Prinz
class Base
  def self.constructor *args
    attr_accessor(*args)
    define_method :initialize do |*values|
      (0..(args.size - 1)).each do |i|
        self.instance_variable_set("@#{args[i]}", values[i])
      end
    end
  end

  def to_s
    @name
  end
end
