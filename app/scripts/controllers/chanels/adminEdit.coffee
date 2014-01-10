"use strict"
angular.module("rokumanv1.1App").controller "ChanelsEditCtrl", ($scope, $rootScope, $location, $routeParams, chanelSvc, categorySvc) ->

  # Get the particular chanel to fill up the form on page load
  fetchChanel = ->
    chanelSvc.getChanels($routeParams.chanelId).then ((chanel) ->
      $scope.chanel = chanel
      $scope.chanel.play = "views/chanels/htmlChanel.html?" + $scope.chanel.id
    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or "an error occurred"
    ), (update) ->
      console.log "Got notification: " + update


  $scope.delete = ->
    chanelSvc.deleteChanel($routeParams.chanelId).then ((success) ->
      $location.path "/admin/chanels"
    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or "an error occurred"
    ), (update) ->
      console.log "Got notification: " + update



  # Get all categories
  getCategories = ->
    categorySvc.getCategories().then ((categories) ->
      $scope.categories = categories
    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or "an error occurred"
    ), (update) ->
      console.log "Got notification: " + update


  getCategories()
  $scope.save = ->

    # Update the chanel
    chanelSvc.updateChanel($scope.chanel.id,
      name: $scope.chanel.name
      poster: $scope.chanel.poster
      categoryIds: $scope.chanel.categoryIds
    ).then ((chanels) ->
      $location.path "/admin/chanels"
    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or "an error occurred"
    ), (update) ->
      console.log "Got notification: " + update



  # Get the chanel data here
  fetchChanel()
