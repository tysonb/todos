class TodosController < ApplicationController
  def index
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(params[:todo])
    @todo.save
    redirect_to todos_path
  end
end
