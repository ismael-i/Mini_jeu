require "pry"

class Game
  attr_accessor :human_player, :enemies
  # constructeur de Game
  def initialize(name)
    # initialisation de variable de type HumanPlayer
    @human_player = HumanPlayer.new(name)
    # initialisation du tableau enemie de human_player
    @enemies = [Player.new("#{@human_player.name}_enemies_1"), Player.new("#{@human_player.name}_enemies_2"), Player.new("#{@human_player.name}_enemies_3"), Player.new("#{@human_player.name}_enemies_4")]
  end

  # méthode permet d'éliminer un adversaire tué.
  def killplayer(player)
    # definition d'un tableau temporaire
    temp = []
    # parcourir le tableau de l'enemie
    for index_ennemie in 0...@enemies.size
      # mettre tous les players ayant un nom different de player dans le tableau temporaire
      if @enemies[index_ennemie].name != player.name
        temp << @enemies[index_ennemie]
      end
    end
    # remettre les elements dans le tableau temporaire dans le tableau enemie
    @enemies = temp
  end

  # fonction qui verifie si le jeu est toujours en cours
  def is_still_ongoing?
    # si l'indication de vie de human_player est positive et il a encore des ennemies
    if @human_player.life_points > 0 && @enemies.size > 0
      return true
    end
    return false
  end

  # affichage des personnages vivants
  def show_players
    @human_player.show_state
    puts "le nombre de joueurs bots restants : #{@enemies.size}"
  end

  # affichage du menu
  def menu
    puts "\nQuelle action veux-tu effectuer ?"
    print "a - chercher une meilleur arme\ns - chercher à se soigner\n"
    print "attaquer un joueur en vue :\n"

    for index_enemie in 0...@enemies.size
      puts "#{index_enemie} - attaquer #{@enemies[index_enemie].show_state}"
    end
    print ">"
  end

  def menu_choice(choice)
    # si choix d'utilisateur est
    case choice
    # a
    when "a"
      # afficher tout ce qui est derriere puts
      puts "chercher une meilleur arme\ns - chercher à se soigner"
      # personnage utilisateur appelle la fonction recherche d'arme
      @human_player.search_weapon
      # afficher l'etat de la personnage utilisateur
      @human_player.show_state
    when "s"
      # afficher tout ce qui est derriere puts
      puts "chercher à se soigner"
      # personnage utilisateur appelle la fonction recherche de la pack de santé
      @human_player.search_health_pack
      # afficher l'etat de la personnage utilisateur
      @human_player.show_state
    end

    if (choice.to_i.class.to_s == "Integer" && choice.to_i < @enemies.size && choice.to_i > -1)
      # personnage utilisateur attaque son ennemie indice du choix de l'utilisateur
      @human_player.attacks(@enemies[choice.to_i])
      # affichage de l'etat de son ennemie
      @enemies[choice.to_i].show_state
      # si le point de vie de son enemie courant est inferieur ou egal à 0
      if @enemies[choice.to_i].life_points <= 0
        #enlever l'enemie courant
        killplayer(@enemies[choice.to_i])
      end
    end
  end

  # fonction qui permet à tous les ennemies de l'utilisateur, de l'attaquer
  def enemies_attack
    # pour 0 au nombre des ennemies
    for index_enemie in (0...@enemies.size)
      # si le nombre de point de vie de l'ennemie est superieur strict à 0
      if (@human_player.life_points > 0)
        # l'ennemie courant attaque l'utilisateur
        @enemies[index_enemie].attacks(@human_player)
        # afficher l'etat du personnage utilisateur
        @human_player.show_state
        #si non
      else
        #fin du jeu
        endgame
        break
      end
    end
  end

  # fonction fin du jeu
  def endgame
    # afficher tout ce qui est derriere puts
    puts "La partie est finie"
    # si le point de vie du personnage utilisateur est inferieurou égal à 0, afficher Loser ! Tu as perdu ! si non affciher BRAVO ! TU AS GAGNE !
    (@human_player.life_points <= 0) ? (puts "Loser ! Tu as perdu !") : (puts "BRAVO ! TU AS GAGNE !")
  end
end
