"use strict"
angular.module("rokumanv1.1App").factory "userSvc", ($q, $location) ->

  # Service logic

  # Public API here
  getMe: ->
    deferred = $q.defer()

    #scope.apply(function(){
    deferred.notify "About to getMe."
    dpd.users.me (user) ->
      unless user
        deferred.reject "Cannot get current user"
      else
        deferred.resolve user


    #  });
    deferred.promise

  login: (credentials) ->
    deferred = $q.defer()

    #scope.apply(function(){
    deferred.notify "About to login."
    dpd.users.login credentials, (session, error) ->
      if error
        deferred.reject error
      else
        deferred.resolve session


    #  });
    deferred.promise

  logout: ->
    deferred = $q.defer()

    #scope.apply(function(){
    deferred.notify "About to logout."
    dpd.users.logout ->
      deferred.resolve()


    #  });
    deferred.promise

  isActive: (route, strict) ->
    return route is $location.path()  if strict is true

    #Only considering the base path (begining)
    $location.path().indexOf(route) is 0
