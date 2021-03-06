class FormCtrl

  @$inject = ["$scope", "$location", "org"]
  constructor: ($scope, $location, org) ->
    $scope.org = org

    $scope.save = (org) ->
      return if $scope.editForm.$invalid

      onSuccess = (org) ->
        $location.path "/#{org.id}"

      onError = (response) ->
        if response.status is 422
          errors = response.data.errors
          $scope.editForm.$serverError = errors.org

      org.save success: onSuccess, error: onError

angular.module("angleGrinder")
  .controller("org.FormCtrl", FormCtrl)
