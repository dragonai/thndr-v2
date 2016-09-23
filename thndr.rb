require 'twilio-ruby'
require 'google_places'
require 'sinatra'
require 'dotenv'

Dotenv.load

post '/sms' do
	incoming = params[:Body]

	client = GooglePlaces::Client.new(ENV['PLACES_API_KEY'])
	best_place = client.spots_by_query(incoming, :types => ['restaurant', 'food', 'cafe'], :radius => 16000)[0]

	twiml = Twilio::TwiML::Response.new do |r|
		if best_place.nil?
			r.Message "Crap, Thndr wasn't able to locate something for you. Perhaps try a different search?"
		else
			r.Message "You're looking for #{best_place.name}. It's located at #{best_place.formatted_address}."
		end
	end

	content_type 'text/xml'
	twiml.text
end
