"use strict"
angular.module("rokumanv1.1App", ["ngCookies", "ngResource", "ngSanitize", "ngRoute"]).config(($routeProvider) ->
  $routeProvider.when("/",
    templateUrl: "views/main.html"
    controller: "MainCtrl"
    title: "Rokuman - Home"
  ).when("/login",
    templateUrl: "views/login.html"
    controller: "LoginCtrl"
    title: "Rokuman - Login"
  ).when("/admin/videos",
    templateUrl: "views/videos/adminList.html"
    controller: "VideoCtrl"
    title: "Rokuman - Videos"
  ).when("/admin/videos/edit/:videoId",
    templateUrl: "views/videos/adminEdit.html"
    controller: "VideosEditCtrl"
    title: "Rokuman - Edit Video"
  ).when("/admin/videos/new",
    templateUrl: "views/videos/adminEdit.html"
    controller: "VideosNewCtrl"
    title: "Rokuman - New Video"
  ).when("/videos",
    templateUrl: "views/videos/list.html"
    controller: "VideoCtrl"
  ).when("/admin/chanels",
    templateUrl: "views/chanels/adminList.html"
    controller: "ChanelCtrl"
    title: "Rokuman - Chanels"
  ).when("/admin/chanels/edit/:chanelId",
    templateUrl: "views/chanels/adminEdit.html"
    controller: "ChanelsEditCtrl"
    title: "Rokuman - Edit Video"
  ).when("/admin/chanels/new",
    templateUrl: "views/chanels/adminEdit.html"
    controller: "ChanelsNewCtrl"
    title: "Rokuman - New Video"
  ).when("/chanels",
    templateUrl: "views/chanels/list.html"
    controller: "ChanelCtrl"
  ).otherwise redirectTo: "/"
).run ["$rootScope", "$location", "userSvc", ($rootScope, $location, userSvc) ->
  # Initialize the current user to null
  $rootScope.currentUser = $rootScope.currentUser or ""
  $rootScope.$on "$routeChangeSuccess", (currentRoute, previousRoute) ->
    userSvc.getMe().then ((user) ->
      $rootScope.currentUser = user
      $rootScope.userLoaded = true
    ), ((error) ->
      $rootScope.currentUser = ""
      $rootScope.userLoaded = false
      $location.path "/login"  if not userSvc.isActive("/login") and not userSvc.isActive("/", true)
    ), (update) ->
      console.log "Got notification: #{update}"
]