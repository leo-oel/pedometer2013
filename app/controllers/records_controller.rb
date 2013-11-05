class RecordsController < ApplicationController

  before_action :signed_in_user
  #before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  
  #def index
  #end

  def create
    @record = current_user.records.build(record_params)
    if @record.save
      flash[:success] = "Record created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end


  def destroy
    @record.destroy
    redirect_to root_url
  end

  #-------------------------
  private

    def record_params
      params.require(:record).permit(:steps, :date, :comment)
    end

    def correct_user  
      @record = current_user.records.find_by(id: params[:id])
      redirect_to root_url if @record.nil?
    end
end
