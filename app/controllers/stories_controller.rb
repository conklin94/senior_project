class StoriesController < ApplicationController

  def index
    @stories = Story.all.order("created_at DESC")
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(post_params)

    if @story.save
      redirect_to @story
    else
      render 'new'
    end

  end

  def show
    @story = Story.find(params[:id])
  end

  private

  def post_params
    params.require(:story).permit(:title,:author,:text)
  end
end
