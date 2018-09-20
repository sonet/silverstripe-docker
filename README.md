

## Requirements

- [*Docker*](https://docs.docker.com/)

# How to use
 
Build the docker image first with:
```
cd php72
docker build -t sonet/silverstripe-web:7.2 .
```
Run the web server container mapping the project directory where the composer files and the
 public directory reside:
```
docker run -d -p 80:80 -v $PWD:/var/www:cached --name myapp sonet/silverstripe-web:7.2
```
To install or update packages via composer:
```
docker run -it --rm --workdir=/app -v $PWD:/app sonet/silverstripe-web:7.2 composer install
```

# License

View [license information](http://php.net/license/) for the software contained in this image.

# Credits

 - Franco Springveldt - [https://github.com/fspringveldt](https://github.com/fspringveldt)
 - Brett Tasker - [https://github.com/brettt89](https://github.com/brettt89)
