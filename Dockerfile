# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
ARG BASE=/
COPY package.json yarn.lock ./
RUN yarn --prod
COPY . .
RUN yarn build --base $BASE
RUN sed s@src=\"\/@src=\"@g -i /app/dist/assets/index.*.js

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
RUN sed 's/#error_page  404/error_page  404/g' -i /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]