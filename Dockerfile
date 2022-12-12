# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
ARG BASE=/
COPY package.json yarn.lock ./
RUN yarn --prod
COPY . .
RUN yarn build --base $BASE
RUN sed s@src=\"\/@src=\"@g -i /app/dist/assets/index.*.js
RUN sed s@src=\"\/@src=\"@g -i /app/dist/index.html
RUN sed s@href=\"\/@href=\"@g -i /app/dist/index.html

# production stage
FROM nginx:stable-alpine as production-stage
ARG BASE=/
COPY --from=build-stage /app/dist /usr/share/nginx/html
RUN echo -e "server {\n\
    listen 80;\n\
    server_name localhost;\n\
\n\
    location / {\n\
        root /usr/share/nginx/html;\n\
        index index.html index.htm;\n\
    }\n\
\n\
    location /-/readiness {\n\
        return 200 'slidev $BASE is health';\n\
    }\n\
\n\
    error_page 404 /404.html;\n\
}" > /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]