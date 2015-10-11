(($) ->

  class AjaxLoader
    defaults:
      name: "default"
      container: "body"

    constructor: (options = {}) ->
      @config = $.extend({}, @defaults, options)
      @_build_loader()
      this

    _build_loader: ->
      @$loader = $("<div />", { class: "ajax-loader", id: "ajax-loader-#{@config.name}" })
      @$loader.appendTo(@config.container)
      if @config.container != "body"
        @$loader.css(position: "absolute")

    show: ->
      @$loader.show()

    hide: ->
      @$loader.hide()


  $.create_ajax_loader = (options) ->
    new AjaxLoader(options)

  $ ->
    $.ajax_loader = $.create_ajax_loader()

) jQuery
