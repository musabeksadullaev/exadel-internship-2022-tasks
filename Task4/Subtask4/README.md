# Task 4 (Docker)

## Task 4 (Mandatory)

### :memo: Task details
Summary:
- To push to and pull from Docker Hub need to [register](https://hub.docker.com/signup) in Docker Hub
- Need to [create repository](https://docs.docker.com/docker-hub/#step-2-create-your-first-repository)
- After registering need to:
  - ```docker login```  # Login from Docker CLI (Username and password will be prompted)
  - ```docker image tag <REPO_NAME> <DOCKERHUB_USERNAME>/<REPO_NAME>```  # Tag/rename image to make it pushable to registry
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

### :memo: Pipeline to build image on push
> Pipeline can be found [here](https://github.com/musabeksadullaev/exadel-internship-2022-tasks/blob/master/.github/workflows/task-4-subtask-4-1.yml)
