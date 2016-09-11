angular.module('runner').directive 'continueButton', ['jobRunner', '$log', 'jobManager', (jobRunner, $log, jobManager) ->
  restrict: 'E'
  link: (scope, element, attrs) ->
    scope.url = attrs.url
    $('a', element).click (e) ->
      if scope.needsCheck()
        e.preventDefault()
        scope.run() unless scope.running
        false
  scope: true
  template: "<a data-method='post' href='{{ url }}' ng-disabled='running' class='btn btn-primary'>{{ buttonText() }}</a>"
  controller: [ '$scope', '$http', ($scope, $http) ->
    $scope.needsCheck = ->
      $scope.files?.length > 0 && $scope.job.result != 'success'
    $scope.buttonText = ->
      if $scope.running
        'Verifying...'
      else
        if $scope.needsCheck()
          'Verify'
        else
          'Continue'

    jobManager.whenJobStarted -> $scope.running = true
    jobManager.whenJobFinished (job) -> $scope.running = false
    $scope.run = -> jobManager.startJob()
  ]
]
