FROM node:lts-alpine
ENV PATH /usr/src/app/node_modules/.bin:$PATH
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "./"]
RUN npm install --production --silent && mv node_modules ../
COPY . .
EXPOSE 3000
CMD ["node", "server.js"]
