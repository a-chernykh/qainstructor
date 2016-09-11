angular.module('exercise').directive 'fileEditor', ->
  restrict: 'E'
  transclude: true
  template: '<div class="editor" ng-transclude></div>'
  replace: true
  scope:
    file: '='
  link: (scope, element, attrs) ->
    editor = ace.edit($(element)[0])
    editor.$blockScrolling = Infinity
    editor.setTheme("ace/theme/solarized_light")
    editor.setShowPrintMargin(false)
    editor.setReadOnly scope.file.readOnly
    editor.setHighlightActiveLine(false)
    editor.setValue(scope.file.content)
    editor.clearSelection()

    session = editor.getSession()
    session.setMode("ace/mode/#{scope.file.language}")
    session.setTabSize(2)
    session.setUseSoftTabs(true)

    scope.file.editor = editor
