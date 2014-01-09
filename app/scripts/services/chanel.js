'use strict';

angular.module('rokumanv1.1App')
    .factory('chanelSvc', function ($q) {
        // Service logic

        // Public API here
        return {
            // Parameter can be an object(filter by) or just an id(get by ID)
            getChanels: function (parameters) {

                var deferred = $q.defer();

                //scope.apply(function(){

                deferred.notify('About to get chanels.');


                //ownerId will be category later
                dpd.chanels.get(parameters, function (results, error) {

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
            updateChanel: function (id,newValues) {

                var deferred = $q.defer();

                //scope.apply(function(){

                deferred.notify('About to update the chanel.');

                dpd.chanels.put(id,newValues ,function (results, error) {

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
            addChanel: function (data) {

                var deferred = $q.defer();

                //scope.apply(function(){

                deferred.notify('About to add a new chanel.');

                dpd.chanels.post(data, function (results, error) {

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
            deleteChanel: function (id) {

                var deferred = $q.defer();

                //scope.apply(function(){

                deferred.notify('About to delete.');


                //ownerId will be category later
                dpd.chanels.del(id, function (results, error) {

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
