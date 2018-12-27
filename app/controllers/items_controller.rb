class ItemsController < ApplicationController
  # actions for find params
  before_action :set_todo
  before_action :set_todo_item, only: ["show", "update", "destroy"]

  def index
    json_response(@items = @todo.items)
  end

  def show
    json_response(@item)
  end

  def create
    @todo.items.create!(item_params)
    json_response(@todo, :created)
  end

  def update
    @item.update(item_params)
    head :no_content
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def item_params
    params.permit(:name, :done)
  end

  def set_todo
    @todo = Todo.find(params[:todo_id])
  end

  def set_todo_item
    if @todo
      @item = @todo.items.find_by!(params[:id])
    end
  end

end
