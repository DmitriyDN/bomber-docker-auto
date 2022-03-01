## Manual

1. Install [docker](https://www.docker.com/products/docker-desktop)
2. Install [nodeJS](https://nodejs.org/en/download/)
3. Launch docker
4. Set urls in ```urls.json``` file
5. Set ```containersLimit``` variable in retry.js
6. Set ```timeout``` variable in config.js. This sets timeout to check the list of websites and relaunch app
7. Run via command ```node ./retry.js```