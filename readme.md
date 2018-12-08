# Volunteer

#### _Ruby Code Review 3_

#### By _Ben Kirby_

## Description
This web app is a volunteer management system for use by the volunteer coordinator. You can add volunteers, add/edit/delete projects, and manage project assignments.


## Setup/Installation Requirements
* After cloning the project, navigate to the root directory.
* Run the following shell commands to create a database
`createdb [DATABASE NAME]`                                      
`psql [DATABASE_NAME] < database_backup.sql`
` createdb -T [DATABASE NAME] [TEST DATABASE NAME] `
* Launch psql and connect to the non-test database
* In a new shell window (make sure you're still in the project's root folder) run `ruby app.rb`
* In a browser, navigate to http://localhost:4567
* Hosted on Heroku at https://arcane-ocean-30385.herokuapp.com/
## Known Bugs

* The "Give me the 411" button on the view volunteer page does not work.
* The delete function was working but broke at some point.

## Technologies Used

* Ruby
* SQL
* HTML
* CSS

### License

*Copyright (c) 2018 Ben Kirby*
*This software is licensed under the MIT license.*
