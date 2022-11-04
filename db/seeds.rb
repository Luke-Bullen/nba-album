# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"
require "open-uri"
require 'pp'

# Destroying all instances of the database
puts "----------------------------------------------------------------"
puts " Destroying all instances"
puts "----------------------------------------------------------------"
AlbumCard.destroy_all
Card.destroy_all
Album.destroy_all
User.destroy_all
QuizAnswer.destroy_all
Quiz.destroy_all

puts "----------------------------------------------------------------"
puts "seeding the database"
puts "----------------------------------------------------------------"
teams_url = 'https://data.nba.net/data/10s/prod/v2/2021/teams.json'

teams_serialized = URI.open(teams_url).read
# teams_serialized = File.open('teams.json').read
teams_json = JSON.parse(teams_serialized)
teams_list = teams_json["league"]["standard"]

puts "----------------------------------------------------------------"
puts " Getting list of all teams"
puts "----------------------------------------------------------------"

TEAMS = {}
teams_list.each do |team|
  if team["isNBAFranchise"] == true
    TEAMS[team["teamId"]] = team["fullName"]
  end
end

puts "----------------------------------------------------------------"
puts "NBA TEAMS LIST"
puts "----------------------------------------------------------------"

pp TEAMS

puts "----------------------------------------------------------------"
puts "Generating hash with all data"
puts "----------------------------------------------------------------"

rosters = {}
rosters["teams"] = []

TEAMS.each do |team|
  rooster_team = {}
  rooster_team["id"] = team[0]
  rooster_team["name"] = team[1]
  rooster_team["players"] = []
  rosters["teams"] << rooster_team
end

seasons = ["2019", "2020", "2021"]

################################################################################################
# Looping through players by season
################################################################################################
seasons.each do |season|
  puts "----------------------------------------------------------------"
  puts "Season #{season}"
  puts "----------------------------------------------------------------"

  players_url = "https://data.nba.net/10s/prod/v1/#{season}/players.json"

  players_serialized = URI.open(players_url).read

  # players_serialized = File.open('players.json').read
  players_json = JSON.parse(players_serialized)
  players_list = players_json["league"]["standard"]

  players_list.each do |player|
    if TEAMS.key?(player["teamId"])
      puts "----------------------------------------------------------------"
      puts "Collecting data for players"
      puts "----------------------------------------------------------------"
      team = rosters["teams"].select { |t| t["id"] == player["teamId"] }
      player_to_add = Hash.new
      player_to_add["id"] = player["personId"]
      player_to_add["firstName"] = player["firstName"]
      player_to_add["lastName"] = player["lastName"]
      player_to_add["birthdate"] = player["dateOfBirthUTC"]
      player_to_add["height"] = player["heightMeters"]
      player_to_add["weight"] = player["weightKilograms"]
      player_to_add["position"] = player["teamSitesOnly"]["posFull"]
      player_to_add["team"] = TEAMS[player["teamId"]]
      player_to_add["image"] = "https://cdn.nba.com/headshots/nba/latest/1040x760/#{player['personId']}.png"

      # Add data from profile URL
      profile_url = "https://data.nba.net/data/10s/prod/v1/#{season}/players/#{player['personId']}_profile.json"
      # profile_url = "https://data.nba.net/data/10s/prod/v1/2021/players/1630554_profile.json"
      profile_serialized = URI.open(profile_url).read
      profile_json = JSON.parse(profile_serialized)
      pp profile_url
      pp profile_json
      p profile_json["league"]["standard"]["stats"]["regularSeason"]["season"].empty?
      if profile_json["league"]["standard"]["stats"]["regularSeason"]["season"].empty?
        player_to_add["points"] = 8.3
        player_to_add["rebounds"] = 4.9
        player_to_add["assists"] = 2.3
        player_to_add["minutes"] = 5.5
      else
        player_profile = profile_json["league"]["standard"]["stats"]["regularSeason"]["season"][0]["teams"][0]
        player_to_add["points"] = player_profile["ppg"]
        player_to_add["rebounds"] = player_profile["rpg"]
        player_to_add["assists"] = player_profile["apg"]
        player_to_add["minutes"] = player_profile["mpg"]
      end
      team[0]["players"] << player_to_add
      team[0]["players"] = team[0]["players"].sort_by { |player_ordered| player_ordered["minutes"].to_f }.reverse!
    end
  end

  index = 1
  rosters["teams"].each do |team|
    puts "----------------------------------------------------------------"
    puts "Iterating all teams"
    puts "----------------------------------------------------------------"
    team["players"][0..5].each do |player|
      puts "----------------------------------------------------------------"
      puts "Adding player with index #{index}"
      puts "----------------------------------------------------------------"
      name = "#{player['firstName']} #{player['lastName']}"
      team = player["team"]
      position = player["position"]
      birthdate = player["birthdate"]
      height = player["height"]
      weight = player["weight"]
      points = player["points"]
      rebounds = player["rebounds"]
      assists = player["assists"]
      image = player["image"]
      card = Card.new(name: name, birthdate: birthdate, height: height, weight: weight, season: season, image: image,
        position: position, points: points, rebounds: rebounds, assists: assists, team: team, index: index)
        card.save!
      index = index + 1
    end
  end

  # empty players for next season
  rosters["teams"].each do |team|
    team["players"] = []
  end
end

# adding a user
user = User.new({
                  email: "kobe1@lakers.com",
                  password: "password",
                  first_name: "Kobe",
                  last_name: "Bryant",
                  nickname: "Black Mamba"
                })
user.save!

# # create 3 albums for the user
seasons = Card.distinct.pluck(:season)
seasons.each { |season| Album.create!(season: season, user: user) }

