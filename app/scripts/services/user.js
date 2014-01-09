'use strict';

angular.module('rokumanv1.1App')
    .factory('userSvc', function ($q,$location) {
        // Service logic

        // Public API here
        return {
            getMe: function () {
                var deferred = $q.defer();

                //scope.apply(function(){

                deferred.notify('About to getMe.');

                dpd.users.me(function (user) {

                    if (!user) {
                        deferred.reject('Cannot get current user');
                    }
                    else {
                        deferred.resolve(user);
                    }
                })

                //  });
                return deferred.promise;
            },
            login: function (credentials) {
                var deferred = $q.defer();

                //scope.apply(function(){

                deferred.notify('About to login.');


                dpd.users.login(credentials, function (session, error) {

                    if (error) {
                        deferred.reject(error);
                    }
                    else {
                        deferred.resolve(session);
                    }
                })

                //  });
                return deferred.promise;
            },
            logout: function () {

                var deferred = $q.defer();

                //scope.apply(function(){

                deferred.notify('About to logout.');


                dpd.users.logout(function () {

                        deferred.resolve();

                })

                //  });
                return deferred.promise;
            },

            isActive: function(route,strict) {
            if(strict === true){
                return route === $location.path();
            }
            //Only considering the base path (begining)
            return  ($location.path().indexOf(route) === 0);
        }
        };
    });
