

## Requirements

- [*Docker*](https://docs.docker.com/)

# How to use
Build the docker image first:
```
cd php72
docker build -t sonet/silverstripe-web:7.2 .
```

## Laravel
Run the web server container mapping the project directory where the composer files and the
 public directory reside:
```
docker run -it --rm --workdir=/app -v $PWD:/app sonet/silverstripe-web:7.2 composer create-project silverstripe/installer .
```
```
docker run -d -p 80:80 -v $PWD:/var/www/html:cached --name ss4 sonet/silverstripe-web:7.2
```
```
docker run -it --rm --workdir=/app -v $PWD:/app sonet/silverstripe-web:7.2 composer install
```

## Laravel
Start a new Laravel project:
```
docker run -it --rm --workdir=/app -v $PWD:/app sonet/silverstripe-web:7.2 composer create-project --prefer-dist laravel/laravel .
```
```
docker run -d -p 80:80 -v $(PWD):/var/www/html:cached --name laravel sonet/silverstripe-web:7.2
```

# License

View [license information](http://php.net/license/) for the software contained in this image.

# Credits

 - Franco Springveldt - [https://github.com/fspringveldt](https://github.com/fspringveldt)
 - Brett Tasker - [https://github.com/brettt89](https://github.com/brettt89)
