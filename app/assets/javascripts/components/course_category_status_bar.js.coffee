Kursusbasen.CourseCategoryStatusBarComponent = Ember.Component.extend
  category: null
  totalEctsPointsPlanned: 0.0
  ectsPointsNeeded: 0.0

  progress: (->
    @get('totalEctsPointsPlanned') / @get('ectsPointsNeeded') * 100.0
  ).property('totalEctsPointsPlanned', 'ectsPointsNeeded')

  dashedPlanningCategory: (->
    return null if Ember.isEmpty(@get('category'))
    @get('category').replace('_', '-')
  ).property('category')

  classNames: ['progress', 'course-category-status-bar']
  classNameBindings: ['dashedPlanningCategory']
