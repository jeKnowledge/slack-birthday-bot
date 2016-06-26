# Birthday Bot

The purpose of this bot is to post on your team's Slack channel on a colleague's birthday.

Every time you run the command `rake congratulate` the code will read some files, check who was born at that date, and send a push notification to a Slack channel. You need to create those configuration files, deploy this code to a server, and run that command based on a daily schedule. For that, I used Heroku and its Scheduler add-on.

## Ready

1. Run `bundle install` on you local machine to install dependencies and generate `Gemfile.lock`.
2. Get your [Incoming Webhook](https://api.slack.com/incoming-webhooks) URL from Slack.
3. While your at it, give your Slack Bot a name and an icon. That's easier to manage than a configuration file.

## Set

#### Configure your birthdays

1. Create/Open a file named `birthdays.txt`.
2. Write on each line using the following format: `FirstName LastName YY MM DD`
3. Make sure the file is located in the same folder as `notify.rb`.

This file will tell the bot who and when should be congratulated.

#### Configure your bot

1. Create/Open a file named `configurations.json`.
2. Fill in the values as you like.
3. Make sure the file is located in the same folder as `notify.rb`.

This file will tell the bot how it should behave.

## Go

#### Deploy (to Heroku)

- Do the initial setup at Heroku.
- Upload your code using `git push heroku master`.

#### Schedule (on Heroku Scheduler)

- Run `heroku addons:create scheduler:standard` to add the Scheduler add-on to your deploy.
- Run `heroku addons:open scheduler` to configure.
- Click **Add a new job** and type `rake congratulate` as the command.
- Set frequency to **Daily** and choose the best **Time** for your company.

--------------------------------------------------------------------------------

#### Acknowledgments

This code was originally created by [Tiago Botelho](https://github.com/tiagonbotelho), while he was an intern at [jeKnowledge](http://jeknowledge.pt/).

It was later revised by [Diogo Nunes](http://www.diogonunes.com/) for [EqualExperts](https://www.equalexperts.com/).
