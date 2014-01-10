"use strict"
angular.module("rokumanv1.1App").controller "ChanelsNewCtrl", ($scope, $rootScope, $location, chanelSvc, categorySvc) ->

  # Get all categories by category
  getCategories = ->
    categorySvc.getCategories().then ((categories) ->
      $scope.categories = categories
    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or "an error occurred"
    ), (update) ->
      console.log "Got notification: " + update


  $scope.save = ->

    # Update/Save the chanel
    chanelSvc.addChanel(
      name: $scope.chanel.title
      poster: $scope.chanel.poster
      categoryIds: $scope.chanel.categoryIds
    ).then ((chanels) ->
      $location.path "/admin/chanels"
    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or "an error occurred"
    ), (update) ->
      console.log "Got notification: " + update



  #fetch categories
  getCategories()
