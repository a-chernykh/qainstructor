$ ->
  $('a[href=#]').click (e) -> e.preventDefault()

  $('body.chapter-text').addClass('toc-visible')
  $('html').on 'click', 'body.toc-visible a.hide-link', (e) -> $('body').removeClass('toc-visible')
  $('.tos-menu-link a').click ->
    $('body').toggleClass('toc-visible')
    $('body nav li.active').prevAll('li.section')[0].scrollIntoView()

  if $('body nav li.active').size() > 0
    $('body nav li.active').prevAll('li.section')[0].scrollIntoView()
