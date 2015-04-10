# Twitter Diversity Report

Version 1.0 04/09/2015

Welcome to our repository! This is an open-source project that originated as a group project for the  [Omaha Code School](http://www.omahacodeschool.com) Spring 2015 class.

---

Team:

- [Andrew Strovers](http://github.com/ADStrovers) [@MidwestBoardGam](http://twitter.com/midwestboardgam)
- [Alexandra Millatmal](http://github.com/halfghaninne) [@halfghaninNE](http://twitter.com/halfghaninne)
- [Crystal Cooling](http://github.com/coolingcza) [@cza_dev](http://twitter.com/cza_dev)
- [Hilary Stohs-Krause](http://github.com/hilarysk) [@hilarysk](http://twitter.com/hilarysk)

---

#To Get Started

##Cloning the Repository

##Prepare Your Local Environment

##Get an API Key

---

#Sitemap

---
# More About the Project (the User Story)
The web application allows a user to search for a Twitter account, and then provides the user with demographic insights of people/accounts that account follows. 

To accomplish this, the program has two main pieces of functionality:

1. **Self-identifying** -- A way for people to indicate their Twitter username and define their personal demographic information. They would self-identify.
2. **Reporting** -- A way for a person to visit the site and get a report of the demographics of the people they follow on Twitter.

## Self-identifying

The story goes like this:

1. I go to the website and click a link to add my personal demographic information.
2. I'm redirected to Twitter, where I need to log in.
3. Upon logging into Twitter, I'm sent back to the website. The website now knows what my Twitter username is -- and it knows that I am the owner of that username, because I logged in on Twitter.
4. I see a form with questions for things like sexual orientation, gender, race, place of residence, age, visual ability, etc. All of the questions are optional and free-form text entry.
5. I type my identity for some/all questions and submit the form.
6. The application records my answers and associates them with my Twitter username.

## Reporting

The story goes like this:

1. I go to the website and click a link to get a diversity report for some Twitter user.
2. I'm presented with a form, into which I type a Twitter username. Then I submit the form.
3. I'm presented with a message that says the report is being generated. In the meantime, would I please add my own demographic information?
  - If I decide to acquiesce, I go through a similar story as described above in _Self-identifying_. The major difference is that when I finish submitting my demographic information, I'm thanked and continue from the next step in _this_ story.
  - If I decide not to provide my own demographic information, I click a link to decline.
4. I'm presented with a report that is associated with the requested Twitter user. The data itself for the report has been stored in the database.
  - The report shows a basic pie chart for each demographic question.
  - The data draws from self-reported identity information. So the more people that do the _Self-identifying_ task described above, the better reports in general will be.
  - Running a report for the same user in the future will likely yield different data -- either because that user has since changed the people whom they follow, or because more of the user's followers have since added their demographic information.
