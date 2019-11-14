# Source: http://rubyquiz.com/quiz96.html
# Original Author: Boris Prinz
# Changed by: Seth Conklin
require 'enumerator'

class RandomStory
  def initialize (params = {})
    @sentences = []
    @bridges = params.fetch(:bridges)
    all_actions = params[:actions].entities

    # Divide the story into beginning, middle, and end
    params[:actions].entities = all_actions.select {|a| a.part == 'beginning'}
    add_sentences(params, 3)

    params[:actions].entities = all_actions.select {|a| a.part == 'middle'}
    add_sentences(params, 4)

    params[:actions].entities = all_actions.select {|a| a.part == 'end'}
    add_sentences(params, 3)

    combine_subjects
  end

  # Add anywhere from count to 2 x count sentences to the story using the
  # provided parameters
  def add_sentences(params, count)
    1.upto(rand(count)+count) do
      new_sentence = Sentence.new(params)
      while (@sentences.include? new_sentence) do
        new_sentence = Sentence.new(params)
      end
      @sentences << new_sentence
    end
  end

  # When the last sentece had the same subject, replace subject with
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
