Kursusbasen.AddToStudyPlanComponent = Ember.Component.extend
  coursePlanning: null
  upcomingSemesters: []
  scheduleGroups: Ember.computed.alias('coursePlanning.course.scheduleGroups')
  scheduleGroupSemesters: (->
    return [] if Ember.isEmpty(@get('scheduleGroups'))
    groupSemesters = []
    @get('upcomingSemesters').forEach (semester) =>
      @get('scheduleGroups').forEach (scheduleGroup) ->
        if scheduleGroup.get('schedules').mapBy('season').contains(semester.season)
          groupSemesters.push(
            scheduleGroup: scheduleGroup,
            semesterYear: semester.year
          )
    groupSemesters
  ).property('scheduleGroups.@each', 'upcomingSemesters.@each')
  actions:
    setPlannedCourseSemester: (coursePlanning, scheduleGroup, year) ->
      coursePlanning.scheduleFor(scheduleGroup, year)
