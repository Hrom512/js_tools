(($) ->

  class AjaxPopup
    defaults:
      style: "center"
      width: "200px"
      height: "200px"

      animation_popup: "opacity"
      animation_overlay: "opacity"
      animation_duration: 400
      animation_easing: "linear"

      disable_page_scroll: true
      hide_on_click_overlay: true
      use_ajax_loader: true

    constructor: (options = {}) ->
      @config = $.extend({}, @defaults, options)
      return false unless @config.name && @config.url

      if !options.animation_popup && @config.style in ["left", "right", "top", "bottom"]
        @config.animation_popup = @config.style

      @config.use_ajax_loader = false unless $.ajax_loader
      @ajax_loader = $.ajax_loader if @config.use_ajax_loader

      @_build_html()
      @_set_callbacks()

      this

    _build_html: ->
      @$overlay = $("<div />", { id: "#{@config.name}-ajax-popup-overlay", class: "ajax-popup-overlay" })
      @$popup = $("<div />", { id: "#{@config.name}-ajax-popup", class: "ajax-popup #{@config.style}" })

      if @config.width && !(@config.style in ["top", "bottom"])
        @$popup.css({ width: @config.width })

      if @config.height && !(@config.style in ["left", "right"])
        @$popup.css({ height: @config.height })

      if @config.style == "center" && @config.width && @config.height
        @$popup.css({ "margin-left": @_calc_center_margin(@config.width) })
        @$popup.css({ "margin-top": @_calc_center_margin(@config.height) })

      $("body").append(@$overlay, @$popup)

    _calc_center_margin: (size) ->
      reg = /(\d+)(px|%|em)/ig
      res = reg.exec(size)
      num = parseInt(res[1], 10)
      "-#{num / 2}#{res[2] || 'px'}"

    _set_callbacks: ->
      if @config.hide_on_click_overlay
        @$overlay.click => @hide()

    _get_scrollbar_width: (elem = "body") ->
      unless @scrollbar_width
        without_scrollbar = $(elem).css({ overflow: "hidden" }).width()
        with_scrollbar = $(elem).css({ overflow: "auto" }).width()
        @scrollbar_width = without_scrollbar - with_scrollbar
      @scrollbar_width

    _hide_scroll: (elem = "body") ->
      if @config.disable_page_scroll
        $(elem).css({ overflow: "hidden", "padding-right": @_get_scrollbar_width(elem) })

    _show_scroll: (elem = "body") ->
      if @config.disable_page_scroll
        $(elem).css({ overflow: "auto", "padding-right": 0 })

    _show_element: (elem, animation) ->
      if animation
        elem.css(animation[0])

      elem.show()
      @_hide_scroll()

      if animation
        elem.animate(animation[1], @config.animation_duration, @config.animation_easing)

    _hide_element: (elem, animation) ->
      if animation
        elem.css(animation[1])

      callback = =>
        elem.hide()
        @_show_scroll()

      if animation
        elem.animate(animation[0], @config.animation_duration, @config.animation_easing, callback)
      else
        callback()

    _toggle_popup: ->
      animations = {
        opacity: [ { opacity: 0 }, { opacity: 1 } ],
        left: [ { left: "-#{@config.width}" }, { left: 0 } ],
        right: [ { right: "-#{@config.width}" }, { right: 0 } ],
        top: [{ top: "-#{@config.height}" }, { top: 0 } ],
        bottom: [{ bottom: "-#{@config.height}" }, { bottom: 0 } ]
      }
      animation_popup = animations[@config.animation_popup] || @config.animation_popup
      animation_overlay = animations[@config.animation_overlay] || @config.animation_overlay

      if @$overlay.is(":visible")
        @_hide_element(@$popup, animation_popup)
        @_hide_element(@$overlay, animation_overlay)
      else
        @_show_element(@$popup, animation_popup)
        @_show_element(@$overlay, animation_overlay)

    _before_open: ->
      $(".close", @$popup).click =>
        @hide()
        false
      @config.before_open() if @config.before_open?

    show: ->
      unless @$overlay.is(":visible")
        @ajax_loader.show() if @config.use_ajax_loader
        $.ajax
          url: @config.url
          success: (data) =>
            @$popup.html(data)
            @_before_open()
            @_toggle_popup()
          complete: =>
            @ajax_loader.hide() if @config.use_ajax_loader

    hide: ->
      if @$overlay.is(":visible")
        @_toggle_popup()


  $.ajax_popup = (options) ->
    new AjaxPopup(options)

) jQuery
