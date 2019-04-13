function() {
  var env = karate.env; 
 
  karate.log('karate.env selected environment was:', env);
  karate.configure("ssl", false);
 
  if (!env) {
    env = 'dev'; 
  }
  var config = {
        env: env,
        USERNAME: 'devuser',
        PASSWORD: 'devpass',
        HOST: 'https://jsonplaceholder.typicode.com',
        PATH_POSTS:'posts',
        PATH_COMMENTS:'comments'
  };
 
  if(env == 'qa') {
    config.USERNAME= 'myUserName'
    config.PASSWORD= 'myPa55word'
  }
 
  if(env == 'live') {
     config.USERNAME= 'admin'
     config.PASSWORD= 'secret'
  }
 
  karate.log('Default Host:', config.HOST);
  karate.configure('connectTimeout', 60000);
  karate.configure('readTimeout', 60000);
 
  return config;
}