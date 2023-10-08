<h1 align="left">Hi there, I'm <a href="https://t.me/by_n1ght" target="_blank">Night</a> 
<img src="https://github.com/blackcater/blackcater/raw/main/images/Hi.gif" height="32"/></h1>
<h3 align="left">Deploying leaflet on a Docker container</h3>

hese are tutorials on using Leaflet with Nodejs which is deployed on. 
To install the guide, simply copy it to any folder and run npm start in that folder on your console. 
I use Browserify and Beefy to run tutorials on localhost. If you do too, you will find it at http://localhost:9966/ on your computer.

<h3 align="left">Usage</h3>

<b>1. Clone the repository</b>

To quickly copy this repository, use the command
```
git clone https://github.com/igKaneProgrammer/leaflet-nodejs-docker.git
```

<b>2. Running a leaflet container</b>

Then go to the folder with the cloned repository and run the command.

Note that I'm using port 9966, so if you need a different port, change it in Dockerfile.

```
docker build . -t leaflet/docker

```

After that, we launch our created image with port 9966

```
docker run -p 9966:9966 leaflet/docker

```

In the end, this is what we got

Now your leflet is available locally on 127.0.0.1 using port 9966.

![image](https://github.com/igKaneProgrammer/leaflet-nodejs-docker/assets/99356343/0eda9e1d-4839-4401-8667-eccd7d4ce1b2)

<h3 align="left">Structure</h3>

Dockerfile structure:

```
FROM node:18

# Create app directory
WORKDIR /usr/src/app

COPY package*.json ./
RUN apt-get update
RUN apt upgrade -y
RUN apt-get install npm -y
RUN npm init -y
RUN npm install --save leaflet -y
RUN npm install --save-dev beefy browserify -y
RUN npm install --save mysql -y
RUN apt-get install jq -y
RUN jq '.scripts += {"start": "beefy app.js:bundle.js --live", "bundle": "browserify app.js -o bundle.js"}' package.json > tmp.json && mv tmp.json package.json


COPY . .

EXPOSE 3333
CMD [ "npm","start"]
```
index.html structure:

```
<!doctype html>
<html>
<head>
<title>My first Leaflet example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="node_modules/leaflet/dist/leaflet.css">
<link rel="stylesheet" href="style/style.css">
</head>
<body>
<div id="map"></div>
<script src="bundle.js"></script>
</body>
</html>

```
app.js structure:

```
// Initialize leaflet.js
var L = require('leaflet');

// Initialize the map
var map = L.map('map', {
  scrollWheelZoom: false
});

// Set the position and zoom level of the map
map.setView([47.70, 13.35], 7);

// Initialize the base layer
var osm_mapnik = L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
	maxZoom: 19,
	attribution: '&copy; OSM Mapnik <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
}).addTo(map);
```

style.css structure:

```
#map
{
    width: auto;
    height: 500px;
}

```
