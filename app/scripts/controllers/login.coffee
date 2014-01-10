"use strict"
angular.module("rokumanv1.1App").controller "LoginCtrl", ($scope, $timeout, $rootScope, $location, userSvc) ->

  #To check if current page is active
  $scope.isActive = userSvc.isActive
  getMe = ->
    userSvc.getMe().then ((user) ->
      $rootScope.currentUser = user
      $rootScope.userLoaded = true
    ), ((error) ->
      return $location.path("/")  if not userSvc.isActive("/login") or $rootScope.currentUser
      console.log error.message or (error.errors and error.errors.completed) or error or "an error occurred"
    ), (update) ->
      console.log "Got notification: " + update


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
      console.log "Got notification: " + update


  $scope.logout = ->
    userSvc.logout().then (->
      $rootScope.currentUser = null
      $timeout ->
        $location.path "/login"

    ), ((error) ->
      console.log error.message or (error.errors and error.errors.completed) or error or "an error occurred"
    ), (update) ->
      console.log "Got notification: " + update

