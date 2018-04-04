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
