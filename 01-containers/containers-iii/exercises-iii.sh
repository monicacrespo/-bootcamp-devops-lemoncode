#Exercises: 
cd containers-iii
# 1. Dockerize the application within hello-lemoncoder folder using Visual Studio Code

#Before it is recommended to verify the application works ok
cd hello-lemoncoder
npm install
npm start

#Once verified, use Comand + P (Mac) or Control + P (Windows) and search the following:
# > Add Docker Files to Workspace > Node.js > select the package.json from the list and 3000 port
# This should generate the Dockerfile within hello-lemoncoder
# Or selecting the Dockerfile file with right click and clic on Build Image...

# 2. Run a container with you new image using Visual Studio Code


