Kursusbasen.SemesterSchedule = Ember.Object.extend
  year: null
  season: null

  coursePlannings: Ember.computed.alias('controller.coursePlannings')
  coursePlanningsForScheduleYear: Ember.computed.filter('coursePlannings', (planning) ->
    planning.get('year') is @get('year')
  ).property('coursePlannings.@each.year')
  title: (->
    "#{@get('season')} #{@get('year')}"
  ).property('season', 'year')
