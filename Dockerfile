FROM node:alpine

WORKDIR /app

COPY package.json package-lock.json /app/

RUN npm run install

COPY . .

EXPOSE 3000

CMD [ "node", "server.js" ]