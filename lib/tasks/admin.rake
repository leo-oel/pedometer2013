namespace :db do
  desc "add administrator"
  task admin: :environment do

    User.create!(name: "administrator",
                 email: "admin@simasima.org",
                 password: "iamauthorized",
                 password_confirmation: "iamauthorized",
                 admin: true,
                 team_id: 0)
  end
end