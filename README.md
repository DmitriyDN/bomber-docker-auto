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
6. Виставити ліміт максимальної кількості докер контейнерів ```containersLimit``` у  ```start.sh```
7. Виставити ```timeout``` змінну у ```start.sh```. Це виставляє через скільки перевіряти статуси сайтів та каоібрувати імеджі в автоматичному режимі
8. Увімкнути ВПН
9. Запустити додаток за допомогою комани у терміналі ```sh ./start.sh```. Викликати з папки додатку.

### Для користувачів windows
Для віндоус треба встановити баш. Наприклад, [git bash має бути десь тут](https://git-scm.com/downloads). Сама аппка (команда 9) має ьути запущена саме з башу.

Якщо основний скріпт не працює, можна спробувати ручний запуск

```
sh ./bombardier-multi.sh 5
```

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
6. Set ```MAX_CONTAINERS``` variable in ```start.sh```
7. Set ```TIMEOUT``` variable in ```start.sh```. This sets timeout to check the list of websites and relaunch app
8. Turn on VPN
9. Run via command ```sh ./start.sh``` in any cmd

### For windows users
It is necessary to setup bash for windows. For instance, [git bash should be somewhere here](https://git-scm.com/downloads). And the app can be laucnehd from git bash. If main script doesn't work you can try launch attack manually

```
sh ./bombardier-multi.sh 5
```
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