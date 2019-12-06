class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: :add_feedback

  def check_user
    @story = Story.find(params[:id])
    unless current_user.id == @story.user_id || current_user.admin
      redirect_to(@story, notice: 'You do not have permissions to make changes to this story')
    end
  end

  def add_feedback
    if (params[:add].length + params[:subtract].length == 0)
      render :json => {:success => 'false'}.to_json
    else
      params[:add].split(",").each do | verb_id |
        verb = Verb.find(verb_id)
        if verb.weight < 100
          verb.weight = verb.weight + 5
          verb.save
        end
      end

      params[:subtract].split(",").each do | verb_id |
        verb = Verb.find(verb_id)
        if verb.weight > 5
          verb.weight = verb.weight - 5
          verb.save
        end
      end

      render :json => {:success => 'true'}.to_json
    end
  end

  def index
    @stories = Story.all.order('created_at DESC')
  end

  def build_story
    @story = Story.new
    @random_characters = RandomCharacter.all
    @random_items = RandomItem.all
    @random_places = RandomPlace.all
  end

  def new
    # Source: http://rubyquiz.com/quiz96.html
    # Original Author: Boris Prinz
    # Changed by: Seth Conklin
    @story = Story.new
    @title = params[:title]
    @author = params[:author]

    @cast = Entities.new(Character) do |c|
      params[:name].zip(params[:gender]).each do |name, gender|
        c.create name, gender == 'female' ? :female : :male, 1
      end
    end

    @verbs = Verb.all

    @actions = Entities.new(Action) do |a|
      @verbs.each do |verb|
        objects_or_types = []
        verb.object_or_types.order([:order]).each do |object_or_type|
          objects_or_types << (object_or_type.class_or_string == 'class' ? Object.const_get(object_or_type.name) : object_or_type.name)
        end
        a.create verb.name, objects_or_types, verb.part, verb.weight, verb.id
      end

    end

    @items = Entities.new(Item) do |i|
      params[:item].each do |item|
        i.create item, 1
      end
    end

    @places = Entities.new(Place) do |p|
      params[:place].each do |place|
        p.create place, 1
      end
    end

    @bridges = Entities.new(Bridge) do |b|
      b.create '.', 5
      b.create ', because', 1
      b.create ', while', 1
      b.create '. Later', 1
      b.create '. Then', 1
      b.create '. The next day', 1
      b.create '. And so', 1
      b.create ', but', 1
      b.create '. Soon', 1
      b.create ', and', 1
      b.create ' until', 1
      b.create ' although', 1
    end

    @all = { Character => @cast,   Action => @actions,
            Place     => @places, Item   => @items }

    random_story = RandomStory.new(:cast => @cast, :actions => @actions,
                                    :items => @items, :places => @places,
                                    :bridges => @bridges, :all => @all)
    @story_text = random_story.to_s
    @verbs_used = random_story.verbs
  end

  def create
    @story = Story.new(story_params)

    if @story.save
      redirect_to @story
    else
      render 'new'
    end

  end

  def show
    @story = Story.find(params[:id])
  end

  def update
    @story = Story.find(params[:id])

    if @story.update(story_params)
      redirect_to @story
    else
      render 'edit'
    end
  end

  def edit
    @story = Story.find(params[:id])
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy

    redirect_to stories_path
  end

  private

  def story_params
    params.require(:story).permit(:title,:author,:text,:user_id)
  end
end
