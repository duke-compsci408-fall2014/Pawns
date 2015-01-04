1. Portforwarding
  - ssh -L 3306:127.0.0.1:3306 root@bayareachess.com
  - Daemonize this
2. Start Server
  - npm start
3. Set Google Calendar Enviroment Variable
  - API Key
4. Setup Redis
 - apt-get install redis-server
 - add redis server upstart script
 - daemonize
