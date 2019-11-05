class VerbsController < ApplicationController
  def index
    @verbs = Verb.all.order("part, created_at")
  end

  def new
    @verb = Verb.new
  end

  def create
    @verb = Verb.new(verb_params)

    if @verb.save
      @verb.reload
      if params[:object_name]
        params[:object_name].zip(params[:class_or_string], params[:object_order]).each do |name, class_or_string, order|
          @verb.object_or_types.create(name: name, class_or_string: class_or_string, order: order)
        end
      end
      redirect_to @verb
    else
      render 'new'
    end

  end

  def show
    @verb = Verb.find(params[:id])
  end

  def update
    @verb = Verb.find(params[:id])

    if @verb.update(verb_params)
      redirect_to @verb
    else
      render 'edit'
    end
  end

  def edit
    @verb = Verb.find(params[:id])
  end

  def destroy
    @verb = Verb.find(params[:id])
    @verb.destroy

    redirect_to verbs_path
  end

  private

  def verb_params
    params.require(:verb).permit(:name,:part)
  end
end
