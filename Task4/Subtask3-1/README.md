# Task 4 (Docker)

## Task 3.1 (Mandatory + Extra)

### Task details

:memo: Summary:
- Used [nginx](https://hub.docker.com/_/nginx) as webserver and [Alpine Linux](https://hub.docker.com/_/alpine) as base OS

Contents of Dockerfile:
``` Dockerfile
FROM alpine:3.16.0  # Use alpine as base image

RUN apk add --update nginx  # Install nginx webserver
```

Build command:
``` bash
docker build -t task-4-subtask-3-1 .
```

Create new container from `task-4-subtask-3-1` image and run it:
- detached (run in background and don't block prompt/TTY) (`-d`)
- binded **local port 1000** to **container port 80** (`-p 1000:80`)
- **auto-deleting** after container stopped (`--rm`)
- named `task-4-subtask-3-1` (`--name task-4-subtask-3-1`)
``` bash
docker run -d -p 1000:80 --rm --name task-4-subtask-3-1 task-4-subtask-3-1
```

Check if webserver working:
``` bash
curl localhost:1000
```
