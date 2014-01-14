if (!me) cancel("You must be logged in to post", 401);

this.ownerId = me.id;

this.postedTime = new Date().getTime();