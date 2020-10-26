# Stack Overflow Job Search Map

[![CircleCI](https://circleci.com/gh/tuckerrc/jobs_map.svg?style=svg)](https://circleci.com/gh/tuckerrc/jobs_map)
[![Coverage](https://tuckerrc.github.io/jobs_map/coverage_badge_total.svg)](https://tuckerrc.github.io/jobs_map/index.html)

This is a Ruby on Rails app for job searching.  Jobs are pulled from [Stack Overflow](http://stackoverflow.com/jobs) job search RSS feeds.  City coordinates are from the [geonames.org](http://www.geonames.org/) database. The mapping is done using the [Leaflet.js](http://leafletjs.com/) mapping library.

Currently the app is a work in progress but it is hosted on [Heroku](https://www.heroku.com/) at [http://stackjobsmap.herokuapp.com/stack_jobs/index](http://stackjobsmap.herokuapp.com/stack_jobs/index).


# New Locations

Any city not know by the app will show up near the Bermuda Triangle.  Add an issue for any cities that you see mapped near the Bermuda Triangle. (Make sure to give the lattitude and longitude for the city as well)


# TODO

- Advanced Search abilities
- Summary in Map popup
- Animations for search box
- Instructions for how to use the map
