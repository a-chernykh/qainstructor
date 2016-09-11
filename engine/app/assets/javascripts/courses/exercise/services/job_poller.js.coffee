angular.module('exercise').factory 'jobPoller', ['$interval', '$q', '$http', 'faye', '$log', ($interval, $q, $http, faye, $log) ->
  (token) ->
    deferred = $q.defer()

    faye.subscribe "/jobs/#{token}", (message) ->
      $log.debug message
      loadJob()

    loaded = (response) ->
      job = response.data.job
      status = job.status
      result = job.result
      if status == 'finished'
        $interval.cancel poll
        deferred.resolve job

    failed = ->
      $interval.cancel poll
      deferred.reject 'Error loading job'

    loadJob = ->
      $http.get(Routes.api_v1_job_path(token: token)).then(loaded, failed)

    poll = $interval loadJob, 10000

    deferred.promise
]
