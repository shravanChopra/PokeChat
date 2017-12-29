# PokeChat

Ever wanted to be a Pokemon? PokeChat is an app that allows each user to sign up as their favorite pokemon and send messages to all 
pokemon in the outside world! If you were looking to get into the Pokemon universe, look no further. This is it!

PokeChat is a group chat app, somewhat inspired by Slack. This initial prototype enables group communication on a default channel, which is
literally every user that signed up. The app is able to sign up new users via an email/password combination, as well as authenticate and log in
registered users.

Once logged in, users are taken to the Messages screen, where the entire chat history is automatically retrieved and displayed in
a manner that distinguishes between messages sent by the user from those sent by all others. The app also successfully updates the
chat history with each new message that the user composes.

This project was developed in Swift 4 (XCode 9), using Google Firebase as a backend (the specific features were Authentication and
Realtime database modules). Future versions will hopefully include the ability to create custom channels, as well as one-on-one 
communication.
