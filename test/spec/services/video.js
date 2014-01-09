'use strict';

describe('Service: Video', function () {

  // load the service's module
  beforeEach(module('Rokumanv11App'));

  // instantiate service
  var VideoSvc;
  beforeEach(inject(function (_VideoSvc_) {
    VideoSvc = _VideoSvc_;
  }));

  it('should do something', function () {
    expect(!!VideoSvc).toBe(true);
  });

});
