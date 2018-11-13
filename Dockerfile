FROM node:11.1.0-stretch

RUN mkdir /app

WORKDIR /app

COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN npm install

COPY . /app

EXPOSE 3000

CMD [ "npm", "start" ]
