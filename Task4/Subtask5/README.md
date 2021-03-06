# Task 4 (Docker)

## Task 5 (Mandatory)

### :memo: Task details

Summary:
- To build source code and package it to single file run command `mvn install -DskipTests` (Java 8 and Maven should be installed)
- Maven will write output to `target/blog-api-docker.jar`
- Docker will use OpenJDK (version 8, Ubuntu-based) to run compiled and built `blog-api-docker.jar` file
- Built image will be pushed to Docker Hub:
  - `docker login`  (**# Username and password will be prompted**)
  - `docker build -t musabeksadullaev/exadel-internship-task-4-5 .`
  - `docker push musabeksadullaev/exadel-internship-task-4-5`
- Run compose file with `docker-compose up -d` command
- Create new post with next command:
  - `curl -d '{"title": "Test Post", "post": "This POST request creates a Post"}' -H 'Content-Type: application/json' http://localhost:8080/posts`
- Get all posts with command:
  - `curl localhost:8080/posts`


<!-- 
### :memo: Task details
Summary:
- To push to and pull from Docker Hub need to [register](https://hub.docker.com/signup) in Docker Hub
- Need to [create repository](https://docs.docker.com/docker-hub/#step-2-create-your-first-repository)
- After registering need to:
  - ```docker login -u <LOGIN/USERNAME> -p <PASSWORD>```  # login from Docker CLI
  - ```docker image tag <REPO_NAME> <DOCKERHUB_USERNAME>/<REPO_NAME>```  # tag/rename image
  - ```docker image push <DOCKERHUB_USERNAME>/<REPO_NAME>```  # Push (upload) image to Docker Hub
  - ```docker image pull <DOCKERHUB_USERNAME>/<REPO_NAME>```  # Pull (download) image from Docker Hub
- More information you can find [here](https://docs.docker.com/docker-hub/)

Created `Dockerfile` with next content:
``` Dockerfile
FROM nginx:1.22.0-alpine

ENV DEVOPS musabeksadullaev

COPY ./info.html /usr/share/nginx/html/info.html

COPY ./generate.sh /app/generate.sh

CMD ["/bin/sh", "-c", "/app/generate.sh && nginx -g 'daemon off;'"]
```

Created `generate.sh` with next content:
``` bash
#!/bin/sh

sed -i "s/ENV_VAR/$DEVOPS/" /usr/share/nginx/html/info.html
```

Created `info.html` with next content:
``` html
<p>ENV_VAR</p>
```

### :arrow_forward: Commands to run image

Build image from Dockerfile
``` bash
docker build -t task-4-subtask-3-2 .
```

Run built image (**no variable**)
``` bash
docker run -d -p 1000:80 --name task-4-subtask-3-2 task-4-subtask-3-2
```

Get page with variable
``` bash
curl localhost:1000/info.html
```

After running command above you will get response something like this:
`<p>musabeksadullaev</p>`

------

Run built image (**with variable**)
``` bash
docker run -d -p 1000:80 --name task-4-subtask-3-2 --env DEVOPS=1qaz2wsx task-4-subtask-3-2
```

Get page with variable
``` bash
curl localhost:1000/info.html
```

After running command above you will get response something like this:
`<p>1qaz2wsx</p>`


## Task 4 (Extra)
 -->
