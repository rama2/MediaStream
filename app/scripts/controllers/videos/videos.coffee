"use strict"
angular.module("rokumanv1.1App").controller "VideoCtrl", ($scope, $timeout, $rootScope, $routeParams, $location, videoSvc, categorySvc, userSvc) ->
  currentUser = $rootScope.currentUser
  $scope.videos = []

  #Cache the Videos in rootscope later

  #determine what videos to get
  getVideos = ->
    getCurrentChanelVideos()  if userSvc.isActive("/videos")
    getMyVideos()  if userSvc.isActive("/admin/videos")

  getMyVideos = ->
    videoSvc.getVideos(
      ownerId: currentUser.id
      chanelId: $routeParams.chanelId
      $sort:
        postedTime: -1
    ).then ((videos) ->
      $scope.videos = videos
    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or "an error occurred"
    ), (update) ->
      console.log "Got notification: #{update}"

  getCurrentChanelVideos = ->
    videoSvc.getVideos(
      chanelId: $routeParams.chanelId
      $sort:
        postedTime: -1
    ).then ((videos) ->
      $scope.videos = videos
    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or "an error occurred"
    ), (update) ->
      console.log "Got notification: #{update}"

  $scope.playVideo = (video) ->

    # TODO use jquery instead
    titleLoc = document.getElementById("vidTitle")
    videoLoc = document.getElementById("vidBody")
    titleLoc.innerText = video.title
    videoLoc.innerHTML = "<video width=\"100%\" autoplay controls> <source src=\"" + video.url + "\" type=\"video/mp4\"> Your browser does not support the video tag. </video>"
    $("#videoModal").modal "show"

  if currentUser
    getVideos()
  else
    userSvc.getMe().then ((user) ->
      $rootScope.currentUser = user
      $rootScope.userLoaded = true
      currentUser = $rootScope.currentUser
      getVideos()
    ), ((error) ->
      $rootScope.currentUser = ""
      $rootScope.userLoaded = false
      return $location.path("/login")  if not userSvc.isActive("/login") and not userSvc.isActive("/", true)
      console.log error.message or (error.errors and error.errors.completed) or "an error occurred"
    ), (update) ->
      console.log "Got notification: #{update}"