"use strict"
angular.module("rokumanv1.1App").controller "ChanelCtrl", ($scope, $timeout, $rootScope, $location, chanelSvc, categorySvc, userSvc) ->
  currentUser = $rootScope.currentUser
  $scope.videos = []

  # Cache the Chanels in rootscope later

  #determine what videos to get
  getChanels = ->
    getAllChanels()  if userSvc.isActive("/chanels")
    getMyChanels()  if userSvc.isActive("/admin/chanels")


  # Get all chanels
  getAllChanels = ->
    chanelSvc.getChanels($sort:
      postedTime: -1
    ).then ((chanels) ->
      $scope.chanels = chanels
    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or "an error occurred"
    ), (update) ->
      console.log "Got notification: " + update



  # Get all chanels by current user
  getMyChanels = ->
    chanelSvc.getChanels(
      ownerId: currentUser.id
      $sort:
        postedTime: -1
    ).then ((chanels) ->
      $scope.chanels = chanels
    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or "an error occurred"
    ), (update) ->
      console.log "Got notification: " + update


  if currentUser
    getChanels()
  else
    userSvc.getMe().then ((user) ->
      $rootScope.currentUser = user
      $rootScope.userLoaded = true
      currentUser = $rootScope.currentUser
      getChanels()
    ), ((error) ->
      $rootScope.currentUser = ""
      $rootScope.userLoaded = false
      $location.path "/login"  if not userSvc.isActive("/login") and not userSvc.isActive("/", true)
    ), (update) ->
      console.log "Got notification: " + update

