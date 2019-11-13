class StoriesController < ApplicationController

  def index
    @stories = Story.all.order("created_at DESC")
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
        c.create name, gender == "female" ? :female : :male
      end
    end

    @verbs = Verb.all

    @actions = Entities.new(Action) do |a|
      @verbs.each do |verb|
        objects_or_types = []
        verb.object_or_types.order([:order]).each do |object_or_type|
          objects_or_types << (object_or_type.class_or_string == "class" ? Object.const_get(object_or_type.name) : object_or_type.name)
        end
        a.create verb.name, objects_or_types
      end

    end

    @items = Entities.new(Item) do |i|
      params[:item].each do |item|
        i.create item
      end
    end

    @places = Entities.new(Place) do |p|
      params[:place].each do |place|
        p.create place
      end
    end

    @bridges = Entities.new(Bridge) do |b|
      5.times{b.create '.'}
      b.create ', because'
      b.create ', while'
      b.create '. Later'
      b.create '. Then'
      b.create '. The next day'
      b.create '. And so'
      b.create ', but'
      b.create '. Soon'
      b.create ', and'
      b.create ' until'
      b.create ' although'
    end

    @all = { Character => @cast,   Action => @actions,
            Place     => @places, Item   => @items }

    @random_story = RandomStory.new(:cast => @cast, :actions => @actions,
                                    :items => @items, :places => @places,
                                    :bridges => @bridges, :all => @all).to_s
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
    params.require(:story).permit(:title,:author,:text)
  end
end
