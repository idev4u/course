![CI](https://github.com/idev4u/course/workflows/CI/badge.svg?branch=master)

# Course

## What is Course
Hello! This is course a pairing board inspired by pair-up. At time I wrote course, [pairup](https://github.com/julz/pairup) wasn't open source, now it is.
My motivation to build course was to have a paring board for a team and practicing swift on the server.
After around 10 month I think it, I have a proper MVP so I can release it to the world.
I'm happy about everyone, who think this is useful and I accept any kind of feedback in the form of PR or Issues.

The name "course" btw. is used in the seafaring and defines the path of the current day. I think with the driver and navigator pattern this is good relation to the topic of pairing.

## pre

Course is a 12 factor app, so with this, it will fit into cloud foundry and or heroku and lots more. But there is one important dependency, a postgresql db is needed.

AND you need vapor tools on the mac
```sh
$brew install vapor
```

### Try it out?

Before you deploy it by your own, you wann try it out. No problem, I have deployed a demo version on heroku.
[course in action](https://course-pair.herokuapp.com)

## deplyoment

### Fork or clone

```sh
$ git clone git@github.com:idev4u/course.git
cd course
```

```sh
$vapor run
...
Running default command: .build/debug/Run serve
Server starting on http://localhost:8080
```

### On Heroku

```sh
$ heroku login
```

```sh
$ vapor heroku push
```

#### deployment init

##### pre 

you have already succesfully setuped a heroku account

#### init
first install the heroku cli tool from [here](https://devcenter.heroku.com/articles/heroku-cli)
then login to heroku with:

```sh
$ heroku login
```
then init the project with:
```sh
$ vapor heroku init
```
provide the custom buildpack https://github.com/vapor-community/heroku-buildpack.git

Create the following procfile in the root folder
```sh
$ echo "web: Run serve --env production --hostname 0.0.0.0 --port $PORT" > Procfile
```
#### config errors
hint: if you don't have a procfile, the app will not start. Watch out for the follwing line in the log file `Procfile declares types -> (none)`
```
Compile Swift Module 'Run' (1 sources)
Linking ./.build/x86_64-unknown-linux/release/Run
...
       Procfile declares types -> (none)
...
-----> Launching...
       Released v5
       https://course-pair.herokuapp.com/ deployed to Heroku
```

## knowledge
here I find very a good explanation about routing groups
https://www.hackingwithswift.com/articles/149/the-complete-guide-to-routing-with-vapor

how to show a image as base64 string, this is a hack to store the image in the database.
https://stackoverflow.com/questions/8499633/how-to-display-base64-images-in-html
Alternative stor the image in a blobstore and render the cdn path to the image. But I would like to store the image in the db for now.

## logo 

### font type
https://fonts.google.com/specimen/Pacifico?query=paci
