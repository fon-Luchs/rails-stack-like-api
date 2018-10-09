# Rails Stack Like API - Sample Application

## Install

### Clone repository

```
git clone https://github.com/Alexbaboshyn/rails-stack-like-api
```

### Install gems

```
gem install bundler
```

```
bundle install
```

### Create databases

```
rake db:create
```

### Run migrations

```
rake db:migrate
```

### Run specs

```
rake
```

### Run server

```
rails s
```

### Sign Up

```
curl -H 'Accept: application/json' \
          -d 'user[email]=john@mcclane.com&user[password]=123456&user[password_confirmation]=123456' \
          -d 'user[first_name]=Ibrahim&user[last_name]=Nurglit' \
          localhost:3000/profile

```

### Sign In

```
curl -H 'Accept: application/json' \
     -d 'session[email]=john@mcclane.com&session[password]=superhero' \
     localhost:3000/session
```

### Show Profile

```
  curl -H 'Accept: application/json' \
       -H 'Authorization: Token token="oi6iweKhZy8ijZxLradjQZJu"' \
            localhost:3000/profile
```

### Create Question

```
  curl -H 'Accept: application/json' \
       -H 'Authorization: Token token="oi6iweKhZy8ijZxLradjQZJu"' \
       -d 'question[title]=Winter is Coming?&question[body]=Dead is ready' \
       localhost:3000/questions
```

### Show Question

```
 curl -H 'Accept: application/json' \
      -H 'Authorization: Token token="oi6iweKhZy8ijZxLradjQZJu"' \
      localhost:3000/profile

```

### Create Answer

```
 curl -H 'Accept: application/json' \
      -H 'Authorization: Token token="oi6iweKhZy8ijZxLradjQZJu"' \
      -d 'answer[body]=Nu takoe' \
      localhost:3000/questions/1/answers

```
