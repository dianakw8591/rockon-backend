# RockOn backend API

RockOn is a digital logbook for tracking climbing ascents and attempts. The backend API uses Ruby on Rails with a Postgresql database. The frontend repo can be found [here](https://github.com/dianakw8591/rockon-client).

## Version

Ruby 2.7.1

## Installation

  To run locally, download or clone the repository, then run 'bundle install' to install required gems.
  ```
  bundle install
  ```
  To create the database, install Postgresql and run 'rails db:create'
  ```
  rails db:create
  ```
  Run migrations to create the tables:
  ```
  rails db:migrate
  ```
  RockOn's climb data is seeded using Mountain Project's API. To gather the route ids necessary for use in the API fetch, I used Nokogiri to scrape Mountain Project for area and route ids. The scraping script is located at `/app/jobs/get_mtnproject_ids.rb` and can be run using Rails runner:
  ```
  rails runner app/jobs/get_mtnproject_ids.rb
  ```
  To obtain an API key for Mountain Project, to to [mountainproject.com](https://www.mountainproject.com/) and create an account. Request an API key at their [data page](https://www.mountainproject.com/data). Once you have obtained a key, it will appear there.

  Set up your own configuration for storing and using your private key, then change line 129 in `/app/jobs/call_mtnproject_api.rb` to use your stored key.

  Seed the database using that script:
  ```
  rails runner app/jobs/call_mtnproject_api.rb
  ```
  Run 'rails s' to start a local server:
  ```
  rails s
  ```
  Navigate to your locally hosted client to start logging!

## Contributing

Contributions are welcome. Feel free to open a pull request or branch from this project.

## Data

Climb and area data: https://www.mountainproject.com/

## License

[MIT](https://choosealicense.com/licenses/mit/)


