# Dockerfile for Coffee Platform
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --configuration=production


# Servir con Nginx
FROM nginx:alpine
COPY --from=build /app/dist/coffee-platform /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
