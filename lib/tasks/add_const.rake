namespace :db do
  desc "add constants"
  task add_const: :environment do

    Constant.create!(stride: 70,
    			swim_steps_per_m: 25,
    			ride_steps_per_km: 2500)
  end
end