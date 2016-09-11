//= require courses/common
//= require courses/store
//= require_tree ./courses/common
//= require_tree ./courses/store
angular.module 'course', ['store', 'ng-rails-csrf']
