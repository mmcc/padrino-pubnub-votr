Votr
===
A real time voting example made using [PubNub](http://www.pubnub.com) and [Padrino](http://www.padrinorb.com).

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
The admin interface still needs serious work, so I personally use the console (started us). Doing it that way, the process of setting up rounds and associated songs for the first time looks something like this:

	$ padrino c
	> round = Round.new
	> round.start_time = DateTime.now
	> round.end_time = DateTime.now + 3.hours
	> round.save!
	> song = Song.new
	> song.title = "Call Me Maybe"
	> song.artist = "Carly Rae Jepson"
	> song.round_id = round.id
	> song.save!

If you'd rather use the web interface, it's located at `/admin` and use the username and password you set up in when you ran `padrino rake ar:seed` which is contained in `db/seeds.rb`.
