current_energy = 0
current_karma = 0

SCHEDULER.every '2s' do
  last_energy = current_energy
  last_karma     = current_karma
  current_energy = rand(9..12)
  current_karma     = rand(200000)

  # send_event('valuation', { current: current_valuation, last: last_valuation })
  # send_event('karma', { current: current_karma, last: last_karma })

  send_event('voltage1',   { value: rand(100..115) })
  send_event('amp1',   { value: rand(400..600) })
  send_event('energy1',   { current: current_energy, last: last_energy })
  # send_event('energy1',   { current: 43, last: 43 })
  send_event('reactive_power1', { current: 43, last: 43 })
end

# Populate the graph with some random points
points = []
(1..10).each do |i|
  points << { x: i, y: rand(30..50) }
end
last_x = points.last[:x]

SCHEDULER.every '2s' do
  points.shift
  last_x += 1
  points << { x: last_x, y: rand(30..50) }

  send_event('power1', points: points)
end

# ###################
# require 'json'
#
# `curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "current": 43, "last": 43 }' \http://dashboard.hi178.tw/widgets/reactive_power1`
#
# points = []
# (1..10).each do |i|
#   points << { x: i, y: rand(30..50) }
# end
# last_x = points.last[:x]
#
# current_energy = 0
# loop do
#   sleep 2
#   last_energy = current_energy
#   current_energy = rand(9..12)
#   `curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "value": #{rand(100..115)} }' \http://dashboard.hi178.tw/widgets/voltage1`
#   `curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "value": #{rand(400..600)} }' \http://dashboard.hi178.tw/widgets/amp1`
#   `curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "current": #{current_energy}, "last": #{last_energy} }' \http://dashboard.hi178.tw/widgets/energy1`
#
#   points.shift
#   last_x += 1
#   points << { x: last_x, y: rand(30..50) }
#   `curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "points": #{JSON.generate(points)} }' \http://dashboard.hi178.tw/widgets/power1`
# end
