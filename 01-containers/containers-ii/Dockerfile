# Apache web server image that I will use as the starting point
FROM httpd:2.4

# Use the LABEL instruction in a Dockerfile to define image metadata. 
# Labels are similar to environment variables in that they are key value pairs attached to an image or a container. 
# Labels are different from environment variable in that they are not visible to the running application and
# they can also be used for fast look-up of images and containers.
LABEL maintainer="moni.crespo@gmail.com"
LABEL project="lemoncode"

# Metadata to signal that the container uses the port 80
# EXPOSE is often used as a documentation mechanism -- that is, just to signal to the user what port will be providing services
EXPOSE 80

# Updates on the image used as the starting point.
# Copy over the content, which is our HTML and CSS pages, into Apache’s docroot which is /usr/local/apache2/htdocs/
COPY content/ /usr/local/apache2/htdocs/