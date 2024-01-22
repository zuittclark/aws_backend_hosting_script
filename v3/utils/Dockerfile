FROM node:20-alpine


RUN npm install -g nodemon

WORKDIR /app

COPY package*.json .

RUN npm install

COPY . .

EXPOSE 4000

# CMD [ "node", "index.js" ]

CMD [ "nodemon", "-L", "index.js" ]