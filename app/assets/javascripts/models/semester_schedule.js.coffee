Kursusbasen.SemesterSchedule = Ember.Object.extend
  year: null
  season: null
  ectsPointsNeeded: 30

  threeWeekSeason: (->
    return null if Ember.isEmpty(@get('season'))
    {
      'autumn': 'january',
      'spring': 'june'
    }[@get('season')]
  ).property('season')
  ectsPointsPlanned: Ember.computed.sum('ectsPointsForSemester')
  ectsPointsForSemester: Ember.computed.mapBy('coursePlanningsForSemester', 'course.ectsPoints')
  coursePlannings: Ember.computed.alias('controller.coursePlannings')
  scheduledCoursePlannings: Ember.computed.filterBy('coursePlannings', 'isScheduled')
  coursePlanningsForSemester: Ember.computed.filter('coursePlannings', (planning) ->
    planning.get('year') is @get('year') && planning.get('semesterSeasonStart') is @get('season')
  ).property('coursePlannings.@each.{season,year}', 'year', 'season')
  coursePlanningsOffSchedule: Ember.computed.filterBy('coursePlanningsForSemester', 'hasScheduleOffNormalSchedule')
  hasAnyOffSchedulePlannings: Ember.computed.any('coursePlanningsOffSchedule')
  title: (->
    "#{@get('season')} #{@get('year')}"
  ).property('season', 'year')
