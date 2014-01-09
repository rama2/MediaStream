'use strict';

angular.module('rokumanv1.1App')
    .controller('VideoCtrl', function ($scope, $timeout, $rootScope,$routeParams, $location, videoSvc,categorySvc,userSvc) {
        var currentUser = $rootScope.currentUser;
        $scope.videos = [];

        //Cache the Videos in rootscope later

        //determine what videos to get
        var getVideos = function () {
            if(userSvc.isActive('/videos')){
                getCurrentChanelVideos();
            }
            if(userSvc.isActive('/admin/videos')){
                getMyVideos();
            }
        };
        
       var getMyVideos = function () {
            videoSvc.getVideos({ownerId: currentUser.id,chanelId: $routeParams.chanelId,$sort: {postedTime : -1}})
                .then(function (videos) {
                    $scope.videos = videos;
                }, function (error) {
                    return console.log(error.message || (error.errors && error.errors.completed) || 'an error occurred');
                }, function (update) {
                    console.log('Got notification: ' + update);
                });
        };
       
        var getCurrentChanelVideos = function () {
            videoSvc.getVideos({chanelId: $routeParams.chanelId,$sort: {postedTime : -1}})
                .then(function (videos) {
                    $scope.videos = videos;
                }, function (error) {
                    return console.log(error.message || (error.errors && error.errors.completed) || 'an error occurred');
                }, function (update) {
                    console.log('Got notification: ' + update);
                });
        };

        $scope.playVideo = function(video){

            // TODO use jquery instead

            var titleLoc = document.getElementById('vidTitle');
            var videoLoc = document.getElementById('vidBody');

            titleLoc.innerText = video.title;

            videoLoc.innerHTML = '<video width="100%" autoplay controls> <source src="' +
                video.url +
                '" type="video/mp4"> Your browser does not support the video tag. </video>';

            $('#videoModal').modal('show');

        };

        if(currentUser){
            getVideos();
        }else{
        userSvc.getMe()
                .then(function (user) {
                    $rootScope.currentUser = user;
                    $rootScope.userLoaded = true;
                    currentUser = $rootScope.currentUser;
                    getVideos();
                }, function (error) {
                    $rootScope.currentUser = '';
                    $rootScope.userLoaded = false;
                    if (!userSvc.isActive('/login') && !userSvc.isActive('/', true)) {
                        return $location.path('/login');
                    }
                return console.log(error.message || (error.errors && error.errors.completed) || 'an error occurred');

                }, function (update) {
                    console.log('Got notification: ' + update);
                });
        }

    });