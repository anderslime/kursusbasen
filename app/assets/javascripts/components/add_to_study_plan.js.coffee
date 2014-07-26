Kursusbasen.AddToStudyPlanComponent = Ember.Component.extend
  coursePlanning: null
  upcomingSemesters: []
  scheduleGroups: Ember.computed.alias('coursePlanning.course.scheduleGroups')
  scheduleGroupSemesters: (->
    return [] if Ember.isEmpty(@get('scheduleGroups'))
    groupSemesters = []
    @get('upcomingSemesters').forEach (semester) =>
      @get('scheduleGroups').forEach (scheduleGroup) ->
        if scheduleGroup.beginsInSeason(semester.get('season'))
          groupSemesters.push(
            scheduleGroup: scheduleGroup,
            semesterYear: semester.year,
            semesterSeason: semester.season
          )

        if scheduleGroup.beginsInSeason(semester.get('threeWeekSeason'))
          groupSemesters.push(
            scheduleGroup: scheduleGroup,
            semesterYear: semester.year,
            semesterSeason: semester.season
          )

        if scheduleGroup.get('hasSummerSchool') && Kursusbasen.Semester.isSpringSemester(semester.season)
          groupSemesters.push(
            scheduleGroup: scheduleGroup,
            semesterYear: semester.year,
            semesterSeason: semester.season
          )

        if scheduleGroup.get('hasOffScheduleSeason')
          groupSemesters.push(
            scheduleGroup: scheduleGroup,
            semesterYear: semester.year,
            semesterSeason: semester.season
          )

    groupSemesters
  ).property('scheduleGroups.@each', 'upcomingSemesters.@each')
  actions:
    setPlannedCourseSemester: (coursePlanning, scheduleGroup, year, semesterSeason) ->
      coursePlanning.scheduleFor(scheduleGroup, year, semesterSeason)
