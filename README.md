# Twitter Diversity Report

Team:

- [Andrew Strovers](http://github.com/ADStrovers)
- [Alexandra Millatmal](http://github.com/halfghaninne)
- [Crystal Cooling](http://github.com/coolingcza)
- [Hilary Stohs-Krause](http://github.com/hilarysk)

---

The goal of this application is to give people demographic insights about the people they follow on Twitter.

This application has two top-level components:

- **Self-identifying** -- A way for people to indicate their Twitter username and define their personal demographic information. They would self-identify.
- **Reporting** -- A way for a person to visit the site and get a report of the demographics of the people they follow on Twitter.

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
  
---
  
# Development Plan

There are a few milestones here:

1. Twitter authentication
2. CRUD for personal demographic information
3. Report generation
4. Sitemap
5. Controllers/routes/views
6. Front-end design
7. Data visualizations

## Twitter authentication

It might help to build a sandbox application to test how third-party authentication works and then build this functionality into this application.

## CRUD for personal demographic information

After authenticating with Twitter, a user should be able to add/edit their demographic information.

## Report generation

What kind of data needs to be collected? How will it be stored? How will it be read efficiently?

There is also an opportunity to use delayed jobs here, because generating the report will probably take a bit of time.

## Sitemap

Define every page, from the end-user's perspective. Answer these questions for each page:

1. What is the page's primary responsibility?
2. Excluding global navigation links, where can a user go directly from this page?
3. In what way is this page restricted (if at all)?

The end result of this might look like index cards taped to a whiteboard.

## Controllers/routes/views

Organize the various pages from the sitemap into controllers and build out basic, unstyled views.

## Front-end design

We'll use a CSS framework, like Bootstrap or Foundation (or a new one, like the one GitHub just launched!), to streamline some of our work. Additional CSS will be implemented using some kind of object-oriented CSS approach.

## Data visualizations

The reports should use some JS library to implement good-looking charts.