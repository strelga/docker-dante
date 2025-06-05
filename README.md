# docker-dante

Simple socks user management on top of [wernight/docker-dante](https://github.com/wernight/docker-dante).

## Setup

Prerequisites:

- git
- make
- docker
- docker-compose

```bash
git clone https://github.com/strelga/docker-dante.git
cd ./docker-dante
```

## Usage

### Start service

```bash
make run-docker
```

Service will start at port 1080.

### Create user

```bash
USERNAME=your-awesome-user make create-user
```

### Remove user

```bash
USERNAME=your-awesome-user make remove-user
```
