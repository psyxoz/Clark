# Clark API

Dependencies:
- docker
- docker-compose

### Initial Setup
Install [Docker](https://www.docker.com) and dependencies:
```
brew install docker docker-compose
```

### Run app
```
$ docker-compose up --build web
```

### Run tests
```
$ docker-compose run --rm spec rake db:create db:migrate
$ docker-compose run --rm spec
```

The app is currently mapped to `0.0.0.0:3000`