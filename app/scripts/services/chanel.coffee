"use strict"
angular.module("rokumanv1.1App").factory "chanelSvc", ($q) ->

  # Service logic

  # Public API here

  # Parameter can be an object(filter by) or just an id(get by ID)
  getChanels: (parameters) ->
    deferred = $q.defer()

    #scope.apply(function(){
    deferred.notify "About to get chanels."

    #ownerId will be category later
    dpd.chanels.get parameters, (results, error) ->
      if error
        deferred.reject error
      else
        deferred.resolve results


    #  });
    deferred.promise


  # Parameter can be an object(filter by) or just an id(get by ID)
  updateChanel: (id, newValues) ->
    deferred = $q.defer()

    #scope.apply(function(){
    deferred.notify "About to update the chanel."
    dpd.chanels.put id, newValues, (results, error) ->
      if error
        deferred.reject error
      else
        deferred.resolve results


    #  });
    deferred.promise


  # Parameter can be an object(filter by) or just an id(get by ID)
  addChanel: (data) ->
    deferred = $q.defer()

    #scope.apply(function(){
    deferred.notify "About to add a new chanel."
    dpd.chanels.post data, (results, error) ->
      if error
        deferred.reject error
      else
        deferred.resolve results


    #  });
    deferred.promise

  deleteChanel: (id) ->
    deferred = $q.defer()

    #scope.apply(function(){
    deferred.notify "About to delete."

    #ownerId will be category later
    dpd.chanels.del id, (results, error) ->
      if error
        deferred.reject error
      else
        deferred.resolve results


    #  });
    deferred.promise
