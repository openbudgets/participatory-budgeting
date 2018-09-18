# OpenBudgets Participatory Budgeting

In a democracy, budgets are a key instrument of policy making. They are the result of an extensive and complex process,
traditionally executed by the political leadership. The decisions involving budgets have the potential to affect the
lives of citizens on the entire social spectrum by shifting focus to one priority over another, by introducing change
to the environment, or by impacting long-term nexuses. The idea behind the concept of participatory budgeting is to
provide the electorate with an opportunity to impact the decision-making process behind budgets.

An often neglected but extremely important aspect is accountability. What were the results of the last budgeting
process? How did these results get implemented? Leaving such questions unaswered may have a negative impact on the
number of citizens getting involved in the future. That is why Offering different levels of engagement such as voting
and suggesting an idea further helps citizens to gather an understanding of the nature of the process allows them to
decide how strongly they want to commit to it in the future.

OpenBudgets Participatory Budgeting aims to be a tool where citizens can express their budget allocation priorities
during the budget approval process and along the lines and within the process defined by each administration concerned,
but also a tool where citizens can monitor budget transactions, auditing budget compromised and giving feedback to
the administrations.

## Sample deployments

There are currently two different sample deployments: [openbudgets-voting-sample](http://openbudgets-voting-sample.herokuapp.com/)
and [openbudgets-monitoring-sample](http://openbudgets-monitoring-sample.herokuapp.com/).

Both have roughly the same sample data, but in the first case the participatory process is in the voting phase, where
citizens can browse the existing proposals and vote for them, and in the second case the participatory process is already
closed for voting and has transitioned into the monitoring phase.

![Voting screen shot](https://cloud.githubusercontent.com/assets/577074/19088006/8c982e66-8a74-11e6-9814-bc1ee861f011.png)

## Local installation

OpenBudgets Participatory Budgeting is a Rails 5.0 application.

### Development environment configuration

Prerequisites: Git, Ruby 2.5.1, Bundler gem, Node 8+ and PostgreSQL 9.4+

To prepare the environment:
```
$ bundle install
$ bin/rails db:create
$ bin/rails db:migrate
$ bin/rails db:seed
$ bin/rails db:test:prepare
```

To create d3.js custom bundle ([using npm & Rollup](https://bl.ocks.org/mbostock/bb09af4c39c79cffcde4)):
```
$ npm install
```

Run the tests with:
```
$ bin/rails t
```

There's also an included Guardfile to automate the test execution whenever file or directories
are modified.

Run Guard with:
```
$ bin/guard
```

Run the app with:
```
$ bin/rails s
```

To inspect the contents of the emails sent by the app in development environment, use the following URL:
```
http://localhost:3000/rails/mailers/
```
