Kursusbasen.ScheduleGroup = DS.Model.extend
  schedules: DS.hasMany 'schedule'
  scheduleSeasons: Ember.computed.mapBy('schedules', 'season')
  hasScheduleSeasonInAutumnSemester: (->
    @get('scheduleSeasons').any (season) ->
      Kursusbasen.Semester.isAutumnSemester(season)
  ).property('scheduleSeasons.@each')
  hasScheduleSeasonInSpringSemester: (->
    @get('scheduleSeasons').any (season) ->
      Kursusbasen.Semester.isSpringSemester(season)
  ).property('scheduleSeasons.@each')
  isCrossSemester: (->
    @get('hasScheduleSeasonInAutumnSemester') && @get('hasScheduleSeasonInSpringSemester')
  ).property('schedules.@each')

  beginsInSeason: (season) ->
    Kursusbasen.Semester.isFirstSeasonOf(@get('scheduleSeasons'), season)
