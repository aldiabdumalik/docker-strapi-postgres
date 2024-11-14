# FROM node:20-alpine
FROM node:20.11.0-alpine
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev git
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

WORKDIR /opt/
COPY package.json yarn.lock ./
ENV PATH=/opt/node_modules/.bin:$PATH
RUN npm install -g node-gyp
RUN yarn config set network-timeout 600000 -g && yarn install
# RUN npm config set fetch-retry-maxtimeout 600000 -g && npm install

WORKDIR /opt/app
COPY . .
RUN chown -R node:node /opt/app
USER node
# RUN ["npm", "run", "build"]
RUN yarn build
EXPOSE 1337
# CMD ["npm", "run", "develop"]
CMD ["yarn", "develop"]