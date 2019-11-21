# Slack Birthday Bot

The purpose of this bot is to send a message to your team's Slack when is someones birthday.


## Setup

1. Clone this repo to a desired location on your own computer
2. Configure an [Incoming Webhook URL](https://api.slack.com/incoming-webhooks) from Slack
3. Choose your desired database structure file ( `<ext>` : YAML / JSON ).
   ( YAML is easier to configure as you have to bother about the indentation with spaces alone. You'll have to bother a lot more with JSON - Parentheses, commas. But in the end it's what you're more comfortable with that matters. )
   1. Make a copy of the `birthdays.<ext>.example` file naming it to `birthdays.<ext>`.
   2. Populate your birthdays database with the birthdays of your team members.
      * NB : You can either use their real names or their usernames. Just remember to configure the mention configuration correctly.
4. Make a copy of the `configurations.json.example` file naming it `configurations.json`. Update the configuration values according to your preferences
```
    {
       "birthdays_path"		: "birthdays.<ext>",			# according to your preference
									# birthdays.yaml for YAML and birthdays.json for JSON
       "mention"		: <true | false>,			# depends on your database configuration format
									# if you're using real names, set this value to false
									# if you're using usernames, set this value to true
       "slack_url"		: "https://hooks.slack.com/...",	# the webhook URL you configured in step 2.
       "channel_name"		: "<channel_name>",			# the channel you want your wishes to be sent to
       "greeting_message"	: "Happy birthday!"			# the wish you would like the bot to send
       "bot_name"		: "Birthday Bot"			# the name of the bot sending the wish
       "bot_emoji"		: ":tada:"				# the emoji the bot should use as it's icon
    }
```

## Deploy

### Heroku

1. Create a blank app at Heroku
2. Push your code to Heroku
3. The bot was developed with the **2.2.6** version of ruby, any other versions may require changes.
4. Run `heroku addons:create scheduler:standard` to add the Scheduler add-on to your deploy
5. Run `heroku addons:open scheduler` to configure the scheduler
6. Click **Add a new job** and type `rake congratulate` as the command
7. Set frequency to **Daily** and choose the **Time** you want to be notified

### Custom Server

1. Run `crontab -e` to edit your crontab
2. Add this line to the crontab and save it:
   `@daily cd /clone/location && /usr/local/bin/rake congratulate`
   * replace `/clone/location` with the location where you cloned the repo)
   * the `@daily` `cron` shorthand might vary among servers and/or distributions.
     Replace `@daily` with a time of your preference according to the [`cron` syntax](http://tldp.org/LDP/lame/LAME/linux-admin-made-easy/using-cron.html).
   * Remember to verify the timezone setting of your server or you won't get the expected result.


## Contributors 

This project was originally created by [Tiago Botelho](https://github.com/tiagonbotelho), while he was an intern at [jeKnowledge](http://jeknowledge.pt/).

It was later revised by [Diogo Nunes](http://www.diogonunes.com/) from [EqualExperts](https://www.equalexperts.com/), [João Bernardo](http://jbernardo.me) from [jeKnowledge](http://jeknowledge.pt/) and then refactored again by [Shine Nelson](https://www.shinenelson.com).

## License

This project is licensed under the terms of the MIT license.
