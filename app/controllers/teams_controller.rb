class TeamsController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy


  def index
    @teams = Team.paginate(page: params[:page])
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def show
 	@team = Team.find(params[:id])
    @users = User.all
  end


  def update
    if @team.update_attributes(team_params)
      flash[:success] = "Team profile updated"
      redirect_to @team
    else
      render 'edit'
    end
  end


  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @team
    else
      render 'new'
    end
  end


  def destroy
    Team.find(params[:id]).destroy
    flash[:success] = "Team destroyed."
    redirect_to users_url
  end

  #---------
  private

    def team_params
      params.require(:team).permit(:name)
    end

    # Before actions

    # moved to application_helper.rb
    #def signed_in_user
    #  unless signed_in?
    #    store_location
    #    redirect_to signin_url, notice: "Please sign in."
    #  end
    #end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
