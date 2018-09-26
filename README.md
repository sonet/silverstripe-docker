

## Requirements

- [*Docker*](https://docs.docker.com/)

# How to use
Build the docker image first:
```
cd php72
docker build -t sonet/silverstripe-web:7.2 .
```

## Silverstripe
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

## Database

### MySQL

MySQL Docker Containers: Understanding the basics https://severalnines.com/blog/mysql-docker-containers-understanding-basics  
```
docker run -d  -p 3333:3306 --name mysql --expose=3306 -e MYSQL_ROOT_PASSWORD=pass1234 -P mariadb:latest
```
### PostgreSQL

Spin up the database container:
```
docker run --name psql -e POSTGRES_PASSWORD=pass1234 -d -p 5555:5432 postgres:latest
```
To connect to the database the container's IP Address. The `dip` bash alias along with all the other aliases might save some keystrokes unless a gui is being used like [Kinematic](https://kitematic.com/).

# License

View [license information](http://php.net/license/) for the software contained in this image.

# Credits

 - Franco Springveldt - [https://github.com/fspringveldt](https://github.com/fspringveldt)
 - Brett Tasker - [https://github.com/brettt89](https://github.com/brettt89)
