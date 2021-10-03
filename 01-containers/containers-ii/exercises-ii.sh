#.
#├── /home/vagrant/
#│   ├── Dockerfile
#│   ├── Vagrantfile
#│   └── public-html
#│       └── index.html
# 1. Create an Apache web server image using Dockerfile that serves the static content from content folder
docker build . -t simple-apache:new
# 2. Run the new image inside of a container
docker run -d --name myapache -p 5050:80 simple-apache:new
# Access web server on VirtualBox/Vagrant machine from host browser
# http://192.168.50.4:5050/
# 3. Find out how many layers has the new image
docker inspect simple-apache:new 
# Count in "Layers" section. There are six layers 
docker history simple-apache:new # All actions < 0B are layers
dive simple-apache:new # Show all layers of a image
# Ubuntu/Debian
# wget https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb
# sudo apt install ./dive_0.9.2_linux_amd64.deb
# Windows
# Download the latest release, dive_0.9.2_windows_amd64
#├── dive_0.9.2_windows_amd64
#│   ├── dive.exe
#│   ├── README.md
#│   ├── LICENSE
