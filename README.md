## Інструкція
1. Встановити докер [docker](https://www.docker.com/products/docker-desktop)
2. Для Лінукса/Mac виставити можливість запуску без sudo. [Ось гарний мануал як ставити докер і прибрати суда](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04)
```
    sudo usermod -aG docker ${USER}
    su - ${USER}
```
3. Встановити [nodeJS](https://nodejs.org/en/download/)
4. Запустити докер
5. Виставити адреси для атаки у файлі ```urls.json```
6. Виставити ліміт максимальної кількості докер контейнерів ```containersLimit``` у  ```retry.js```
7. Виставити ```timeout``` змінну у ```config.js```. Це виставляє через скільки перевіряти статуси сайтів та каоібрувати імеджі в автоматичному режимі
8. Увімкнути ВПН
9. Запустити додаток за допомогою комани у терміналі ```node ./retry.js```. Викликати з папки додатку.

Для віндоуса треба встановити bash.

## Можливі помилки
Якщо Ви бачите наступне
```
stderr: /bin/sh: 12: /bombardier-one.sh: [[: not found
/bin/sh: 29: /bombardier-one.sh: 0: not found
/bin/sh: 36: /bombardier-one.sh: 0: not found
```

Скоріше за все у вас використовужться dash замість bash і [[ ]]умова з даш не працює. Можна виставити використання баша і має запрацювати

```
    sudo dpkg-reconfigure dash
```
________________________________________________________________________________________________________________________________
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
8. Turn on VPN
9. Run via command ```node ./retry.js``` in any cmd

It is necessary to setup bash for windows.
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