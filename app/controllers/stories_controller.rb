class StoriesController < ApplicationController

  def index
    @stories = Story.all.order("created_at DESC")
  end

  def build_story
    @story = Story.new
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

    @actions = Entities.new(Action) do |a|
      a.create 'met', [Character]
      a.create 'gave', [Item, 'to', Character]
      a.create 'took', [Item]
      a.create 'ate', [Item]
      a.create 'saw', [Item]
      a.create 'was feeling very hungry', []
      a.create 'was feeling very tired', []
      a.create 'told', [Character, 'to be careful']
      a.create 'lived in', [Place]
      a.create 'lied in', [Place]
      a.create 'went into', [Place]
      a.create 'ran straight to', [Place]
      a.create 'ran away from', [Character, 'as fast as', Pronoun, 'could']
      a.create 'raised', [PossessiveAdjective, 'eyes']
      a.create 'was on', [PossessiveAdjective, 'guard']
      a.create 'sat on', [Item]
      a.create 'pulled out', [Item, 'from', PossessiveAdjective, 'bag']
      a.create 'thought to', [ ReflexivePronoun,
                               '"this sucks"' ]
      a.create 'attacked', [Character, 'with', Item]
      a.create 'cut off the head of', [Character]
      a.create 'was sorry', []
      a.create 'looked very strange', []
      a.create 'was beyond hope', []
      a.create 'fell asleep', []
      a.create 'collapsed to the floor', []
      a.create 'tried to get up', []
      a.create 'begged', [Character, '"Please don\'t do this!"']
      a.create 'snored very loud', []
      a.create 'said to', [Character, ', "How could you do this to me?"']
      a.create 'cut off the arm of', [Character, 'with', Item]
      a.create 'was not afraid of', [Character]
      a.create 'fought valiantly', []
      a.create 'walked for a short time by the side of', [Character]
      a.create 'got deeper and deeper into', [Place]
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
