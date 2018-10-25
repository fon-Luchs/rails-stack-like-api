# Rails Stack Like API - Sample Application

## Install

### Clone repository

```
git clone https://github.com/fon-Luchs/rails-stack-like-api.git
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
     -d 'session[email]=john@mcclane.com&session[password]=123456' \
      localhost:3000/session
```

### Profile Show

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/profile
```

### Profile Update

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'user[first_name]=Jarry&user[last_name]=Smith' \
     -X PUT localhost:3000/profile

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'user[first_name]=John& \
     -X PATCH localhost:3000/profile
```

### User Show

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/users/:id

```

### User Index

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/users/
```

### Question Create

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'question[title]=Who knows?&question[body]=You never know that' \
      localhost:3000/questions
```

### Question Show

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYYY-ZZZZZ"' \
      localhost:3000/questions/:id

```

### Question Update

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'question[title]=How would your country change if everyone, regardless of age, could vote?' \
     -d 'question[body]=You never know, you never know...' \
     -X PUT localhost:3000/questions/:id

```

### Question Index

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/questions?title=title'&'body=body!
```

### Answer Create

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'answer[body]=You never know that' \
      localhost:3000/questions/:id/answers

```

### Answer Index

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/questions/:id/answers

```

### Rate Answer create

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'rate[kind]=positibe' \
      localhost:3000/answers/:id/rate

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'rate[kind]=negative' \
      localhost:3000/answers/:id/rate
```

### Rate Question create

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'rate[kind]=positibe' \
      localhost:3000/questions/:id/rate

curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
     -d 'rate[kind]=negative' \
      localhost:3000/questions/:id/rate
```
