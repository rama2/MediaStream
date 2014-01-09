'use strict';

describe('Controller: VideosVideoidCtrl', function () {

  // load the controller's module
  beforeEach(module('rokumanv1.1App'));

  var VideosVideoidCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    VideosVideoidCtrl = $controller('VideosVideoidCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
