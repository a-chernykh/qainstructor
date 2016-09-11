angular.module('exercise').factory 'jobResult', ['jobRunner', '$q', '$http', (jobRunner, $q, $http) ->
  (job, files) ->
    deferred = $q.defer()

    finished = (job) ->
      if job.result == 'success'
        deferred.resolve job
      else
        loaded = (response) ->
          job.assets = response.data.job_assets
          for asset in job.assets
            if asset.name == 'output.html'
              job.log = asset.url
          deferred.reject job
        failed = ->
          deferred.reject job
        $http.get(Routes.api_v1_job_job_assets_path(job_token: job.token)).then(loaded, failed)
    failed = ->
      deferred.reject {}

    jobRunner(job, files).then(finished, failed)

    deferred.promise
]
