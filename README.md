# Skyscraper Version 2

For version 1 please see: 

Demo Site: http://theskyscraper.herokuapp.com/ (~ 100k Jobs scraped)

Repo https://github.com/Haumer/skyscraper

### Version 2 
**Command Line Only** (see setup below)

# Setup:

## Clone repo
```git clone git@github.com:Haumer/skyscraper_v2.git```

## Install gems
```bundle```

## JS dependencies
```yarn```

## DB setup
```rails db:create db:migrate db:seed```

The seed has a default User with email: default@skyscraper.com and password: 123456 set as admin: true

# Running:

## Make sure to have redis and sidekiq running:
```sidekiq```

## Default available Rake Tasks:

**search for a job**

:point_right: search:general[KEYWORD]

example:
   ```
   noglob rake search:general['ruby']
   # OR
   rake search:general\['ruby'\]
   ```

=> lists all jobs from all websites for the KEYWORD 'ruby' that are being
   scraped

**check which websites yielded results**

:point_right: search:latest

example:
   ```
   rake search:latest
   ```

=> lists all websites and confirms that if the latest search successfully
   scraped jobs as intended

**check for errors**

:point_right: search:errors

example:
   ```
   rake search:errors
   ```

=> lists the 50 most recent errors


search:errors['WEBSITE', NUMBER]

example:
   ```
   noglob rake search:errors['cv-library']
   # OR
   rake search:errors\['cv-library'\]
   # OR
   rake search:errors\['cv-library', 10\]
   ```

=> lists the 'NUMBER' most recent errors for cv-library, NUMBER defaults to 50

