namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    teams=["usagi", "kame", "mogura", "ebi"]
    teams.each{ |name|
        Team.create!(name: name)
    }


    User.create!(name: "Example User",
                 email: "example@railstutorial.jp",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true,
                 team_id: 0)
    
    19.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.jp"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   team_id: rand(teams.size+1) )
    end


  end
end