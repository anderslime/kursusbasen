class Kursusbasen.Semester
  @allSeasons: ['autumn', 'january', 'spring', 'june', 'summer', 'unknown']
  @autumnSemesterSeasons: ->
    @allSeasons.slice(0, 2)
  @springSemestersSeaons: =>
    @allSeasons.slice(2, 5)

  @isSpringSemester: (season) ->
    @springSemestersSeaons().contains(season)

  @isAutumnSemester: (season) ->
    @autumnSemesterSeasons().contains(season)

  @isFirstSeasonOf: (seasons, season) ->
    @sortSeasonsChronologically(seasons)[0] is season

  @sortSeasonsChronologically: (seasons) ->
    seasons.sort (season) =>
      Math.abs(@allSeasons.indexOf(season) - @allSeasons.length)
