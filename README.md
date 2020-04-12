![CI](https://github.com/idev4u/course/workflows/CI/badge.svg?branch=master)

# Course

hello this is course a pairing borad inspired by pairup. At time I wrote course pair up wasn't  open source.
But course will be.

## pre

course is a 12 factor app, so with it will be fit intop cloud foundry heroku and lots more. But there is one important dependency, a postgresql is needed.

## deplyoment
On Heroku

```
heroku login
```
```
vapor heroku push
```

### deployment init

#### pre 

you have already succesfully setuped a heruko account

#### init
first install the heroku cli tool from [here](https://devcenter.heroku.com/articles/heroku-cli)
then login to heroku with:

```
heroku login
```
then init the project with:
```
vapor heroku init
```
provide the custom buildpack https://github.com/vapor-community/heroku-buildpack.git

Create the following procfile in the root folder
```
echo "web: Run serve --env production --hostname 0.0.0.0 --port $PORT" > Procfile
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
