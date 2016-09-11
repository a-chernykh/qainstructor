angular.module('exercise').directive 'hint', ->
  transclude: true
  scope: true
  template: '<div ng-show="currentHint == number" class="well" ng-transclude></div>'
  restrict: 'E'
  link: (scope, element, attr) ->
    scope.number = $(element).index() + 1
