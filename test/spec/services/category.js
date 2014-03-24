'use strict';

describe('Service: Category', function () {

  // load the service's module
  beforeEach(module('rokumanv1.1App'));

  // instantiate service
  var Category;
  beforeEach(inject(function (_Category_) {
    Category = _Category_;
  }));

  xit('should do something', function () {
    expect(!!Category).toBe(true);
  });

});
