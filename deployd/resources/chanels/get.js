if (!me || me.role !== "admin") {
 if (!query.ownerId) {
  //cancel("You must specify the ownerId", 401);
 }
}

//if(query.include === 'classes') {
  dpd.categories.get({id: {$in:this.categoryIds}}, function(categories) {
    this.categories = (categories)?categories : [];
  });
//}