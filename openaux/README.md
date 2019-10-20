# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 2.6.3p62

* Rails version 6.0.0

* System dependencies 
postgresql


* Configuration

steps to install and configure postgresql
brew install postgresql
echo 'export PATH="/usr/local/opt/postgresql@10/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
brew services start postgresql@10
check if installation is successful with ` postgres -V `
expect ` postgres (PostgreSQL) 10.9 ` as an output

echo 'export openaux_DATABASE_PASSWORD="password"' >> ~/.bash_profile

run `rails s` to check for successful configuration 

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
