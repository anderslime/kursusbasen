Kursusbasen.SemesterSchedule = Ember.Object.extend
  coursePlannings: Ember.computed.alias('controller.coursePlannings')
  coursePlanningsForSemester: Ember.computed.filter('coursePlannings', (planning) ->
    planning.get('season') is @get('season') && planning.get('year') is @get('year')
  ).property('coursePlannings.@each.season', 'coursePlannings.@each.year')
  title: (->
    "#{@get('season')} #{@get('year')}"
  ).property('season', 'year')
