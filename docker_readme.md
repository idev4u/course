# Docker Image

## pre
A postgreSQL db is running and reachable from within the contianer. I use postgresapp for example. 
https://postgresapp.com/documentation/

## local build

```sh
version=0.0.6; docker build -t normansutorius/course:$version -f web.Dockerfile .
```

## run it local

After you have build the image you can run course.
```sh
export DATABASE_URL=postgres://$(whoami)@host.docker.internal/postgres
version=0.0.6; docker run -it --network="host" -e DATABASE_URL normansutorius/course:$version
```

## publish to dockerhub
```sh
docker push normansutorius/course
```

## debug 

If something  went wrong with the database string for example you can overwrite the start command like this 
```sh
version=0.0.6; docker run --entrypoint "/bin/bash" -it --network="host" -e DATABASE_URL normansutorius/course:$version
```
And you are able to debug if all the envs variables are set with the right values. 
### hints

how to deal with docker envs
https://vsupalov.com/docker-build-pass-environment-variables/
