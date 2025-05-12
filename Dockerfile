# Use a base Nginx image
FROM nginx:latest

# Remove the default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom Nginx configuration into the container
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/conf.d/ /etc/nginx/conf.d/
# We are mounting the 'live' directory which contains symlinks
COPY /etc/letsencrypt/live/jyllandteodosio.dev /etc/nginx/ssl

# Expose port 80 (optional, often done in docker-compose)
EXPOSE 80 443

# Command to run Nginx (default for the base image)
CMD ["nginx", "-g", "daemon off;"]