#Birthday Bot Docs
This Bot was made so that you could have Something to warn you in Slack when it was someone's birthday.

## Starting up

First of all, you will have to make a .txt file that has the following format:

``` First_Name Last_Name yy mm dd ```

Next you will need to run ```bundle install``` to install the respective dependencies.

After that you will need to know your [Incoming Webhooks](https://api.slack.com/incoming-webhooks) URL. Note that if you don't have the integration in your Slack Team you will need to do it!

Next you will be asked the following questions:

```
$ ruby init.rb
Welcome to BirthdayBot
Please enter your Slack URL: (Incoming WebHooks URL here)
Please enter your text file with the birth dates and names: (e.g. birthdays.txt)
PLease enter the channel you want the bot to post to: (e.g. #general)
Please enter the name of the bot: (e.g. BirthdayPoster)

```

Answer the questions correctly and there you go! The bot is now running for your Slack!

##What was used

To develop this bot we has to couldn't run it day and night with a ```while(true)``` so we used [rufus-scheduler](https://github.com/jmettraux/rufus-scheduler) to only awake the bot once a day!

To communicate with the Slack API we used [HTTParty](https://github.com/jnunemaker/httparty) wich is a simple and easy way to communicate given a payload and sends it in json format.

## Deploy

- install tool belt (https://toolbelt.heroku.com/osx)
- https://blog.heroku.com/archives/2016/3/9/how-to-deploy-your-slack-bots-to-heroku
-
