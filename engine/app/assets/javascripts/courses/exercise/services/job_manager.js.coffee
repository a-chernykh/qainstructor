angular.module('exercise').factory 'jobManager', ['$rootScope', ($rootScope) ->
  startJob: -> $rootScope.$emit('verify')
  jobStarted: (job) -> $rootScope.$emit('jobStarted', job)
  jobFinished: (job) -> $rootScope.$emit('jobFinished', job)
  whenStartRequested: (listener) -> $rootScope.$on('verify', listener)
  whenJobStarted: (listener) -> $rootScope.$on('jobStarted', listener)
  whenJobFinished: (listener) -> $rootScope.$on('jobFinished', listener)
]
