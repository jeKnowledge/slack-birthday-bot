# Birthday Bot

The purpose of this bot is to post on your team's Slack channel on a colleague's birthday.

Everytime you run the command `ruby notify.rb` the code will read some files, check who was born at that date, and send a push notification to a Slack channel. You need to create those configuration files, deploy this code to a server, and run that command based on a daily schedule. For that I used Heroku & Heroku Scheduler.

## Ready

1. Run `bundle install` on you local machine to install dependencies and generate `Gemfile.lock`.
2. Get your [Incoming Webhook](https://api.slack.com/incoming-webhooks) URL from Slack.
3. While your at it, give your Slack Bot a name and an icon. That's easier to manage than a configuration file.

## Set

#### Configure your birthdays

1. Create a file named `birthdays.txt` (or rename the included `birthdays.txt.example`).
2. Write on each line using the following format: `FirstName LastName YY MM DD`
3. Make sure the file is located in the same folder as `notify.rb`.

This file will tell the bot who and when should be congratulated.

#### Configure your bot

1. Create a file named `configurations.json` (or rename the included `configurations.json.example`).
2. Fill in the values as you like.
3. Make sure the file is located in the same folder as `notify.rb`.

This file will tell the bot how it should behave.

## Go

#### Deploy (to Heroku)

- Do the initial setup at Heroku.
- Upload your code using `git push heroku master`.

#### Schedule (on Heroku Scheduler)

- Run `heroku addons:create scheduler:standard` to add the Scheduler addon to your deploy.
- Run `heroku addons:open scheduler` to configure.
- Click **Add a new job** and type `ruby notify.rb` as the command.
- Set frequency to daily and choose the best your time for your company.

--------------------------------------------------------------------------------

#### Acknowledgements

This code was originally created by [Tiago Botelho](https://github.com/tiagonbotelho), while he was an intern at [jeKnowledge](http://jeknowledge.pt/).
