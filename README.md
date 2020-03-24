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

## Default available Tasks:

search:general[KEYWORD]

example:
1. noglob rake search:general['ruby']
2. rake search:general\\['ruby'\\]

=> lists all jobs from all websites for the KEYWORD 'ruby' that are being
   scraped


search:latest

example:
1. rake search:latest

=> lists all websites and confirms that if the latest search successfully
   scraped jobs as intended


search:errors

example:
1. rake search:errors

=> lists the 50 most recent errors


search:errors[WEBSITE, NUMBER]

example:
1. noglob rake search:errors['cv-library']
2. rake search:errors\\['cv-library'\\]

=> lists the 'NUMBER' most recent errors for cv-library, NUMBER defaults to 50

