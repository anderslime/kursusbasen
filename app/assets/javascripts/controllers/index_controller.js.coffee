Kursusbasen.IndexController = Ember.Controller.extend
  plannedCourses: Ember.computed.alias('model.plannedCourses')
  studentNumber: Ember.computed.alias('model.studentNumber')
  actions:
    coolAlert: ->
      alert("coolio")

