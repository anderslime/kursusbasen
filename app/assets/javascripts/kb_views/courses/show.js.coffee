ns = namespace("views.courses.show")

ns.apply = ->
  $(".removed-course").tooltip()
  $("#add_to_study_plan_button").click (event) ->
    event.preventDefault()
    $.ajax
      method: 'POST'
      url: @href
      success: ->
        $(event.currentTarget).removeClass('btn-primary')
        $(event.currentTarget).addClass('btn-success')
