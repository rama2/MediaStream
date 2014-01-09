'use strict';

angular.module('rokumanv1.1App')
    .factory('videoSvc', function ($q) {
        // Service logic

        // Public API here
        return {
            // Parameter can be an object(filter by) or just an id(get by ID)
            getVideos: function (parameters) {

                var deferred = $q.defer();

                //scope.apply(function(){

                deferred.notify('About to get videos.');


                //ownerId will be category later
                dpd.videos.get(parameters, function (results, error) {

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
            updateVideo: function (id,newValues) {

                var deferred = $q.defer();

                //scope.apply(function(){

                deferred.notify('About to update the video.');

                dpd.videos.put(id,newValues ,function (results, error) {

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
            addVideo: function (data) {

                var deferred = $q.defer();

                //scope.apply(function(){

                deferred.notify('About to add a new video.');

                dpd.videos.post(data, function (results, error) {

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
            deleteVideo: function (id) {

                var deferred = $q.defer();

                //scope.apply(function(){

                deferred.notify('About to delete.');


                //ownerId will be category later
                dpd.videos.del(id, function (results, error) {

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
