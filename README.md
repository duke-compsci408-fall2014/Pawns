# Bay Area Chess

This is the official repository for the Bay Area Chess iPhone
App. The Bay Area Chess App is a Swift based iOS App supported by 
a Node.js API server.

Please feel free to post issues and we’ll fix
them as soon as we can.

### Version
1.0.0 Beta

### Technologies

* [Swift] - Apple’s New Programming Language.
* [Node.js] - Evented I/O for the Backend.
* [Express.js] - A Node.js Web Framework.
* [PayPal iOS SDK] - PayPal SDK for iOS.

### Building and Deploying

Before building or deploying this app, please make sure that you have 
Node.js installed as well as the latest version of XCode. Node.js can 
be downloaded via the [Node.js] website, XCode can down downloaded from 
[Apple].

##### Server

 1. Clone this directory to the server on which you wish to deploy to.
 2. Change to the api_server directory under the root directory.
 3. Type ‘npm install’ to install all of the Node.js dependencies.
 4. Type ‘node server’ to start the server, it will default to port 3000.
 5. If you wish to deploy this in production, ensure that you are forwarding
    traffic from port 8080 to port 3000.
 6. To daemonize this process, download forever (‘npm install forever’) and
    run the server with forever (‘forever node server’).

##### iOS
 1. Clone this directory.
 2. Change to the BayAreaChess directory.
 3. Open the .xcodeproj directory with XCode
 4. To build the project, from the Product menu, click Build.
 5. To build and deploy this project, first click the Product menu, next 
    click the Destination option and choose your desired destination device.A
    Finally click Product->Run and it will deploy to the disired target.

### Development

We welcome contributors to make Bay Area Chess better!
Please file a pull request if you have a contribution you’d
like us to review!

License
----

MIT

### Contact

Have questions? Contact [Carlos Reyes].

**Play Chess!**

[Carlos Reyes]:http://carlos.vc/
[Node.js]:http://nodejs.org
[Express.js]:http://expressjs.com
[Swift]:https://www.apple.com/swift/
[PayPal iOS SDK]:https://github.com/paypal/PayPal-iOS-SDK
[Apple]:https://developer.apple.com/xcode/downloads/
