# FROM node:12 as builder

# RUN mkdir -p /app

# WORKDIR /app

# COPY . .

# RUN npm install
# RUN npm run build --prod

# CMD ["npm", "start"]

# FROM nginx:alpine
# COPY src/nginx/etc/conf.d/default.conf /etc/nginx/conf/default.conf
# COPY --from=builder app/dist/angular8-crud-demo usr/share/nginx/html


# FROM node:18
# WORKDIR /app
# COPY . .
# RUN npm install
# RUN npm run build
# EXPOSE 8080
# CMD [ "node", "server.js" ]


### STAGE 1: Build ###
FROM node:12 as builder
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

### STAGE 2: Run ###
FROM nginx:alpine
COPY src/nginx/etc/conf.d/default.conf /etc/nginx/conf/default.conf
COPY --from=builder app/dist/angular8-crud-demo usr/share/nginx/html



