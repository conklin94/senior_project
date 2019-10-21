# Source: http://rubyquiz.com/quiz96.html
# Original Author: Boris Prinz
# Changed by: Seth Conklin
class Sentence
  attr_accessor :subject
  def initialize (params = {})
    @subject = params.fetch(:cast).pick
    @verb = params.fetch(:actions).pick
    @objects = []
    @verb.objects_or_types.each do |obj_or_type|
      if String === obj_or_type
        @objects << obj_or_type
      else
        if obj_or_type == PossessiveAdjective or
          obj_or_type == ReflexivePronoun
          @objects << obj_or_type.new(@subject.gender)
        else
          thingy = params.fetch(:all)[obj_or_type].pick
          if thingy == @subject
            thingy = ReflexivePronoun.new(thingy.gender)
          end
          @objects << thingy
        end
      end
    end
  end

  def to_s
    [@subject, @verb, @objects].flatten.map{|e| e.to_s}.join(' ')
  end
end
