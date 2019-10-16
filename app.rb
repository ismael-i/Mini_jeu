require "bundler"
Bundler.require

require_relative "lib/player"
require_relative "lib/game"

# declaration des 2 players
player1 = Player.new("Josiane")
player2 = Player.new("José")

# Tant qu'ils sont vivant, répétez tous ce qui est dans le block
while player1.life_points > 0 && player2.life_points > 0
  # affichage de l'etat des joueurs en appelant la fonction show_state
  puts "Voici l'etat de chaque joueur"
  player1.show_state
  player2.show_state

  print("\n")

  puts "Passons à la phase d'attaque"
  # joueur 1 attaque le joueur 2
  player1.attacks(player2)
  # sortir du boucle si joueur 2 a un point de vie inferieur ou egal à 0
  if player2.life_points <= 0
    break
  end
  # joueur 2 attaque le joueur 1
  player2.attacks(player1)
  # sortir du boucle si joueur 1 a un point de vie inferieur ou egal à 0
  if player1.life_points <= 0
    break
  end
  print "\n"
end
puts "-----------------------------------"
binding.pry
