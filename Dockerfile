# Use official nginx image as base
FROM nginx:latest

# Copy our HTML app into nginx default directory
COPY ./app /usr/share/nginx/html

# Expose port 80 for web access
EXPOSE 80

# Start nginx automatically
CMD ["nginx", "-g", "daemon off;"]
