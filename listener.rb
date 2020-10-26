# frozen_string_literal: true

require_relative 'window'
require_relative 'player'

require 'socket'
require 'json'
require 'gosu'

class Listener
  def self.listen(game, connection)
    port = connection[:connection_port]
    hostname = 'localhost' || connection[:connection_name]
    Thread.new do
      loop do
        player_update_socket = TCPSocket.open(hostname, port)
        player_movement = JSON.parse(player_update_socket.gets)
        other_player = game.other_player
        other_player.update_movement(player_movement)
        Thread.new do
          player_update_socket.puts(game.player.format)
        end
      end
    end
  end
end
