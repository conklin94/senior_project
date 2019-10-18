class StoriesController < ApplicationController

  def index
    @stories = Story.all.order("created_at DESC")
  end

  def new
    @story = Story.new
    @cast = Entities.new(Character) do |c|
      c.create 'little red-cap', :female
      c.create 'mother', :female
      c.create 'grandmother', :female
      c.create 'the wolf', :male
      c.create 'the huntsman', :male
      c.create 'Julie', :female
    end

    @actions = Entities.new(Action) do |a|
      a.create 'met', [Character]
      a.create 'gave', [Item, 'to', Character]
      a.create 'took', [Item]
      a.create 'ate', [Item]
      a.create 'saw', [Item]
      a.create 'told', [Character, 'to be careful']
      a.create 'lived in', [Place]
      a.create 'lied in', [Place]
      a.create 'went into', [Place]
      a.create 'ran straight to', [Place]
      a.create 'raised', [PossessiveAdjective, 'eyes']
      a.create 'was on', [PossessiveAdjective, 'guard']
      a.create 'thought to', [ ReflexivePronoun,
                               '"what a tender young creature"' ]
      a.create 'swallowed up', [Character]
      a.create 'opened the stomach of', [Character]
      a.create 'looked very strange', []
      a.create 'was delighted', []
      a.create 'fell asleep', []
      a.create 'snored very loud', []
      a.create 'said: "oh,', [Character, ', what big ears you have"']
      a.create 'was not afraid of', [Character]
      a.create 'walked for a short time by the side of', [Character]
      a.create 'got deeper and deeper into', [Place]
    end

    @items = Entities.new(Item) do |i|
      i.create 'a piece of cake'
      i.create 'a bottle of wine'
      i.create 'pretty flowers'
      i.create 'a pair of scissors'
    end

    @places = Entities.new(Place) do |p|
      p.create 'the wood'
      p.create 'the village'
      p.create 'bed'
      p.create "grandmother's house"
      p.create 'the room'
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
