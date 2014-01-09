'use strict';

describe('Controller: VideosEditCtrl', function () {

  // load the controller's module
  beforeEach(module('rokumanv1.1App'));

  var VideosEditCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    VideosEditCtrl = $controller('VideosEditCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
