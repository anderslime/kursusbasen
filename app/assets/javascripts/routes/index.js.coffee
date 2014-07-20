Kursusbasen.IndexRoute = Ember.Route.extend
  model: ->
    @store.find('student', DTUStudentId)
