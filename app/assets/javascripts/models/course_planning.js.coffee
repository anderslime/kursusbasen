Kursusbasen.CoursePlanning = DS.Model.extend
  student: DS.belongsTo 'student', async: true
  course: DS.belongsTo 'course', async: true
  scheduleGroup: DS.belongsTo 'scheduleGroup', async: true
  year: DS.attr 'string'

  schedules: Ember.computed.alias('scheduleGroup.schedules')
  hasScheduleOffNormalSchedule: (->
    return false if Ember.isEmpty(@get('schedules'))
    @get('schedules').any (schedule) ->
      schedule.get('isOffNormalSchedule')
  ).property('schedules.@each.isOffNormalSchedule')

  isScheduled: (->
    !Ember.isEmpty(@get('year')) && !Ember.isEmpty(@get('scheduleGroup'))
  ).property('year', 'scheduleGroup')

  isScheduledFor: (season, block = null) ->
    @get('schedules').any (schedule) ->
      schedule.get('season') is season && (Ember.isEmpty(block) || schedule.get('block') is block)

  scheduleFor: (scheduleGroup, year) ->
    @set('scheduleGroup', scheduleGroup)
    @set('year', year)
    @save()

  unschedule: ->
    @scheduleFor(null, null)
