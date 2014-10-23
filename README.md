# TennisBook

## Initial setup

Clone project repository

    git clone <REPO URL>

Change directory to project

    cd /path/to/tennis_book/

Install dependencies & setup database

    ./script/newb

## Running the tests

    bundle exec rake

## Running the app

    bundle exec rails server

Note that you'll have to register with a beta tester's name (e.g. Lexi Bari).

## Running the job queue

    script/delayed_job start

Then stop it with

    script/delayed_job stop

## Running the console

    bundle exec rails console

## Deploying the app to Heroku

    git push heroku master
