require "bundler"
Bundler.require

require_relative "lib/game"
require_relative "lib/player"

puts "-" * 49
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-" * 49

# Demander à l'utilisateur, son prenom
print "Quel est votre prénom?\n"
first_name_user = gets.chomp
# creer le personnage utilisateur dont le nom est en fonction de l'entree au clavier
user = HumanPlayer.new(first_name_user)

# creer 2 joueurs, josiane et josé
player1 = Player.new("Josiane")
player2 = Player.new("José")

# mettre les 2 joueurs dans le tableau ennemies
ennemies = [player1, player2]

# Tant que le point de vie du personnage utilisateur est superieur à 0 et tous ses ennemies sont vivants
while user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
  puts "\nQuelle action veux-tu effectuer ?"
  print "a - chercher une meilleur arme\ns - chercher à se soigner\n"

  puts "attaquer un joueur en vue :"
  print "\n0 - Josiane a #{player1.life_points} points de vie"
  print "\n1 - José a #{player2.life_points} points de vie"
  print "\n2 - Attaque des ennemies"
  print "\n>"
  # attendre l'utilisateur appuie au clavier pour donner son choix
  choice = gets.chomp

  case choice
  #si a
  when "a"
    puts "chercher une meilleur arme\ns - chercher à se soigner"
    # utilisateur recherche un arme
    user.search_weapon
    # affichage de l'etat de l'utilisateur
    user.show_state
  when "s"
    puts "chercher à se soigner"
    # utilisateur recherche un pack de santé
    user.search_health_pack
    # affichage de l'etat de l'utilisateur
    user.show_state
  when "0"
    puts "Josiane a #{player1.life_points} points de vie"
    # le personnage utilisateur attaque l'ennemie 1 s'il n'est encore mort
    (user.attacks(player1); player1.show_state) if player1.life_points > 0
    # affichage de l'etat de l'ennemie 1
    player1.show_state
  when "1"
    puts "José a #{player2.life_points} points de vie"
    # le personnage utilisateur attaque l'ennemie 2 s'il n'est encore mort
    (user.attacks(player2); player2.show_state) if player2.life_points > 0
    # affichage de l'etat de l'ennemie 2
    player2.show_state
  when "2"
    puts "attaque des ennemies"
    ennemies.each do |ennemie|
      # le personnage utilisateur a été attaqué par les 2 ennemies
      ennemie.attacks(user); user.show_state if user.life_points > 0
    end
  else
  end
end

# fin de partie
puts "La partie est finie"
# si le point de vie de l'utilisateur est inferieur ou égal à 0 alors afficher Loser ! Tu as perdu ! si non BRAVO ! TU AS GAGNE !
(user.life_points <= 0) ? (puts "Loser ! Tu as perdu !") : (puts "BRAVO ! TU AS GAGNE !")

binding.pry
