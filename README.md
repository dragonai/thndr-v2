---

This repository is intended for use at my "Welcome to Hackathons" talk at [HackGT 2016](https://hackgt.com). The instructions in this readme are purely for setup - I'll be explaining each step of the process in full detail during the actual talk.

In September of 2013, I attended my very first hackathon, MHacks II. I knew nothing about hackathons or hacking, and didn't have the slightest clue about where to begin building a project. 36 hours later, however, I managed to complete my first-ever hack. That weekend kickstarted my career as an enthusiastic hacker, builder, and software engineer - now, three years later on the dot, I'd like to share that experience with everyone who's getting their feet wet for the first time. In this talk, I'll be introducing brand-new hackers to the world of hackathons and then guiding them through building their very first hack, which also happens to be [my very first hack, Thndr](https://github.com/dragonai/thndr) (but this time, with way cleaner code).

---
##THNDR (v2) - "Welcome to Hackathons" Edition

####Thndr is an SMS-based spontaneous food discovery service.

######Instructions:

0.) Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) if you don't already have it

1.) Download and install [Ruby](https://www.ruby-lang.org)

2.) Download and unzip [Ngrok](https://ngrok.com/) somewhere (Ngrok is a tool to allow outside access to a server you're running on your computer)

3.) Install the necessary Ruby gems on your system - we'll be using `twilio-ruby`, `google_places`, `sinatra`, and `dotenv`, so run this on the command line to snag all of them at once:

```
gem install twilio-ruby google_places sinatra dotenv
```

4.) Sign up for [Twilio](https://twilio.com) and get a free trial phone number

5.) Go to the [Google API Console](https://code.google.com/apis/console), search for "Google Places API Web Service", follow the process to create a new project and enable the API for it, and then create credentials for yourself. Select the API key option and you'll be presented with a key - hang onto that, you'll need it!

6.) Clone (a.k.a. download) this GitHub repository by running the following on your command line:

```
git clone https://github.com/dragonai/thndr-v2.git
```

7.) Open your favorite text editor and create a new file with just the following line in it, replacing `yourkeygoesrighthere` with the API key you received in step 5:

```
PLACES_API_KEY=yourkeygoesrighthere
```

8.) Save this file inside the new `thndr-v2` directory with the filename `.env`. Yes, the filename should be just the four characters: dot, e, n, v.

9.) On the command line, navigate into the `thndr-v2` directory and type the following to start Thndr, in the form of a local Sinatra server on your machine:

```
ruby thndr.rb
```

You should see then something like this:

```
== Sinatra (v1.4.7) has taken the stage on 4567 for development with backup from Puma
```

Leave this command line window running.

10.) In a new command line window, navigate to wherever you unzipped Ngrok in step 2, and run it with this command (notice we're using the same port number above):

```
./ngrok http 4567
```

You should now see something like this a few lines down:

```
Forwarding http://8d1d7720.ngrok.io -> localhost:4567   
```

Copy that `http://*.ngrok.io` URL. Almost there!

11.) Back in Twilio's console, in Phone Numbers -> Manage Numbers -> Active Numbers -> your phone number, scroll down to the Messaging section. There, change the "A Message Comes In" dropdown from "TwiML" to "Webhook", and then paste the URL with a `/sms` appended to the end, like `http://8d1d7720.ngrok.io/sms`. Make sure the dropdown after that says "HTTP POST". Hit Save and you're done!

_(Note: you will be given a new URL every time you start Ngrok, so step 11 will have to be repeated every time as long as you're running Thndr locally. To keep Thndr permanently running, you can deploy it on services such as Heroku, DigitalOcean, et cetera, but that's beyond the scope of this talk.)_

12.) Send a text to your Twilio phone number with something like "Best doughnuts in Atlanta". If you completed these instructions properly, in a few seconds you'll receive a text back that reads something like this:

```
Sent from your Twilio trial account - You're looking for Sublime Doughnuts.
It's located at 535 10th St NW, Atlanta, GA 30318, United States.
```

Congrats! You've created your very own food finding engine. Please feel free to modify the crap out of this code!