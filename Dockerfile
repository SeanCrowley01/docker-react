FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# above line = we want to copy something from the builder phase, from /app/build into the html dir - this dir was 
# taken from dockerhub as the recommended place to store simple files

# default command of nginx image is to start nginx, so we dont have to do it