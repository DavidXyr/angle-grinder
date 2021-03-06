docs = angular.module("angleGrinder.docs", [])

docs.directive "prettyprint", ->
  restrict: "C"
  terminal: true
  compile: (element) ->
    extractLang = ->
      classes = element[0].className

      lang = "coffee"
      if classes.indexOf("lang-") isnt -1
        for className in classes.split(" ")
          if className.indexOf("lang-") isnt -1
            lang = className.split("-")[1]
            break

      return lang

    lang = extractLang()
    code = element.html()

    element.html window.prettyPrintOne(code, lang, true)

docs.factory "scrollTo", ["$routeParams", "$timeout", ($routeParams, $timeout) ->
  (id) ->
    scroll = ->
      element = document.getElementById(id)
      element.scrollIntoView() if element?
    $timeout(scroll, 10)
]
