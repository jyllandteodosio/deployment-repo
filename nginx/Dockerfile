# Use a base Nginx image
FROM nginx:alpine

# Remove the default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom Nginx configuration into the container
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./conf.d/ /etc/nginx/conf.d/

# Expose port 80 (optional, often done in docker-compose)
EXPOSE 80 443

# Command to run Nginx (default for the base image)
CMD ["nginx", "-g", "daemon off;"]