# Source: http://rubyquiz.com/quiz96.html
# Original Author: Boris Prinz
# Changed by: Seth Conklin
require 'enumerator'

class RandomStory
  def initialize (params = {})
    @sentences = []
    @bridges = params.fetch(:bridges)
    1.upto(rand(10)+10) do
      @sentences << Sentence.new(params)
    end
    combine_subjects
  end

  # When the last sentece had the sam subject, replace subject with
  # 'he' or 'she'
  def combine_subjects
    @sentences.each_cons(2) do |s1, s2|
      if s1.subject == s2.subject
        s2.subject = Pronoun.new(s1.subject.gender)
      end
    end
  end

  # combine sentences to a story:
  def to_s
    text = 'Once upon a time ' + @sentences[0].to_s
    @sentences[1..-1].each do |sentence|
      bridge = @bridges.pick.to_s
      text += bridge + ' ' +
              ( bridge[-1,1] == '.' ? sentence.to_s.capitalize :
                                      sentence.to_s )
      end
      text.gsub!(/ ,/, ',') # a little clean-up
      text += ". The End."
    end
  end
