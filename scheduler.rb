#!/usr/bin/env ruby
require 'openwfe/util/scheduler'
include OpenWFE

scheduler = Scheduler.new
scheduler.start
scheduler.schedule_every('30s') { system("ruby tweets_per_hour.rb") }
scheduler.join

