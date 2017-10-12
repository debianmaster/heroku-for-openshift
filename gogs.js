var GogsClient = require('gogs-client');
var api = new GogsClient('http://gogs.127.0.0.1.nip.io/api/v1');
/*
api.createUser({
    "username": "admin5",
    "password": "c0mputer",
    "full_name": "Demo User",
    "email": "admin5@gmail.com"
  }, {
    "username": "admin2",
    "password": "c0mputer"
  },false).then(function(user) {
   console.log(user);
}).catch(function(err){
   console.log(err);
});
*/


api.createRepo({name: 'admin5',description:'desc',private:true},{
    "username": "admin5",
    "password": "c0mputer"
  }).then(function(res){
   console.log(res);
}).catch(function(err){
   console.log(err);
});

/*
api.listRepos('admin2').then(function(res){
   console.log(res);
});
*/
