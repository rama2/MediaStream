"use strict"
angular.module("rokumanv1.1App").controller "MainCtrl", ($scope) ->
  $scope.awesomeThings = ["Upload your media", "Add it to Rokuman", "Watch it on your TV"]
  $scope.signUp = ->
    alert "Please send an email to bah@togomix.com \nto request an invite."
