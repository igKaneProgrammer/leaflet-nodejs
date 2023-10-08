FROM node:18
LABEL maintainer="Night"
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

EXPOSE 9966
CMD [ "npm","start"]