# Phase 1
# specifiy base image to install packages
FROM node:16-alpine as builder

# creating the work dir
WORKDIR '/app'

# copy package.json for instructions on installing packages
COPY package.json .

# install packages
RUN npm install

# since everything else (except the build) is going to be thrown away, I can just copy anything
COPY . . 

# create the build
RUN npm run build

# /app/build <- I only care about this

# Phase 2
FROM nginx as runner

# copy content: phase | srcDir | destDir
COPY --from=builder /app/build /usr/share/nginx/html
