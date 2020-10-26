# frozen_string_literal: true

require_relative 'window'
require_relative 'player'

require 'socket'
require 'json'

class Connector
  def self.connect(game, port)
    server = TCPServer.open(port)
    port = server.addr[1].to_i
    hostname = server.addr(true)[3]
    Thread.new do
      loop do
        client = server.accept
        client.puts(game.player.format)
        Thread.new do
          player_movement = JSON.parse(client.gets)
          other_player = game.other_player
          other_player.update_movement(player_movement)
        end
      end
    end
    { connection_name: hostname, connection_port: port }
  end
end
