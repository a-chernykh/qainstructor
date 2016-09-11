angular.module('common').filter 'trusted', ['$sce', ($sce) ->
  (url) -> $sce.trustAsResourceUrl(url)
]
