class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :like]

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 4)
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

  def like
    Like.create(like: params[:like], chef: Chef.first, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your voting was successful"
      redirect_to(:back)
    else
      flash[:warning] = "You can only like/dislike a recipe once"
      redirect_to(:back)
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
end
