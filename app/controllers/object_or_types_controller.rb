class ObjectOrTypesController < ApplicationController
  def new
    @object_or_type = ObjectOrType.new
    @verb_id = params[:verb_id]
  end

  def create
    @object_or_type = ObjectOrType.new(object_or_type_params)

    if @object_or_type.save
      @verb = Verb.find(@object_or_type.verb_id)
      redirect_to edit_verb_path(@verb)
    else
      render 'new'
    end

  end

  def update
    @object_or_type = ObjectOrType.find(params[:id])

    if @object_or_type.update(object_or_type_params)
      @verb = Verb.find(@object_or_type.verb_id)
      redirect_to edit_verb_path(@verb)
    else
      render 'edit'
    end
  end

  def edit
    @object_or_type = ObjectOrType.find(params[:id])
  end

  def destroy
    @object_or_type = ObjectOrType.find(params[:id])
    @verb = Verb.find(@object_or_type.verb_id)
    @object_or_type.destroy

    redirect_to edit_verb_path(@verb)
  end

  private

  def object_or_type_params
    params.require(:object_or_type).permit(:name,:class_or_string,:order,:verb_id)
  end
end