# Add quizzes
quiz1 = Quiz.new(question: "Where was Michael Jordan born?")
quiz1.save!
QuizAnswer.create(quiz: quiz1, text: 'Brooklyn, NY', correct: true)
QuizAnswer.create(quiz: quiz1, text: 'Chicago, IL', correct: false)
QuizAnswer.create(quiz: quiz1, text: 'Atlanta, GH', correct: false)

quiz2 = Quiz.new(question: "Which team won the championship in 1993?")
quiz2.save!
QuizAnswer.create(quiz: quiz2, text: 'Los Angeles Lakers', correct: false)
QuizAnswer.create(quiz: quiz2, text: 'Chicago Bulls', correct: true)
QuizAnswer.create(quiz: quiz2, text: 'Detroit Pistons', correct: false)

quiz3 = Quiz.new(question: "Who is the top scorer of all time?")
quiz3.save!
QuizAnswer.create(quiz: quiz3, text: 'Lebron James', correct: false)
QuizAnswer.create(quiz: quiz3, text: 'Michael Jordan', correct: false)
QuizAnswer.create(quiz: quiz3, text: 'Kareem Abdul-Jabbar', correct: true)

quiz4 = Quiz.new(question: "What is depicted on the logo of the Golden State Warriors?")
quiz4.save!
QuizAnswer.create(quiz: quiz4, text: 'A bridge', correct: true)
QuizAnswer.create(quiz: quiz4, text: 'A basketball', correct: false)
QuizAnswer.create(quiz: quiz4, text: 'A spearhead', correct: false)

quiz5 = Quiz.new(question: "Who won more championships, Kobe or Shaq?")
quiz5.save!
QuizAnswer.create(quiz: quiz5, text: 'Kobe', correct: true)
QuizAnswer.create(quiz: quiz5, text: 'Shaq', correct: false)
QuizAnswer.create(quiz: quiz5, text: 'They are tied', correct: false)

quiz6 = Quiz.new(question: "What is the record for most regular season wins, set by the Golden State Warriors in 2015–16?")
quiz6.save!
QuizAnswer.create(quiz: quiz6, text: '69', correct: false)
QuizAnswer.create(quiz: quiz6, text: '73', correct: true)
QuizAnswer.create(quiz: quiz6, text: '76', correct: false)

quiz7 = Quiz.new(question: "How long is a regular-season NBA game?")
quiz7.save!
QuizAnswer.create(quiz: quiz7, text: '48 minutes', correct: true)
QuizAnswer.create(quiz: quiz7, text: '56 minutes', correct: false)
QuizAnswer.create(quiz: quiz7, text: '60 minutes', correct: false)

quiz8 = Quiz.new(question: "Michael Jordan made his NBA debut in which year?")
quiz8.save!
QuizAnswer.create(quiz: quiz8, text: '1982', correct: false)
QuizAnswer.create(quiz: quiz8, text: '1983', correct: false)
QuizAnswer.create(quiz: quiz8, text: '1984', correct: true)

quiz9 = Quiz.new(question: "When was the NBA established?")
quiz9.save!
QuizAnswer.create(quiz: quiz9, text: '1942', correct: false)
QuizAnswer.create(quiz: quiz9, text: '1944', correct: false)
QuizAnswer.create(quiz: quiz9, text: '1946', correct: true)

quiz10 = Quiz.new(question: "Who won the championship in 2011?")
quiz10.save!
QuizAnswer.create(quiz: quiz10, text: 'Miami Heat', correct: false)
QuizAnswer.create(quiz: quiz10, text: 'Dallas Mavericks', correct: true)
QuizAnswer.create(quiz: quiz10, text: 'Los Angeles Lakers', correct: false)

quiz11 = Quiz.new(question: "Who was the 2008 finals MVP?")
quiz11.save!
QuizAnswer.create(quiz: quiz11, text: 'Kobe Bryant', correct: false)
QuizAnswer.create(quiz: quiz11, text: 'Pau Gasol', correct: false)
QuizAnswer.create(quiz: quiz11, text: 'Paul Pierce', correct: true)

quiz12 = Quiz.new(question: "Who has the most NBA championships as head coach?")
quiz12.save!
QuizAnswer.create(quiz: quiz12, text: 'Phil Jackson', correct: true)
QuizAnswer.create(quiz: quiz12, text: 'Steve Kerr', correct: false)
QuizAnswer.create(quiz: quiz12, text: 'Red Auerbach', correct: false)

quiz13 = Quiz.new(question: "Which team won the first-ever NBA game?")
quiz13.save!
QuizAnswer.create(quiz: quiz13, text: 'New York Knicks', correct: true)
QuizAnswer.create(quiz: quiz13, text: 'Bostons Celtics', correct: false)
QuizAnswer.create(quiz: quiz13, text: 'Toronto Huskies', correct: false)

quiz14 = Quiz.new(question: "Who was voted the MVP for the 2014-15 season?")
quiz14.save!
QuizAnswer.create(quiz: quiz14, text: 'LeBron James', correct: false)
QuizAnswer.create(quiz: quiz14, text: 'Stephen Curry', correct: true)
QuizAnswer.create(quiz: quiz14, text: 'James Harden', correct: false)

quiz15 = Quiz.new(question: "Who was the first pick in the 2022 draft?")
quiz15.save!
QuizAnswer.create(quiz: quiz15, text: 'Cade Cunningham', correct: false)
QuizAnswer.create(quiz: quiz15, text: 'Jabari Smith Jr.', correct: false)
QuizAnswer.create(quiz: quiz15, text: 'Paolo Banchero', correct: true)
