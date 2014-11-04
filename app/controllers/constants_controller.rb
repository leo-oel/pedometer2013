class ConstantsController < ApplicationController
  before_action :signed_in_user, only: [:edit]
  before_action :admin_user,     only: [:edit]

  def index
  	@const = Constant.find(1)
  end

#  def edit
#  	@const = Constant.find(1)
#  end

  def show
  	#@const = Constant.find(1)
  end

  def update
  	@const = Constant.find(1)
    if @const.update_attributes(const_params)
      flash[:success] = "Constants updated"
      #redirect_to @const
      render 'index'

    else
      render 'index'
    end
  end

  private

    def const_params
      params.require(:constant).permit(
      	     :stride, :swim_steps_per_m, :ride_steps_per_km, :tally_from, :tally_to )
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
