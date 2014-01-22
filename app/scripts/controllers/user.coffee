"use strict"
angular.module("rokumanv1.1App").controller "UserCtrl", ($scope, $timeout, $rootScope, $location, userSvc) ->

  #To check if current page is active
  $scope.isActive = userSvc.isActive
  getMe = ->
    userSvc.getMe().then ((user) ->
      $rootScope.currentUser = user
      $rootScope.userLoaded = true
    ), ((error) ->
      return $location.path("/")  if not userSvc.isActive("/login") or not userSvc.isActive("/signup") or $rootScope.currentUser
      console.log error.message or (error.errors and error.errors.completed) or error or "an error occurred"
    ), (update) ->
      console.log "Got notification:  #{update}"

  $scope.login = ->
    userSvc.login(
      username: $scope.username
      password: $scope.password
    ).then ((session) ->
      getMe()
      $location.path "/"
    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or error or "an error occurred"
    ), (update) ->
      console.log "Got notification: #{update}"


  $scope.logout = ->
    userSvc.logout().then (->
      $rootScope.currentUser = null
      $timeout ->
        $location.path "/login"

    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or error or "an error occurred"
    ), (update) ->
      console.log "Got notification: #{update}"

  $scope.save = ->

    # Add the new user
    userSvc.addUser(
      username: $scope.user.username
      password: $scope.user.password
      fullName: $scope.user.fullName
      email: $scope.user.email
      role: $scope.user.role
    ).then ((user) ->
      $location.path "/admin/videos"
    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or "an error occurred"
    ), (update) ->
      console.log "Got notification: #{update}"