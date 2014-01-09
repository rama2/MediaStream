'use strict';

angular.module('rokumanv1.1App')
    .controller('ChanelsNewCtrl', function ($scope, $rootScope, $location, chanelSvc, categorySvc) {

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

        $scope.save = function () {

            // Update/Save the chanel
            chanelSvc.addChanel({
                name: $scope.chanel.title,
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

        //fetch categories
        getCategories();
    });
