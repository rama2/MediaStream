'use strict';

angular.module('rokumanv1.1App')
    .factory('categorySvc', function ($q) {
        // Service logic

        // Public API here
        return {
            // Parameter can be an object(filter by) or just an id(get by ID)
            getCategories: function (parameters) {

                var deferred = $q.defer();

                //scope.apply(function(){

                deferred.notify('About to get categories.');

                dpd.categories.get(parameters, function (results, error) {

                    if (error) {
                        deferred.reject(error);
                    }
                    else {
                        deferred.resolve(results);
                    }
                })

                //  });
                return deferred.promise;
            },
            // Parameter can be an object(filter by) or just an id(get by ID)
            updateCategory: function (id,newValues) {

                var deferred = $q.defer();

                //scope.apply(function(){

                deferred.notify('About to update the category.');

                dpd.categories.put(id,newValues ,function (results, error) {

                    if (error) {
                        deferred.reject(error);
                    }
                    else {
                        deferred.resolve(results);
                    }
                })

                //  });
                return deferred.promise;
            },
            // Parameter can be an object(filter by) or just an id(get by ID)
            addCategory: function (data) {

                var deferred = $q.defer();

                //scope.apply(function(){

                deferred.notify('About to add a new category.');

                dpd.categories.post(data, function (results, error) {

                    if (error) {
                        deferred.reject(error);
                    }
                    else {
                        deferred.resolve(results);
                    }
                })

                //  });
                return deferred.promise;
            },
            deleteCategory: function (id) {

                var deferred = $q.defer();

                //scope.apply(function(){

                deferred.notify('About to delete.');

                dpd.categories.del(id, function (results, error) {

                    if (error) {
                        deferred.reject(error);
                    }
                    else {
                        deferred.resolve(results);
                    }
                })

                //  });
                return deferred.promise;
            }
        };
    });
