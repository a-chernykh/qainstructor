angular.module('exercise').factory 'jobRunner', ['$http', '$log', 'jobPoller', '$q', 'jobManager', ($http, $log, jobPoller, $q, jobManager) ->
  (job, files) ->
    deferred = $q.defer()

    job.language ?= 'cucumber'
    job.files = []

    for file in files
      job.files.push { name: file.name, contents: file.editor.getValue() }

    $log.debug 'Created job:'
    $log.debug job

    jobFinished = (job) ->
      endedAt = Date.now()
      $log.debug("Took #{endedAt-startedAt}ms to get job result")
      jobManager.jobFinished(job)
      deferred.resolve job

    jobCreated = (response) ->
      token = response.data.job.token
      jobPoller(token).then(jobFinished, jobPollingError)

    jobPollingError = ->
      $log.error 'Error polling job'
      jobManager.jobFinished()
      deferred.reject 'polling error'

    jobCreateError = (response) ->
      $log.error 'Error creating job:'
      $log.error response
      jobManager.jobFinished()
      deferred.reject response

    startedAt = Date.now()

    jobManager.jobStarted(job)
    $http.post(Routes.api_v1_jobs_path(), { job: job }).then(jobCreated, jobCreateError)

    deferred.promise
]
