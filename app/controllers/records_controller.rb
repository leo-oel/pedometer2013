class RecordsController < ApplicationController

  before_action :signed_in_user
  #before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  
  #def index
  #end

  def create

    @record = current_user.records.build(record_params)
    #@record = current_user.records.new(record_params)
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
      p = params.require(:record).permit(:steps, :recdate, :comment, :activity)

      steps = p["steps"].to_f
      comment = p["comment"]
      activity = p["activity"]
      recdate = Date.parse("#{p['recdate(1i)']}/#{p['recdate(2i)']}/#{p['recdate(3i)']}")
  
      cnst = Constant.find(1)
      case activity 
      when "steps" 
        steps = steps
        comment = comment
      when "km_walk" 
        comment = comment + " [#{steps} km walked]"
        steps = steps*1000*100 / cnst["stride"]   # km -> steps
      when "km_ride" 
        comment = comment + "[#{steps} km rode]"
        steps = steps * cnst["ride_steps_per_km"]
      when "m_swam" 
        comment = comment + "[#{steps} m swam]"
        steps = steps * cnst["swim_steps_per_m"]
      else
        steps = steps
        comment = comment
      end
      return {:steps=>steps.to_i, :comment=>comment, :recdate=>recdate}
    end

    def correct_user  
      @record = current_user.records.find_by(id: params[:id])
      redirect_to root_url if @record.nil?
    end
end
