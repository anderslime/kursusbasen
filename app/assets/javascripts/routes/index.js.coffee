Kursusbasen.IndexRoute = Ember.Route.extend
  model: ->
    this.store.find('student', DTUStudentNumber)
