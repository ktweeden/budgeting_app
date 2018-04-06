# budgey
A budgeting app concept made in week 5 of the [CodeClan](http://codeclan.com) software development course. A live version of the app can be found at [budgey.kate-preston.com](http://budgey.kate-preston.com).

## Brief
The brief for this project was as follows:

You want to start tracking your spending in an attempt to be more frugal so have decided to make a budgeting app to help you see where all of your money is being spent.

You must be able to create new Transactions (which should include a merchant name, e.g. Tesco, and a value) which have an associated Tag (e.g. 'food', 'clothes'). Your app should then be able to track a total, and display this in a view. The app must be made using Ruby, Sinatra, SQL, HTML and CSS and must not use any Javascript.

After meeting this MVP, add any extensions that you think would be useful in a budgeting app.

## Install
* Install Postgres: `$ brew install postgres && brew services start postgresql`
* Install rvm http://rvm.io/
* Install bundler: `$ gem install bundler`
* Install pry: `$ gem install pry`
* `$ git clone ...`

* If prompted, install the version of Ruby required for this project
* Install project gems: `$ bundler install`
* Create development database: `$ createdb budget`
* Set up tables: `$ psql -d budget -f db/budget.sql`
* Seed development database with some data `$ ruby db/seeds.rb`

## Run
* `ruby app.rb`

## Screenshots
### Main page
The main page displays an overview of spending towards budgets for the current month. For the live demo, the transaction seed date is relative to the current date and is refreshed each day using a cron job.
![Main page](https://dl.dropboxusercontent.com/s/eclt9yvrub3hvs9/Screen%20Shot%202018-03-01%20at%2011.47.48.png?dl=0)

### Adding a transaction
Users can add new transactions, merchant and budgets.
![Adding a transaction](https://dl.dropboxusercontent.com/s/zadffnsvrphg0gy/Screen%20Shot%202018-04-06%20at%2013.37.09.png?dl=0)
