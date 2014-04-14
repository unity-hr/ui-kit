jQuery ($) ->

  body        = $('body')
  bodyNoTouch = $('.no-touch body')
  html        = $('html')
  bh          = body.add(html)
  win         = $(window)
  overlay     = $('.overlay')
  footer      = $('footer')
  toggleTop   = $('.toggle[data-to="top"]')

  if window.innerHeight >= 480
    overlay.height(window.innerHeight)
    body.height(body.height() * 2 - footer.outerHeight())
  else
    body.height(overlay.height() * 2 - footer.outerHeight())

  $('.toggle').on 'click touchstart', (event) ->
    event.preventDefault()
    if $(@).data('to') is 'bottom'
      bh.animate({scrollTop: footer.offset().top}, 500)
    else
      bh.animate({scrollTop: 0}, 500)

  win.on 'scroll', ->
    currentPos = win.scrollTop()
    offset     = 20

    bodyNoTouch.css
      backgroundPosition: "50% #{(currentPos/html.height()) * 100}%"

    if (currentPos >= footer.offset().top - offset)
      toggleTop.addClass('is-visible')
    else
      toggleTop.removeClass('is-visible')
