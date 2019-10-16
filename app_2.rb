require "bundler"
Bundler.require

require_relative "lib/game"
require_relative "lib/player"

puts "-" * 49
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-" * 49

print "Quel est votre prénom?\n"
first_name_user = gets.chomp
user = HumanPlayer.new(first_name_user)

player1 = Player.new("Josiane")
player2 = Player.new("José")

ennemies = [player1, player2]

while user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
=begin  puts "\nVoici l'etat de chaque joueur"
  user.show_state
  player1.show_state
  player2.show_state

  print("\n")

  puts "Passons à la phase d'attaque"

  user.attacks(player1) if player1.life_points > 0
  player1.attacks(user) if player1.life_points > 0

  break if user.life_points <= 0

  user.attacks(player2) if player2.life_points > 0
  player2.attacks(user) if player2.life_points > 0

  break if user.life_points <= 0

  break if player1.life_points <= 0 && player2.life_points <= 0
    /version 1.0
=end
  puts "\nQuelle action veux-tu effectuer ?"
  print "a - chercher une meilleur arme\ns - chercher à se soigner\n"

  puts "attaquer un joueur en vue :"
  print "\n0 - Josiane a #{player1.life_points} points de vie"
  print "\n1 - José a #{player2.life_points} points de vie"
  print "\n2 - Attaque des ennemies"
  print "\n>"
  choice = gets.chomp

  case choice
  when "a"
    puts "chercher une meilleur arme\ns - chercher à se soigner"
    user.search_weapon
    user.show_state
  when "s"
    puts "chercher à se soigner"
    user.search_health_pack
    user.show_state
  when "0"
    puts "Josiane a #{player1.life_points} points de vie"
    (user.attacks(player1); player1.show_state) if player1.life_points > 0
    player1.show_state
  when "1"
    puts "José a #{player2.life_points} points de vie"
    (user.attacks(player2); player2.show_state) if player2.life_points > 0
    player2.show_state
  when "2"
    puts "attaque des ennemies"
    ennemies.each do |ennemie|
      ennemie.attacks(user); user.show_state if user.life_points > 0
    end
  else
  end
end

puts "La partie est finie"
(user.life_points <= 0) ? (puts "Loser ! Tu as perdu !") : (puts "BRAVO ! TU AS GAGNE !")

binding.pry
