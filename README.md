## Manual

1. Install [docker](https://www.docker.com/products/docker-desktop)
2. Launch docker
3. Set urls in ```urls.json``` file
4. Set ```containersLimit``` variable in retry.js
4. Set ```timeout``` variable in config.js. This sets timeout to check the list of websites and relaunch app
5. Run via command ```node ./retry.js```