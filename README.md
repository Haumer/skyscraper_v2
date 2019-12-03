Tasks:

search:general[KEYWORD]

example:
1. noglob rake search:general['ruby']
2. rake search:general\['ruby'\]

=> lists all jobs from all websites that are being scraped


search:latest

example:
1. rake search:latest

=> lists all websites and confirms that if the latest search successfully
   scraped jobs as intended


search:errors

example:
1. rake search:errors

=> lists the 50 most recent errors


search:errors[WEBSITE]

example:
1. noglob rake search:errors['cv-library']
2. rake search:errors\['cv-library'\]

=> lists the 50 most recent errors for cv-library

