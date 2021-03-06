class ChefsController < ApplicationController
  before_action :set_chef, except: [:new, :create, :index]
  before_action :require_same_user, only: [:edit, :update]

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
      sessions[:chef_id] = @chef.id
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
      redirect_to @chef
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

    def require_same_user
      if current_user != @chef
        flash[:danger] = 'You can only edit your own profile'
        redirect_to(root_path)
      end
    end
end
