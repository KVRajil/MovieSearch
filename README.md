# README

A Movie Search application Using Sinatra & VueJS


Features
1. Search Movies
2. Cache the Search result


Ruby version - 3.2.2

Sinatra version - 3.0.6


Installation & Setup:
    
    Backend
    Clone the project & cd to Backend.
    Copy .env.example to .env and replace env sample values with the actual values
    Db setup - RACK_ENV=development rake db:create & rake db:migrate
    Start the Sinatra app using rackup -p 3000 .
    Run the RSpec tests with rspec spec/ (RACK_ENV=test rake db:create & rake db:migrate).

    Frontend
    Clone the project & cd to Frontend.
    npm install -g @vue/cli
    npm run serve
    Open - http://localhost:8080/

App Workflow:

    Input the movie name in the search input box and click on the search button to fetch and render the results.
    The "Next Page" button will be visible if there are more than 20 results.
    Clicking the "Next Page" button will append the additional results to the existing movie list.
    If you click on the search button again, it will reset the page to page 1, and this action will also remove any previously appended results from the previous page.



Rake Tasks:

    RACK_ENV=development rake db:create
    RACK_ENV=development rake db:migrate
    rake console


CURL Requests

1. Movie Search
   ```bash
   curl --location 'localhost:3000/movies?query=inception&include_adult=false&page=1'


App UI Screenshots

<img width="1728" alt="Screenshot 2023-09-07 at 8 29 48 PM" src="https://github.com/KVRajil/MovieSearch/assets/8760691/fb2075e3-0c35-4b53-9804-7234ff32071e">
<img width="1727" alt="Screenshot 2023-09-07 at 8 29 59 PM" src="https://github.com/KVRajil/MovieSearch/assets/8760691/2d904150-98cd-4e30-94f6-9d0211077862">


