Kursusbasen.CoursePlanningCategorySelectorComponent = Ember.Component.extend
  coursePlanning: null

  coursePlanningValidCategories: Ember.computed.alias('coursePlanning.validCategories')
  validCategories: (->
    return [] if Ember.isEmpty(@get('coursePlanningValidCategories'))
    @get('coursePlanningValidCategories').concat('no_category')
  ).property('coursePlanningValidCategories.@each')
  coursePlanningCategory: Ember.computed.alias('coursePlanning.category')
  dashedCategoryName: (->
    return null if Ember.isEmpty(@get('coursePlanningCategory'))
    @get('coursePlanningCategory').replace('_', '-')
  ).property('coursePlanningCategory')

  classNameBindings: ['dashedCategoryName']
  classNames: ['course-planning-category-selector', 'btn-group']

  actions:
    setCoursePlanningCategory: (category) ->
      plannedCategory = if category isnt 'no_category' then category else null
      @get('coursePlanning').updateCategory(plannedCategory)
