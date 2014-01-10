"use strict"
angular.module("rokumanv1.1App").factory "categorySvc", ($q) ->

  # Service logic

  # Public API here

  # Parameter can be an object(filter by) or just an id(get by ID)
  getCategories: (parameters) ->
    deferred = $q.defer()

    #scope.apply(function(){
    deferred.notify "About to get categories."
    dpd.categories.get parameters, (results, error) ->
      if error
        deferred.reject error
      else
        deferred.resolve results


    #  });
    deferred.promise


  # Parameter can be an object(filter by) or just an id(get by ID)
  updateCategory: (id, newValues) ->
    deferred = $q.defer()

    #scope.apply(function(){
    deferred.notify "About to update the category."
    dpd.categories.put id, newValues, (results, error) ->
      if error
        deferred.reject error
      else
        deferred.resolve results


    #  });
    deferred.promise


  # Parameter can be an object(filter by) or just an id(get by ID)
  addCategory: (data) ->
    deferred = $q.defer()

    #scope.apply(function(){
    deferred.notify "About to add a new category."
    dpd.categories.post data, (results, error) ->
      if error
        deferred.reject error
      else
        deferred.resolve results


    #  });
    deferred.promise

  deleteCategory: (id) ->
    deferred = $q.defer()

    #scope.apply(function(){
    deferred.notify "About to delete."
    dpd.categories.del id, (results, error) ->
      if error
        deferred.reject error
      else
        deferred.resolve results


    #  });
    deferred.promise
