'use strict';

describe('Controller: VideosNewCtrl', function () {

  // load the controller's module
  beforeEach(module('rokumanv1.1App'));

  var VideosNewCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    VideosNewCtrl = $controller('VideosNewCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
