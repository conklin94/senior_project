class StoriesController < ApplicationController

  def index
    @stories = Story.all.order("created_at DESC")
  end

  def build_story
    @story = Story.new

    #offset = rand(RandomCharacter.count)
    #@random_author = RandomCharacter.offset(offset).first.name

    @random_characters = RandomCharacter.all
    #1.upto(rand(3)+3) do
    #  offset = rand(RandomCharacter.count)
    #  @random_characters << RandomCharacter.offset(offset).first
    #end

    @random_items = RandomItem.all
    #1.upto(rand(3)+3) do
    #  offset = rand(RandomItem.count)
    #  @random_items << RandomItem.offset(offset).first
    #end

    @random_places = RandomPlace.all
    #1.upto(rand(3)+3) do
    #  offset = rand(RandomPlace.count)
    #  @random_places << RandomPlace.offset(offset).first
    #end

    #@random_title = ''
    #case rand(6)
    #when 0
    #  @random_title = 'The story of ' + @random_characters[rand(@random_characters.length)].name
    #when 1
    #  @random_title = 'Trouble in ' + @random_places[rand(@random_places.length)].name
    #when 2
    #  @random_title = 'The mystery of ' + @random_items[rand(@random_items.length)].name
    #when 3
    #  @random_title = @random_characters[rand(@random_characters.length)].name + ' goes to ' + @random_places[rand(@random_places.length)].name
    #when 4
    #  @random_title = @random_characters[rand(@random_characters.length)].name + ' and ' + @random_items[rand(@random_items.length)].name
    #when 5
    #  @random_title = @random_items[rand(@random_items.length)].name + ' in ' + @random_places[rand(@random_places.length)].name
    #end
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
