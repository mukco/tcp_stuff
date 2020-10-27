# frozen_string_literal: true

require_relative 'player'

require 'gosu'
require 'json'

class MyWindow < Gosu::Window
  attr_accessor :players, :player, :other_player

  def initialize
    super 600, 600
    self.caption = 'Hello World'
    @background_image = Gosu::Image.new('./starback.png')

    @song = Gosu::Song.new('./videogamebeatsample.mp3')
    # @song.play(true)

    @other_player = Player.new
    @other_player.x = 200
    @other_player.y = 200

    @player = Player.new

    @players = []
    @players << @player << @other_player
  end

  def draw
    @background_image.draw(0, 0, 0, 1, 1)
    @players.each(&:draw)
  end

  def update
    @player.turn_left if button_down?(Gosu::KbLeft) || button_down?(Gosu::GpLeft)

    @player.turn_right if button_down?(Gosu::KbRight) || button_down?(Gosu::GpRight)

    @player.accelerate if button_down?(Gosu::KbUp) || button_down?(Gosu::GpButton0)

    @player.move

    p @other_player.position, @player.position
    Player.collision(@player, @other_player)
  end
end
