class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :like]
  before_action :require_user, except: [:show, :index, :like]
  before_action :require_user_like, only: [:like]
  before_action :require_same_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

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
    @recipe.chef = current_user

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
    @recipe.destroy
    flash[:success] = 'Recipe deleted successfully'
    redirect_to(recipes_url)
  end

  def like
    Like.create(like: params[:like], chef: current_user, recipe: @recipe)
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
      params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids: [], ingredient_ids: [])
    end

    def require_same_user
      if current_user != @recipe.chef && !current_user.admin?
        flash[:danger] = 'You can only edit your own recipe'
        redirect_to(recipes_path)
      end
    end

  def require_user_like
    if !logged_in?
      flash[:danger] = 'You must log in to perfor this action'
      redirect_to :back
    end
  end

  def admin_user
    redirect_to(recipes_url) unless current_user.admin?
  end
end
