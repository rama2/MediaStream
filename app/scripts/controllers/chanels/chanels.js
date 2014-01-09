'use strict';

angular.module('rokumanv1.1App')
    .controller('ChanelCtrl', function ($scope, $timeout, $rootScope, $location, chanelSvc,categorySvc,userSvc) {
        var currentUser = $rootScope.currentUser;
        $scope.videos = [];

        // Cache the Chanels in rootscope later
        
        //determine what videos to get
        var getChanels = function () {
            if(userSvc.isActive('/chanels')){
                getAllChanels();
            }
            if(userSvc.isActive('/admin/chanels')){
                getMyChanels();
            }
        }

        // Get all chanels
        var getAllChanels = function () {
            chanelSvc.getChanels({$sort: {postedTime : -1}})
                .then(function (chanels) {
                    $scope.chanels = chanels;
                }, function (error) {
                    return console.log(error.message || (error.errors && error.errors.completed) || "an error occurred");
                }, function (update) {
                    console.log('Got notification: ' + update);
                })
        };
        // Get all chanels by current user
        var getMyChanels = function () {
            chanelSvc.getChanels({ownerId: currentUser.id,$sort: {postedTime : -1}})
                .then(function (chanels) {
                    $scope.chanels = chanels;
                }, function (error) {
                    return console.log(error.message || (error.errors && error.errors.completed) || "an error occurred");
                }, function (update) {
                    console.log('Got notification: ' + update);
                })
        };
        
        if(currentUser){
            getChanels();
        }else{
        userSvc.getMe()
                .then(function (user) {
                    $rootScope.currentUser = user;
                    $rootScope.userLoaded = true;
                    currentUser = $rootScope.currentUser;
                    getChanels();
                }, function (error) {
                    $rootScope.currentUser = '';
                    $rootScope.userLoaded = false;
                    if (!userSvc.isActive('/login') && !userSvc.isActive('/', true)) {
                        return $location.path('/login');
                    }

                }, function (update) {
                    console.log('Got notification: ' + update);
                })
        }
    });
