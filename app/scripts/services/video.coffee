"use strict"
angular.module("rokumanv1.1App").factory "videoSvc", ($q) ->

  # Service logic

  # Public API here

  # Parameter can be an object(filter by) or just an id(get by ID)
  getVideos: (parameters) ->
    deferred = $q.defer()

    #scope.apply(function(){
    deferred.notify "About to get videos."

    #ownerId will be category later
    dpd.videos.get parameters, (results, error) ->
      if error
        deferred.reject error
      else
        deferred.resolve results


    #  });
    deferred.promise


  # Parameter can be an object(filter by) or just an id(get by ID)
  updateVideo: (id, newValues) ->
    deferred = $q.defer()

    #scope.apply(function(){
    deferred.notify "About to update the video."
    dpd.videos.put id, newValues, (results, error) ->
      if error
        deferred.reject error
      else
        deferred.resolve results


    #  });
    deferred.promise


  # Parameter can be an object(filter by) or just an id(get by ID)
  addVideo: (data) ->
    deferred = $q.defer()

    #scope.apply(function(){
    deferred.notify "About to add a new video."
    dpd.videos.post data, (results, error) ->
      if error
        deferred.reject error
      else
        deferred.resolve results


    #  });
    deferred.promise

  deleteVideo: (id) ->
    deferred = $q.defer()

    #scope.apply(function(){
    deferred.notify "About to delete."

    #ownerId will be category later
    dpd.videos.del id, (results, error) ->
      if error
        deferred.reject error
      else
        deferred.resolve results


    #  });
    deferred.promise
