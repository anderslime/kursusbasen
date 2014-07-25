class Kursusbasen.Semester
  @allSeasons: ['autumn', 'january', 'spring', 'june', 'summer', 'unknown']
  @autumnSemesterSeasons: ->
    @allSeasons.slice(0, 2)
  @springSemestersSeaons: =>
    @allSeasons.slice(2, 4)

  @isSpringSemester: (season) ->
    @springSemestersSeaons().contains(season)

  @isAutumnSemester: (season) ->
    @autumnSemesterSeasons().contains(season)

  @isFirstSeasonOf: (seasons, season) ->
    @sortSeasonsChronologically(seasons)[0] is season

  @isSummer: (season) ->
    season is 'summer'

  @isOffSchedule: (season) ->
    season is 'unknown'

  @isOffNormalSchedule: (season) ->
    season is 'summer' || season is 'unknown'

  @sortSeasonsChronologically: (seasons) ->
    seasons.sort (season) =>
      Math.abs(@allSeasons.indexOf(season) - @allSeasons.length)
