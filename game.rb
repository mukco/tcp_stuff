# frozen_string_literal: true

require_relative 'connector'
require_relative 'listener'
require 'gosu'

main_game = MyWindow.new
main_game.show
p main_game.player.position
# connection = Connector.connect(main_game, 2000)
# p connection
