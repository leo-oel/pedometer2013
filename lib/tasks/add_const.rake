namespace :db do
  desc "add Constants"
  task addconst: :environment do

    Constant.create!(stride: 70,
    			swim_steps_per_m: 100,
    			ride_steps_per_km: 100 )
  end
end