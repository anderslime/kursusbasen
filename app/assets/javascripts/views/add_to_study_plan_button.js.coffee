Kursusbasen.AddToStudyPlanButton = Ember.View.extend
  templateName: 'views/add_to_study_plan_button'

  didInsertElement: ->
    $('.course-basket-add-to-study-plan').popover
      html: true
      placement: 'bottom'
