Kursusbasen.CoursePlanning = DS.Model.extend
  student: DS.belongsTo 'student'
  course: DS.belongsTo 'course'
  scheduleGroup: DS.belongsTo 'scheduleGroup'
  year: DS.attr 'string'
  semesterSeasonStart: DS.attr 'string'

  schedules: Ember.computed.alias('scheduleGroup.schedules')
  hasScheduleOffNormalSchedule: (->
    @get('schedules').any (schedule) -> schedule.get('isOffNormalSchedule')
  ).property('schedules.@each.isOffNormalSchedule')

  isScheduled: (->
    !Ember.isEmpty(@get('year')) &&
      !Ember.isEmpty(@get('scheduleGroup')) &&
      !Ember.isEmpty(@get('semesterSeasonStart'))
  ).property('year', 'scheduleGroup')

  isScheduledFor: (season, block = null) ->
    @get('schedules').any (schedule) ->
      schedule.get('season') is season && (Ember.isEmpty(block) || schedule.get('block') is block)

  scheduleFor: (scheduleGroup, year, semesterSeason) ->
    @set('scheduleGroup', scheduleGroup)
    @set('semesterSeasonStart', semesterSeason)
    @set('year', year)
    @save()

  unschedule: ->
    @scheduleFor(null, null, null)
