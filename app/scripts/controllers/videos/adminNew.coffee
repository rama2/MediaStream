"use strict"
angular.module("rokumanv1.1App").controller "VideosNewCtrl", ($scope, $rootScope, $location, videoSvc, categorySvc, chanelSvc, userSvc) ->
  currentUser = $rootScope.currentUser

  # Get all categories by category
  getCategories = ->
    categorySvc.getCategories().then ((categories) ->
      $scope.categories = categories
    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or "an error occurred"
    ), (update) ->
      console.log "Got notification: " + update



  # Get all chanels by userId
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
    getCategories()
    getMyChanels()
  else
    userSvc.getMe().then ((user) ->
      $rootScope.currentUser = user
      $rootScope.userLoaded = true
      currentUser = $rootScope.currentUser
      getCategories()
      getMyChanels()
    ), ((error) ->
      $rootScope.currentUser = ""
      $rootScope.userLoaded = false
      $location.path "/login"  if not userSvc.isActive("/login") and not userSvc.isActive("/", true)
    ), (update) ->
      console.log "Got notification: " + update

  $scope.save = ->

    # Update the video
    videoSvc.addVideo(
      title: $scope.video.title
      image: $scope.video.image
      url: $scope.video.url
      chanelId: $scope.video.chanelId
      categoryIds: $scope.video.categoryIds
    ).then ((videos) ->
      $location.path "/admin/videos"
    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or "an error occurred"
    ), (update) ->
      console.log "Got notification: " + update

