# frozen_string_literal: true

require 'json'
x = 5
y = 4
vel_y = 3
vel_x = 2
score = 1
player = %({
    "x": "#{x}",
    "y": "#{y}",
    "vel_y": "#{vel_y}",
    "vel_x": "#{vel_x}",
    "score": "#{score}"
  })
p player
p JSON.parse(player)
