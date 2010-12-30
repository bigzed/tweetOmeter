#!/usr/bin/env ruby
#This script was written by Steve Dierker on 27C3 and
#stands under the GPL v3.0.
#http://www.gnu.org/licenses/gpl.html

require 'twitter'

HASHTAG = "27c3"

  search = Twitter::Search.new
  startid = 20192516867358720

if File.exists?("id.store")
  id_store = File.new("id.store","r")
  startid = id_store.readline.to_i
end
starttime = Twitter::Search.new.hashtag(HASHTAG).max(startid).fetch.first.created_at

current_page = search.hashtag(HASHTAG).since_id(startid).per_page(100).fetch
next_id = current_page.first.id

counter = current_page.count

while search.next_page?() do
  current_page = search.fetch_next_page
  counter += current_page.count
end
quotient = (counter / (Time.now - Time.parse(starttime)))*60*60
index = File.new("html/index.html", "w")
index.write "#{quotient.truncate}"

id_store = File.new("id.store","w")
id_store.write "#{next_id}"
