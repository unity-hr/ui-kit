jQuery ($) ->

  body        = $('body')
  bodyNoTouch = $('.no-touch body')
  html        = $('html')
  bh          = body.add(html)
  win         = $(window)
  overlay     = $('.overlay')
  main        = $('main')
  footer      = $('footer')
  toggleTop   = $('.toggle[data-to="top"]')

  scrollUpdate = ->
    currentPos = win.scrollTop()
    offset     = 20

    bodyNoTouch.css
      backgroundPosition: "50% #{(currentPos/body.height()) * 100}%"

    if (currentPos >= footer.offset().top - offset)
      toggleTop.addClass('is-visible')
    else
      toggleTop.removeClass('is-visible')

  resizeUpdate = ->
    if window.innerHeight >= 480
      overlay.height(window.innerHeight)
    else
      overlay.height('auto')

    body.height(overlay.height() + window.innerHeight - footer.outerHeight())

  scrollUpdate()
  resizeUpdate()

  $('.toggle').on 'click touchstart', (event) ->
    event.preventDefault()
    if $(@).data('to') is 'bottom'
      bh.animate({scrollTop: footer.offset().top}, 500)
    else
      bh.animate({scrollTop: 0}, 500)

  win.on('scroll', scrollUpdate)
  win.on('resize', resizeUpdate)
