angular.module('common').factory 'notifier', ->
  stepSuccess: (step) -> $.notify({message: 'Step has been successfully completed'}, {type: 'success'})
  stepFailed: (step) -> $.notify({message: 'Step was not completed. Click here to see why.', url: step.log}, {type: 'danger'})
  exerciseSuccess: -> $.notify({message: 'Exercise has been successfully completed. Click "Continue" button to go to the next chapter.'}, {type: 'success'})
  purchaseFailed: (error) -> $.notify({message: "Unable to purchase the course: #{error}"}, {type: 'danger', delay: 0})
