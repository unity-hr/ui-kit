jQuery ($) ->

  $html = $('html')

  $('.toggle').on 'click', (event) ->
    event.preventDefault()
    $html.toggleClass('is-revealed')
