require "bundler"
Bundler.require

require_relative "lib/player"
require_relative "lib/game"

player1 = Player.new("Josiane")
player2 = Player.new("José")

while player1.life_points > 0 && player2.life_points > 0
  puts "Voici l'etat de chaque joueur"
  player1.show_state
  player2.show_state

  print("\n")

  puts "Passons à la phase d'attaque"
  player1.attacks(player2)
  if player2.life_points <= 0
    break
  end
  player2.attacks(player1)
  if player1.life_points <= 0
    break
  end
  print "\n"
end
puts "-----------------------------------"
binding.pry
