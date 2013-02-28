
countries = [{name: "India", x: 546, y: 166},
             {name: "USA", x: 88, y: 115},
             {name: "UK", x: 342, y: 78},
             {name: "Australia", x: 690, y: 299},
             {name: "Thailand", x: 608, y: 185},
             {name: "South Africa", x: 400, y: 318},
             {name: "Italy", x: 375, y: 105}]

countries.each do |country|
  Country.create(country)
end

User.create(first_name: "test", last_name: "user10", email: "test@user10",
            password: "testuser10", password_confirmation: "testuser10")
