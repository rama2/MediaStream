'use strict';

describe('Service: User', function () {

  // load the service's module
  beforeEach(module('Rokumanv1.1App'));

  // instantiate service
  var User;
  beforeEach(inject(function (_User_) {
    User = _User_;
  }));

  xit('should do something', function () {
    expect(!!User).toBe(true);
  });

});
