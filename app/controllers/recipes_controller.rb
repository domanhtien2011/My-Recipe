class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.find(1)

    if @recipe.save
      flash[:success] = "Recipe was created successfully"
      redirect_to(@recipe)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe was updated successfully"
      redirect_to(@recipe)
    else
      render 'edit'
    end
  end

  def destroy

  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
end
