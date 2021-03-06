

## Requirements

- [*Docker*](https://docs.docker.com/)

# How to use
Let's start with the build of the docker image:
```
cd php74
docker build -t sonet/silverstripe-web:7.4 .
```

## Silverstripe
Run the web server container mapping the project directory where the composer files and the
 public directory reside:
```
docker run -it --rm --workdir=/app -v $PWD:/app sonet/silverstripe-web:7.4 composer create-project silverstripe/installer .
```
```
docker run -d -p 80:80 -v $PWD:/var/www/html:delegated --name ss4 sonet/silverstripe-web:7.4
```
```
docker run -it --rm --workdir=/app -v $PWD:/app sonet/silverstripe-web:7.4 composer install
```

## Laravel
Start a new Laravel project:
```
docker run -it --rm --workdir=/app -v $PWD:/app sonet/silverstripe-web:7.4 composer create-project --prefer-dist laravel/laravel .
```
```
docker run -d -p 80:80 -v $(PWD):/var/www/html:delegated --name laravel sonet/silverstripe-web:7.4
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
