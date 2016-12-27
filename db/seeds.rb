# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

total_amount = 100_000_000
current_record_amount = User.count
needed_amount = total_amount - current_record_amount

# username and password should be read from environment variables,
# but this is just an experiment application. It is OK to be hacked.
DB = Sequel.connect('mysql2://performance:performance@localhost:3306/performance_dev')
users = DB.from(:users)
(needed_amount).times.with_index(current_record_amount) do |_, i|
  user = {
      email: Faker::Internet.email,
      last_name: Faker::Name.last_name,
      first_name: Faker::Name.first_name,
      nickname: Faker::Name.name,
      country: Faker::Address.country,
      date_of_birth: Faker::Date.between(50.years.ago, Date.today)
  }
  users.insert(user)
  puts "Done index: #{i}"
end

#  Benchmark.bm(15) do |r|
#    r.report 'ActiveRecord' do
#      require 'benchmark'
#      100_000.times do
#        User.create!(
#            email: Faker::Internet.email,
#            last_name: Faker::Name.last_name,
#            first_name: Faker::Name.first_name,
#            nickname: Faker::Name.name,
#            country: Faker::Address.country,
#            date_of_birth: Faker::Date.between(50.years.ago, Date.today)
#        )
#      end
#    end
#
#    r.report 'Sequel' do
#      DB = Sequel.connect('mysql2://performance:performance@localhost:3306/performance_dev')
#      users = DB.from(:users)
#      100_000.times do
#        user = {
#            email: Faker::Internet.email,
#            last_name: Faker::Name.last_name,
#            first_name: Faker::Name.first_name,
#            nickname: Faker::Name.name,
#            country: Faker::Address.country,
#            date_of_birth: Faker::Date.between(50.years.ago, Date.today)
#        }
#        users.insert(user)
#      end
#    end
#  end
#
#                        user     system      total        real
#  ActiveRecord    135.300000   8.060000 143.360000 (175.092336)
#  Sequel           37.820000   2.510000  40.330000 ( 61.077278)

