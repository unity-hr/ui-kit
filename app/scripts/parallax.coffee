jQuery ($) ->

  body      = $('body')
  html      = $('html')
  bh        = body.add(html)
  $window   = $(window)
  overlay   = $('.overlay')
  footer    = $('footer')
  toggleTop = $('.toggle[data-to="top"]')

  body.height(body.height() * 2 - footer.outerHeight())

  $('.toggle').on 'click touchstart', (event) ->
    event.preventDefault()
    if $(@).data('to') is 'bottom'
      bh.animate({scrollTop: footer.offset().top}, 500)
    else
      bh.animate({scrollTop: 0}, 500)

  $window.on 'scroll', ->
    currentPos = $window.scrollTop()
    offset     = 20

    body.css
      backgroundPosition: "50% #{(currentPos/html.height()) * 100}%"

    if (currentPos >= footer.offset().top - offset)
      toggleTop.addClass('is-visible')
    else
      toggleTop.removeClass('is-visible')
