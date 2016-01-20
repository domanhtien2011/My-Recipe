class ChefsController < ApplicationController
  before_action :set_chef, except: [:new, :create, :index]

  def show
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 3)
  end

  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 3)
  end

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Your account was successfully created"
      redirect_to recipes_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @chef.update(chef_params)
      flash[:success] = "Your profile was successfully updated"
      redirect_to recipes_path
    else
      render 'edit'
    end
  end

  private

    def chef_params
      params.require(:chef).permit(:chefname, :email, :password)
    end

    def set_chef
      @chef = Chef.find(params[:id])
    end
end
