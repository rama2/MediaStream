'use strict';

angular.module('rokumanv1.1App')
    .controller('VideosNewCtrl', function ($scope, $rootScope, $location, videoSvc, categorySvc, chanelSvc,userSvc) {

        var currentUser = $rootScope.currentUser;
        
        // Get all categories by category
        var getCategories = function () {
            categorySvc.getCategories()
                .then(function (categories) {
                    $scope.categories = categories;
                }, function (error) {
                    return console.log(error.message || (error.errors && error.errors.completed) || "an error occurred");
                }, function (update) {
                    console.log('Got notification: ' + update);
                })
        }
        
        // Get all chanels by userId
        var getMyChanels = function () {
            chanelSvc.getChanels({ownerId: currentUser.id,$sort: {postedTime : -1}})
                .then(function (chanels) {
                    $scope.chanels = chanels;
                }, function (error) {
                    return console.log(error.message || (error.errors && error.errors.completed) || "an error occurred");
                }, function (update) {
                    console.log('Got notification: ' + update);
                })
        }
        
        if(currentUser){
            getCategories();
            getMyChanels();
        }else{
        userSvc.getMe()
                .then(function (user) {
                    $rootScope.currentUser = user;
                    $rootScope.userLoaded = true;
                    currentUser = $rootScope.currentUser;
                    getCategories();
                    getMyChanels();
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

        $scope.save = function () {

            // Update the video
            videoSvc.addVideo({
                title: $scope.video.title,
                image: $scope.video.image,
                url: $scope.video.url,
                chanelId: $scope.video.chanelId,
                categoryIds: $scope.video.categoryIds
            })
                .then(function (videos) {
                    $location.path('/admin/videos');
                }, function (error) {
                    return console.log(error.message || (error.errors && error.errors.completed) || "an error occurred");
                }, function (update) {
                    console.log('Got notification: ' + update);
                })
        }

    });
