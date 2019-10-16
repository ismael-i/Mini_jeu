require "bundler"
Bundler.require

require_relative "lib/game"
require_relative "lib/player"

puts "-" * 49
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-" * 49

print "Veuillez entrer le nom de votre hero\n>"
name = gets.chomp
my_game = Game.new(name)

# Tant que le personnage utilisateur est superieur strict à 0 et il a encore des ennemies
while my_game.human_player.life_points > 0 && (my_game.enemies.size > 0)
  # afficher menu
  my_game.menu
  # demande à l'utilisateur de choisir
  variable_choice = gets.chomp
  # executer le choix de 'l'utilisateur
  my_game.menu_choice(variable_choice)
  # attaques des ennemies vivant
  my_game.enemies_attack
end
# fin du jeu
my_game.endgame

binding.pry
