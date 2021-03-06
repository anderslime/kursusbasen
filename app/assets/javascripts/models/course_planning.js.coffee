Kursusbasen.MASTER_CATEGORIES = [
  'advanced_elective', 'thesis',
  'general_competence', 'technological_specialization'
]
Kursusbasen.BACHELOR_CATEGORIES = [
  'basic_elective', 'project_and_general',
  'natural_science', 'technological_programme_course'
]

Kursusbasen.CoursePlanning = DS.Model.extend
  student: DS.belongsTo 'student'
  course: DS.belongsTo 'course', polymorphic: true
  scheduleGroup: DS.belongsTo 'scheduleGroup'
  year: DS.attr 'string'
  semesterSeasonStart: DS.attr 'string'
  category: DS.attr 'string'
  programme: DS.attr 'string'

  schedules: Ember.computed.alias('scheduleGroup.schedules')
  hasScheduleOffNormalSchedule: (->
    @get('schedules').any (schedule) -> schedule.get('isOffNormalSchedule')
  ).property('schedules.@each.isOffNormalSchedule')

  validCategories: (->
    {
      master: Kursusbasen.MASTER_CATEGORIES,
      bachelor: Kursusbasen.BACHELOR_CATEGORIES
    }[@get('programme')]
  ).property('programme')

  isScheduled: (->
    !Ember.isEmpty(@get('year')) &&
      !Ember.isEmpty(@get('scheduleGroup')) &&
      !Ember.isEmpty(@get('semesterSeasonStart'))
  ).property('year', 'scheduleGroup')

  isScheduledFor: (season, block = null) ->
    @get('schedules').any (schedule) ->
      schedule.get('season') is season && (Ember.isEmpty(block) || schedule.get('block') is block)

  destroy: ->
    @deleteRecord()
    @save()

  updateCategory: (category) ->
    @set('category', category)
    @save()

  scheduleFor: (scheduleGroup, year, semesterSeason) ->
    @set('scheduleGroup', scheduleGroup)
    @set('semesterSeasonStart', semesterSeason)
    @set('year', year)
    @save()

  unschedule: ->
    @scheduleFor(null, null, null)
