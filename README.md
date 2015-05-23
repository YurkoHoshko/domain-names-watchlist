# domain-names-watchlist
Allows users to check basic information about domain name and create list of domain names, that are interesting for user

#Setup

rvm use 2.2@domain-names-watchlist --create
bundle install
rackup

#Usage

Go to http://127.0.0.1:9292/
Type domain name - (i.e google.com) and click on "Get information"
Add domain to watch list
Check that now it appears when you click "Reveal WatchList"

#Tools
Sinatra, Sequel(with in-memory SQLite), WhoIs gem, Angular.js

#ToDo

Check assets configuration - Angular is not not loading templates from Sinatra
Refactor js as it is bloody mess(extract layout to directives, use ngRoutes, etc)
Add handling for backend errors with meaningful error messages
