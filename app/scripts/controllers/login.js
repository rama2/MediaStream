'use strict';

angular.module('rokumanv1.1App')
    .controller('LoginCtrl', function ($scope, $timeout, $rootScope, $location, userSvc) {

        //To check if current page is active
        $scope.isActive = userSvc.isActive;

        var getMe = function () {
            userSvc.getMe()
                .then(function (user) {
                    $rootScope.currentUser = user;
                    $rootScope.userLoaded = true;
                }, function (error) {

                    if (!userSvc.isActive('/login') || $rootScope.currentUser) return $location.path('/');
                    return console.log(error.message || (error.errors && error.errors.completed) || error || "an error occurred");

                }, function (update) {
                    console.log('Got notification: ' + update);
                })
        }

        $scope.login = function () {
            userSvc.login({
                username: $scope.username,
                password: $scope.password
            })
                .then(function (session) {
                    getMe();
                    $location.path('/');
                }, function (error) {

                    return console.log(error.message || (error.errors && error.errors.completed) || error || "an error occurred");
                }, function (update) {
                    console.log('Got notification: ' + update);
                })
        };

        $scope.logout = function () {
            userSvc.logout()
                .then(function () {
                    $rootScope.currentUser = null;
                    return $timeout(function () {
                        $location.path('/login');
                    });
                }, function (error) {
                    return console.log(error.message || (error.errors && error.errors.completed) || error || "an error occurred");
                }, function (update) {
                    console.log('Got notification: ' + update);
                })
        };


    });
