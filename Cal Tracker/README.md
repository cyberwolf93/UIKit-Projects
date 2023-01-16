![ald text](CalTracker.png)

# CalTracker

This app made to help people track their calories

## Screenshots
<img src="screenshots/sign-in.PNG" width="200">
<img src="screenshots/dashboard.PNG" width="200">
<img src="screenshots/add-entry.PNG" width="200">
<img src="screenshots/account.PNG" width="200">


## Installation

clone the project from GitHub

### Server

navigate inside server directory 
```bash
cd Server/
```
 
 Then run this command

```bash
npm install
```


### Client 

navigate inside Client a directory 
```bash
cd Client/CalTracker/
```
 
 Then run this command

```bash
pod install
```


## Usage

First you have to run the server by navigating to server directory and run 

```base
npm start
```

Then open CalTracker.xcworkspace from
```base
/Client/CalTracker/
```

And make sure to add your local ip address ex: http://127.0.0.1 or http://localhost/
with port 3000 in the info.plist file under base_url key

Then you are good to go, Have fun ^_^
