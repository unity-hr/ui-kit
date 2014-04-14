jQuery ($) ->
  body      = $('body')
  overlay   = $('.overlay')
  footer    = $('footer')

  body.height(body.height() * 2 - footer.outerHeight())

  $('.toggle').on 'click touchstart', (event) ->
    event.preventDefault()
    if $(@).data('to') is 'bottom'
      body.animate({scrollTop: body.height()}, 1000)
    else
      body.animate({scrollTop: 0}, 1000)

  $(window).on 'scroll', ->
    wWidth     = window.innerWidth
    wHeight    = window.innerHeight
    navHeight  = footer.outerHeight()
    offset     = wHeight - navHeight
    currentPos = body.scrollTop()

    body.css
      backgroundPosition: "50% #{(currentPos/body.height()) * 100}%"

    if (currentPos >= offset)
      overlay.css
        position: 'fixed'
        top: -offset
        bottom: offset
      $('.toggle[data-to="top"]').addClass('is-visible')
    else
      overlay.css
        position: 'absolute'
        top: 0
        bottom: 0
      $('.toggle[data-to="top"]').removeClass('is-visible')
