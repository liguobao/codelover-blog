FROM node:latest AS build-env
RUN mkdir -p /usr/src/codelover-blog
WORKDIR /usr/src/codelover-blog
COPY . .
RUN npm --registry=https://registry.npm.taobao.org install install hexo-cli -g && npm install && hexo g

FROM nginx:latest
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
WORKDIR /usr/share/nginx/html
COPY --from=build-env /usr/src/codelover-blog/public /usr/share/nginx/html
EXPOSE 80
