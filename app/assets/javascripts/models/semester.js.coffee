Kursusbasen.Semester =
  autumnSemesterSeasons: ['autumn', 'january']
  springSemestersSeaons: ['spring', 'june', 'summer']

  isSpringSemester: (season) ->
    @springSemestersSeaons.contains(season)

  isAutumnSemester: (season) ->
    @autumnSemesterSeasons.contains(season)
