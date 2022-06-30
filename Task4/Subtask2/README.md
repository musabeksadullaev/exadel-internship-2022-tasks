# Task 4 (Docker)

## Task 2 (Mandatory)

### Task details

:memo: Summary:
- Used hello-world docker image from Docker Hub (https://hub.docker.com)

``` bash
docker run hello-world
```

## Task 2 (Extra)

### Task details

:memo: Summary:

There's contents of ...

... Dockerfile:
``` Dockerfile
FROM nginx:1.22.0-alpine

COPY ./info.html /usr/share/nginx/html/info.html
```

... info.html:
``` html
<p>musabeksadullaev 2022</p>
```
