Kursusbasen.CourseCategoryPlanningStatusComponent = Ember.Component.extend
  category: null
  scheduledCoursePlannings: []
  ectsPointsNeededInCategory: 30.0

  scheduledCoursePlanningsForCategory: Ember.computed.filter('scheduledCoursePlannings', (planning) ->
    planning.get('category') is @get('category')
  ).property('category', 'scheduledCoursePlannings.@each.category')
  ectsPointsPlannedForCategory: Ember.computed.mapBy(
    'scheduledCoursePlanningsForCategory', 'course.ectsPoints'
  )
  totalEctsPointsPlannedForCategory: Ember.computed.sum('ectsPointsPlannedForCategory')
