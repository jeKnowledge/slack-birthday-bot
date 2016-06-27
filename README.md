# Slack Birthday Bot

The purpose of this bot is to send a message to your team's Slack when is someones birthday.

## Setup & Deploy (Heroku)

1. Get your [Incoming Webhook URL](https://api.slack.com/incoming-webhooks) from Slack
2. Save the url at `configurations.json` file and fill in the rest of the configurations as you like
3. Set your birthdays list using the format `FirstName LastName YY MM DD` at the `birthdays.txt` file
4. Create a blank app at Heroku
5. Push your code to Heroku
6. Run `heroku addons:create scheduler:standard` to add the Scheduler add-on to your deploy
7. Run `heroku addons:open scheduler` to configure the scheduler
8. Click **Add a new job** and type `rake congratulate` as the command
9. Set frequency to **Daily** and choose the **Time** you want to be notified

## Contributors 

This project was originally created by [Tiago Botelho](https://github.com/tiagonbotelho), while he was an intern at [jeKnowledge](http://jeknowledge.pt/).

It was later revised by [Diogo Nunes](http://www.diogonunes.com/) from [EqualExperts](https://www.equalexperts.com/) and [João Bernardo](http://jbernardo.me) from [jeKnowledge](http://jeknowledge.pt/).
