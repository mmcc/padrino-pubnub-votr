Votr
===
A real time voting example made using [PubNub](http://www.pubnub.com) and [Padrino](http://www.padrinorb.com). If you're interested in how this application was made, there's a [writeup](http://blog.htbx.net/blog/2012/10/04/real-time-voting-with-pubnub/). 

About
----
This is a pretty simple little app built primarily to demonstrate PubNub and Padrino. As such, the admin interface is simplistic at best, and there are many aspects that aren't realistic in a production application.

For instance, there is a limit of 10 votes per round that exists purely on the client side. If a user refreshes their browser window, that count refreshes, but the main goal was to allow people to be able to play with the live vote tabulation but restrict them from inundating the system with hundreds of votes in a few minutes. A UUID is sent along with the vote, which could be used to more effectively restrict the number of votes allowed based on that ID.

Install
----
Clone the repository and install dependencies.

    $ git clone git://github.com/sh1ps/padrino-pubnub-votr.git
	$ cd padrino-pubnub-votr
	$ bundle install

Set up the database and admin account.

	$ padrino rake ar:create
	$ padrino rake ar:migrate
	$ padrino rake seed
	
Start everything up with `padrino start` and you should be up and running!

Setup
----

In order to use the admin interface, first create an initial admin. Use the command `padrino rake ar:seed` and log in using the credentials you set in `db/seeds.rb`. For now you must first create a round, then add songs to that round by adding new songs and using the ID of the round you just created. This will become a one page process shortly.