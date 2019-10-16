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

while my_game.human_player.life_points > 0 && (my_game.enemies.size > 0)
  my_game.menu
  variable_choice = gets.chomp
  my_game.menu_choice(variable_choice)
  my_game.enemies_attack
end
my_game.endgame

binding.pry
