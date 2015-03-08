# Social Betting

We're going to create a web application that allows users to create a "group" or "league" bet tracker. Users will be able to manually enter bets between league members and track those bets.

## Iterations

### [v0.1] Allow Users to Register and Log In

* [ ] As a user, I want to sign up for an account
* [ ] As a user, I want to log in to my account
* [ ] As a user, I want to create league

## Data Model

* User [ id, email, first_name, last_name, phone, password, admin ]
* League [ id, name, password, year ]
* Bets [ amount, user_one, user_two, expiration ]
