# OpenBudgets

OpenBudgets is a Rails 5 application.

## Development environment configuration

Prerequisites: Git, Ruby 2.3.1, Bundler gem, npm and PostgreSQL.

To prepare the environment:
```
$ bundle install
$ bin/rails db:create
$ bin/rails db:migrate
$ bin/rails db:fixtures:load
$ bin/rails db:test:prepare
```

To add d3.js custom bundle ([using npm & Rollup](https://bl.ocks.org/mbostock/bb09af4c39c79cffcde4)):
```
$ npm install
```

Run the tests with:
```
$ bin/rails t
````

Run the app with:
```
$ bin/rails s
```

To inspect the contents of the emails sent by the app, use the following URL:
```
http://localhost:3000/rails/mailers/
```
