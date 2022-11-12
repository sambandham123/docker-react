# Specify a base image
FROM node:16-alpine as builder

#set the directory
WORKDIR /usr/app

# copy the package.jsoncontents
COPY ./package.json ./

# Install some depenendencies
RUN npm install

# copy all the contents..
COPY ./ ./

# run the build command 
RUN npm run build

# specify nginx image
FROM nginx

# Expose the port so elastic beanstalk knows
EXPOSE 80

# copy the content of build. 

# npm run build will create a build folder in the WORKDIR
COPY --from=builder /usr/app/build /usr/share/nginx/html
