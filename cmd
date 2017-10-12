#!/usr/bin/env node
const prog = require('caporal');
var prompt = require('prompt');
var GogsClient = require('gogs-client');
var api = new GogsClient('https://try.gogs.io/api/v1');
const OpenShiftClient = require('openshift-client');

function getOAPI(url,token){
  var oapi = new OpenShiftClient.OApi({
    url: url,
    insecureSkipTlsVerify: true,
    auth: {
      bearer: token
    }
  });
  return oapi;
}



var netrc = require('netrc');
var myNetrc = netrc();
//console.log(myNetrc);

prog
  .command('auth','Set credentials')
  .option('-u, --username', 'Openshift username')
  .option('-p, --password', 'Openshift password')
  .option('-g, --gitserver', 'Git server URL')
  .option('-n, --namespace', 'Openshift namespace')
  .argument('<URL>', 'Openshift console url')
  .action(function(args, options, logger) {
      var gitserver=options.gitserver.replace('https:\/\/','');
      gitserver=gitserver.replace('http:\/\/')
      myNetrc['openshift.local']={
          login : options.username,
          password: options.password,
          url: args.url,
          gitserver: gitserver,
          ns: options.namespace
      }
      myNetrc[gitserver]={
          login : options.username,
          password: options.password
      }
      netrc.save(myNetrc);
      console.log("Config Saved");
  });

prog
  .command('apps','List apps')
  .action(function(args, options, logger) {
      if(undefined==myNetrc['openshift.local'])
        console.log('Please login')
      else{
        var opi=getOAPI(myNetrc['openshift.local'].url,"pdoiU7snbeIC4BpWzvbagWKqyjVcSp2a5ik1J8EALLw")
        //console.log(myNetrc['openshift.local']); 
        opi.ns(myNetrc['openshift.local'].ns).deploymentconfigs.get((err, result) => {
            if (err) throw err;
            console.log(JSON.stringify(result, null, 2));
        });
      }
  });
prog
  .command('apps:create','Create app') 
  .argument('<app>', 'App to deploy')
  .action(function(args, options, logger) {
     prompt.start();
     prompt.get(['username', 'email'], function (err, result) {
    	console.log('Command-line input received:');
    	console.log('  username: ' + result.username);
    	console.log('  email: ' + result.email);
     }); 
     //console.log(args)
  });
prog.parse(process.argv);
