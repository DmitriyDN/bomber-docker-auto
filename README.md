## Manual

1. Install [docker](https://www.docker.com/products/docker-desktop)
2. For Linux/Mac give ability launch docker without sudo. [Good manual to install docker for linux ](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04).

```
    sudo usermod -aG docker ${USER}
    su - ${USER}
```

3. Install [nodeJS](https://nodejs.org/en/download/)
4. Launch docker
5. Set urls in ```urls.json``` file
6. Set ```containersLimit``` variable in retry.js
7. Set ```timeout``` variable in config.js. This sets timeout to check the list of websites and relaunch app
8. Run via command ```node ./retry.js``` in any cmd

## Troubleshouting
If you receive something like
```
stderr: /bin/sh: 12: /bombardier-one.sh: [[: not found
/bin/sh: 29: /bombardier-one.sh: 0: not found
/bin/sh: 36: /bombardier-one.sh: 0: not found
```

Most likely you use dash instead of bash and [[ ]] condition is unknown for it. You can set usage of bash via

```
    sudo dpkg-reconfigure dash
```