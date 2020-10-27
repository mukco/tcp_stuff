# frozen_string_literal: true

require_relative 'window'

require 'gosu'
require 'json'

class Player
  attr_accessor :x, :y, :vel_x, :vel_y, :score, :image, :angle, :x_range, :y_range

  def initialize
    @image = Gosu::Image.new('./player_avatar.png')
    @x = 50
    @y = 50
    @vel_x = @vel_y = @angle = 0
    @score = 0
  end

  def format
    %({"x": "#{x}","y": "#{y}","vel_y": "#{vel_y}","vel_x": "#{vel_x}","score": "#{score}", "angle": "#{angle}"})
  end

  def warp(xcor, ycor)
    @x = xcor
    @y = ycor
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu.offset_x(@angle, 0.5)
    @vel_y += Gosu.offset_y(@angle, 0.5)
  end

  def decelerate
    @vel_x -= Gosu.offset_x(@angle, 0.5)
    @vel_y -= Gosu.offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def update_movement(player)
    self.x = player['x'].to_i
    self.y = player['y'].to_i
    self.vel_y = player['vel_y'].to_i
    self.vel_x = player['vel_x'].to_i
    self.score = player['score'].to_i
    self.angle = player['angle'].to_i
    move
  end

  def position
    [x.round, y.round, vel_x.round, vel_y.round, angle.round, image.height, image.width]
  end

  def self.collision(player, other_player)
    return unless (player.position <=> other_player.position) != 1
    x_range = (other_player.x...other_player.image.width + other_player.x)
    y_range = (other_player.y...-other_player.image.height + other_player.y)
    p x_range, y_range
    x, y, vel_x, vel_y, angle, height, width = player.position
    op_x, op_y, op_vel_y, op_vel_x, op_angle, height, width = other_player.position
    if x_range.include?(x) || y_range.include?(y)
      player.vel_x = vel_x * -1
      player.vel_y = vel_y * -1
      other_player.vel_x = op_vel_x * -1
      other_player.vel_y = op_vel_y * -1
      other_player.move
      player.move
    end
  end
end
