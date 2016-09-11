angular.module('chapter').controller 'ChapterController', ['$scope', 'notifier', ($scope, notifier) ->
  $scope.job = {}
  $scope.$on 'exerciseCompleted', ->
    notifier.exerciseSuccess()
    $scope.job.result = 'success'
]
