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
