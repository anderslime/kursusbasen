Kursusbasen.CoursePlanningMoreActionsComponent = Ember.Component.extend
  coursePlanning: null

  classNames: ['btn-group']

  actions:
    deleteCoursePlanning: ->
      @get('coursePlanning').destroy()
