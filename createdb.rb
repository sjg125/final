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
  String :time
  String :location
  String :location_name
  Number :event_size
  String :cuisine
end
DB.create_table! :rsvps do
  primary_key :id
  foreign_key :event_id
  foreign_key :user_id
  Boolean :going
  String :name
  String :phone
  String :dietary_restrictions, text: true
  String :questions_comments, text: true
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
                    time: "7-9pm",
                    location: "1575 Oak Avenue, Evanston, IL 60201",    
                    location_name: "Sam and Sara's Apartment",       
                    event_size: "5",
                    cuisine: "Italian")

events_table.insert(title: "Cash Cows Small Group Dinner (Cancelled)", 
                    day_of_week: "Sunday",
                    date: "April 5",
                    time: "7:30-10pm",
                    location: "624 Davis Street, Evanston, IL 60201",    
                    location_name: "Koi Restaurant",                
                    event_size: "8",
                    cuisine: "Japanese")

events_table.insert(title: "Passover", 
                    day_of_week: "Wednesday",
                    date: "April 8",
                    time: "8pm-12am",
                    location: "2020 Orrington Avenue, Evanston, IL 60201",       
                    location_name: "A Jewish facility, without COVID-19",
                    event_size: "10",
                    cuisine: "Traditional Passover")
                    
events_table.insert(title: "Beer Pong Tournament (Cancelled)", 
                    day_of_week: "Saturday",
                    date: "May 2",
                    time: "9:30-whenever",
                    location: "1601 Sherman, Evanston, IL 60201",    
                    location_name: "Evanston Pub",                
                    event_size: "32",
                    cuisine: "Alcohol")

puts "Success!"
