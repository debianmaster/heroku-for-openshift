#!/usr/bin/env node
const prog = require('caporal');
var GogsClient = require('gogs-client');
var api = new GogsClient('https://try.gogs.io/api/v1');
api.searchRepos('gogs', 0, 5).then(function(list) {
    console.log(list);
});
prog
  .command('apps:create','Create app') 
  .argument('<app>', 'App to deploy')
  .action(function(args, options, logger) {
      console.log(args,options)
  });

prog
  .command('apps','List apps')
  .action(function(args, options, logger) {
      console.log(args,options)
  });

prog.parse(process.argv);
