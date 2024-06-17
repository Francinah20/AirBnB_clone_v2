#!/usr/bin/env bash
# Script that sets up your web servers for the deployment of web_static

# Install Nginx if it is not already installed
if ! which nginx > /dev/null; then
    sudo apt-get update
    sudo apt-get install -y nginx
fi

# Create the folder /data/ if it doesn't already exist
sudo mkdir -p /data/

# Create the folder /data/web_static/ if it doesn't already exist
sudo mkdir -p /data/web_static/

# Create the folder /data/web_static/releases/ if it doesn't already exist
sudo mkdir -p /data/web_static/releases/

# Create the folder /data/web_static/shared/ if it doesn't already exist
sudo mkdir -p /data/web_static/shared/

# Create the folder /data/web_static/releases/test/ if it doesn't already exist
sudo mkdir -p /data/web_static/releases/test/

# Create a fake HTML file /data/web_static/releases/test/index.html
echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# Create a symbolic link /data/web_static/current linked to the /data/web_static/releases/test/ folder
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Give ownership of the /data/ folder to the ubuntu user AND group
sudo chown -R ubuntu:ubuntu /data/

# Update the Nginx configuration to serve the content of /data/web_static/current/ to hbnb_static
sudo sed -i '/^\tserver_name _;/a \\n\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

# Restart Nginx after updating the configuration
sudo service nginx restart

exit 0

