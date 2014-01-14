//if(query.include === 'classes') {
  dpd.chanels.get({id: this.chanelId}, function(chanel) {
    this.chanelName = (chanel)?chanel.name : '';
  });
//}