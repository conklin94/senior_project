# Source: http://rubyquiz.com/quiz96.html
# Author: Boris Prinz
class PronounBase < Base
  constructor :gender
  class << self
    attr_accessor :cases
  end

  def to_s
    cases = self.class.cases
    @gender == :female ? cases[0] : cases[1]
  end
end
