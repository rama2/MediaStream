"use strict"
angular.module("rokumanv1.1App").controller "VideosEditCtrl", ($scope, $rootScope, $location, $routeParams, videoSvc, categorySvc, chanelSvc, userSvc) ->
  currentUser = $rootScope.currentUser

  # Get the particular video to fill up the form on page load
  fetchVideo = ->
    videoSvc.getVideos($routeParams.videoId).then ((video) ->
      $scope.video = video
      $scope.video.play = "views/videos/htmlVideo.html?" + $scope.video.id
    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or "an error occurred"
    ), (update) ->
      console.log "Got notification: " + update


  $scope.delete = ->
    videoSvc.deleteVideo($routeParams.videoId).then ((success) ->
      $location.path "/admin/videos"
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
    videoSvc.updateVideo($scope.video.id,
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



  # Get the video data here
  fetchVideo()
