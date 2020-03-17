# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :events do
  primary_key :id
  String :title
  String :day_of_week
  String :date
  String :location
  Number :people_registered
  String :cuisine
end
DB.create_table! :rsvps do
  primary_key :id
  foreign_key :event_id
  Boolean :going
  String :name
  String :email
  Number :number_of_people, text: true
  String :dietary_restrictions, text: true
  String :questions, text: true
end
DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
end

# Insert initial (seed) data
events_table = DB.from(:events)

events_table.insert(title: "Kellogg Board Fellows Dinner (Cancelled)", 
                    day_of_week: "Monday",
                    date: "March 30",
                    location: "Sam's Apartment - 1575 Oak",                    
                    people_registered: "5",
                    cuisine: "Italian")

events_table.insert(title: "Cash Cows Small Group Dinner (Cancelled)", 
                    day_of_week: "Sunday",
                    date: "April 5",
                    location: "Koi - 624 Davis",                    
                    people_registered: "8",
                    cuisine: "Japanese")

events_table.insert(title: "Passover", 
                    day_of_week: "Wednesday",
                    date: "April 8",
                    location: "A Jewish facility, without COVID-19, preferably",                    
                    people_registered: "0",
                    cuisine: "Traditional Passover")
                    
events_table.insert(title: "Beer Pong Tournament (cancelled)", 
                    day_of_week: "Saturday",
                    date: "May 2",
                    location: "Evanston Pub",                    
                    people_registered: "25",
                    cuisine: "Alcohol")


puts "Success!"
