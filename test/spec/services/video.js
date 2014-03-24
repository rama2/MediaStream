'use strict';

describe('Service: Video', function () {

  // load the service's module
  beforeEach(module('rokumanv1.1App'));

  // instantiate service
  var VideoSvc;
  beforeEach(inject(function (_VideoSvc_) {
    VideoSvc = _VideoSvc_;
  }));

  xit('should do something', function () {
    expect(!!VideoSvc).toBe(true);
  });

});
