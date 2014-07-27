Kursusbasen.CoursePlanningCategorySelectorComponent = Ember.Component.extend
  coursePlanning: null

  validCategories: Ember.computed.alias('coursePlanning.validCategories')
  coursePlanningCategory: Ember.computed.alias('coursePlanning.category')
  dashedCategoryName: (->
    return null if Ember.isEmpty(@get('coursePlanningCategory'))
    @get('coursePlanningCategory').replace('_', '-')
  ).property('coursePlanningCategory')

  classNameBindings: ['dashedCategoryName']
  classNames: ['course-planning-category-selector', 'btn-group']

  actions:
    setCoursePlanningCategory: (category) ->
      @get('coursePlanning').updateCategory(category)
