# Social Betting

We're going to create a web application that allows users to create a "group" or "league" bet tracker. Users will be able to manually enter bets between league members and track those bets.

## Iterations

### [v0.1] Allow Users to Register and Log In

* [X] As a user, I want to sign up for an account
* [X] As a user, I want to log in to my account

### [v0.2] Allow User to Create & Join a Group

* [X] As a user, I want to create league
* [X] As a user, I want to join an existing group

### [v0.3] Assign an Admin to a Group

* [ ] As a user, I want to be assigned an administrator of an account
* [X] Create show page for group, which shows a list of users


## Data Model

* User [ id, email, first_name, last_name, phone, password, admin, league_id ]
* League [ id, name, password, year ]
* Bets [ amount, user_two, expiration, user_id ]
