$ ->
  $("#start-button").click ->
    new MyTimer("#time").start()
    $("#description").html new RandomQuote().get() 

  class RandomQuote
    constructor: ->

    load: ->
      unless @list?
        json = $.ajax('/quotes.json',
          type: "GET"
          url: "quotes.json"
          dataType: "json"
          async: false
        ).responseText
        @list = $.parseJSON(json).quote
      @list

    get: ->
      @load()
      index = Math.ceil Math.random(@list.size-1)+0.5
      @list[index]

  class AudioPlayer
    constructor: (path) ->
      @audio = new Audio path

    isEnable: ->
      @audio.canPlayType("audio/mp3") == 'maybe'

    play: ->
      if isEnable() == true
        @audio.play()
        true
      else
        false

  class MyTimer
    REST_MINUTES = 15
    A_MINUTE = 1000*60

    constructor: (targetID) ->
      @rest = REST_MINUTES 
      @target = $(targetID)
      if @target.size == 0
        alert "Invalid target ID."
        return false
      @player = new AudioPlayer "/se/densi01.mp3"
      alert "Your environmet is unable to play a mp3 file." unless @player.isEnable

    start: ->
      @updateHtml()
      callback = @timerOn.bind(this)
      @timer = setInterval callback, A_MINUTE

    timerOn: ->
      @rest -= 1
      @timerOff() if @rest == 0
      @updateHtml()

    timerOff: ->
      clearInterval @timer
      @player.play()

    updateHtml: ->
      @target.html @rest + " min to go."
