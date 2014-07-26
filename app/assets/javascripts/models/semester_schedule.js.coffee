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
  scheduledCoursePlannings: Ember.computed.filterBy('coursePlannings', 'isScheduled')
  coursePlanningsForScheduleYear: Ember.computed.filter('coursePlannings', (planning) ->
    planning.get('year') is @get('year')
  ).property('coursePlannings.@each.year')
  coursePlanningsOffSchedule: Ember.computed.filter('scheduledCoursePlannings', (planning) ->
    planning.get('hasScheduleOffNormalSchedule') && planning.get('year') is @get('year')
  ).property('scheduledCoursePlannings.@each.year', 'scheduledCoursePlannings.@each.hasScheduleOffNormalSchedule', 'year')
  hasAnyOffSchedulePlannings: Ember.computed.any('coursePlanningsOffSchedule')
  title: (->
    "#{@get('season')} #{@get('year')}"
  ).property('season', 'year')
