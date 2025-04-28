# Use the official Nginx image as the base image
FROM nginx:alpine

COPY blog/html /usr/share/nginx/html

EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
