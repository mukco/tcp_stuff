# frozen_string_literal: true

require_relative 'connector'
require_relative 'listener'
require 'gosu'

main_game = MyWindow.new
connection = Connector.connect(main_game, 2000)
p connection

peer_game = MyWindow.new
Listener.listen(peer_game, connection)

peer_game_thread = Thread.new do
  peer_game.show
end

main_game.show

peer_game_thread.join
