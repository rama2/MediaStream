'use strict';

angular.module('rokumanv1.1App')
    .controller('ChanelsEditCtrl', function ($scope, $rootScope, $location, $routeParams, chanelSvc,categorySvc) {
        // Get the particular chanel to fill up the form on page load
        var fetchChanel = function () {
            chanelSvc.getChanels($routeParams.chanelId)
                .then(function (chanel) {
                    $scope.chanel = chanel;
                    $scope.chanel.play = 'views/chanels/htmlChanel.html?'+$scope.chanel.id;
                }, function (error) {
                    return console.log(error.message || (error.errors && error.errors.completed) || "an error occurred");
                }, function (update) {
                    console.log('Got notification: ' + update);
                })
        };

        $scope.delete = function () {
            chanelSvc.deleteChanel($routeParams.chanelId)
                .then(function (success) {
                    $location.path('/admin/chanels');
                }, function (error) {
                    return console.log(error.message || (error.errors && error.errors.completed) || "an error occurred");
                }, function (update) {
                    console.log('Got notification: ' + update);
                })

        };

        // Get all categories
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

        getCategories();

        $scope.save = function () {
            // Update the chanel
            chanelSvc.updateChanel($scope.chanel.id, {
                name: $scope.chanel.name,
                poster: $scope.chanel.poster,
                categoryIds: $scope.chanel.categoryIds
            })
                .then(function (chanels) {
                    $location.path('/admin/chanels');
                }, function (error) {
                    return console.log(error.message || (error.errors && error.errors.completed) || "an error occurred");
                }, function (update) {
                    console.log('Got notification: ' + update);
                })
        }


        // Get the chanel data here
        fetchChanel();
    });
