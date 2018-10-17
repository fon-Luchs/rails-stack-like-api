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
     -d 'session[email]=john@mcclane.com&session[password]=123456' \
      localhost:3000/session
```

### Show Profile

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/profile
```

### Update Profile

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

### Show User

```
curl -H 'Accept: application/json' \
     -H 'Authorization: Token token="XXXX-YYYY-ZZZZ"' \
      localhost:3000/users/:id

```

### Show Users

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
     -H 'Authorization: Token token="MBbPPBUW6CREp5dejuTqFjqY"' \
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

