Kursusbasen.SemesterSchedule = Ember.Object.extend
  year: null
  season: null

  threeWeekSeason: (->
    return null if Ember.isEmpty(@get('season'))
    {
      'autumn': 'january',
      'spring': 'june'
    }[@get('season')]
  ).property('season')
  coursePlannings: Ember.computed.alias('controller.coursePlannings')
  coursePlanningsForScheduleYear: Ember.computed.filter('coursePlannings', (planning) ->
    planning.get('year') is @get('year')
  ).property('coursePlannings.@each.year')
  title: (->
    "#{@get('season')} #{@get('year')}"
  ).property('season', 'year')
