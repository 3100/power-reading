$ ->
  $("#start-button").click ->
    sound = "/se/" + new RandomJson("/data/sound.json").get()
    MyTimer.get("#time", "#start-button", sound).start()
    $("#description").html new RandomJson('/data/quotes.json').get()

  class RandomJson
    constructor: (@path) ->

    load: ->
      unless @list?
        json = $.ajax(@path,
          type: "GET"
          dataType: "json"
          async: false
        ).responseText
        @list = $.parseJSON(json).data
      @list

    get: ->
      @load()
      # cf. http://www.shawnolson.net/a/789/make_javascript_mathrandom_useful.html
      index = Math.floor(Math.random() * (@list.length-1))
      @list[index]

  class AudioPlayer
    constructor: (path) ->
      @audio = new Audio path

    isEnable: ->
      @audio.canPlayType("audio/ogg") == 'maybe'

    play: ->
      if @isEnable() == true
        @audio.play()
        true
      else
        false

  class MyTimer
    REST_MINUTES = 15
    #A_MINUTE = 1000*60
    A_MINUTE = 1000 # for debug

    instance = null

    @get: (targetID, buttonID, soundPath) ->
      instance ?= new _myTimer(targetID, buttonID)
      instance.soundPath = soundPath
      instance

    class _myTimer
      constructor: (targetID, buttonID) ->
        @target = $(targetID)
        @button = $(buttonID)
        if @target.size == 0
          alert "Invalid target ID."
          return false

      start: ->
        @rest = REST_MINUTES
        clearInterval @timer if @timer?

        @button.html "Start"
        @player = new AudioPlayer(@soundPath)
        alert "Your environmet is unable to play a ogg file." unless @player.isEnable
        @updateHtml()
        callback = @timerOn.bind(this)
        @timer = setInterval callback, A_MINUTE

      timerOn: ->
        @rest -= 1
        @updateHtml()
        @timerOff() if @rest == 0

      timerOff: ->
        clearInterval @timer
        @finishHtml()
        @player.play()

      updateHtml: ->
        @target.html @rest + " min to go."

      finishHtml: ->
        @target.html "Finished."
        @button.html "Continue?"
