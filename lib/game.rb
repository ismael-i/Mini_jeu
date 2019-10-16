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

  def show_players
    @human_player.show_state
    puts "le nombre de joueurs bots restants : #{@enemies.size}"
  end

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
    case choice
    when "a"
      puts "chercher une meilleur arme\ns - chercher à se soigner"
      @human_player.search_weapon
      @human_player.show_state
    when "s"
      puts "chercher à se soigner"
      @human_player.search_health_pack
      @human_player.show_state
    end

    if (choice.to_i.class.to_s == "Integer" && choice.to_i < @enemies.size && choice.to_i > -1)
      #puts "attaquer #{@enemies[choice.to_i].name} a #{@enemies[choice.to_i].life_points} points de vie"
      @human_player.attacks(@enemies[choice.to_i])
      @enemies[choice.to_i].show_state

      if @enemies[choice.to_i].life_points <= 0
        killplayer(@enemies[choice.to_i])
      end
    end
  end

  def enemies_attack
    for index_enemie in (0...@enemies.size)
      if (@human_player.life_points > 0)
        @enemies[index_enemie].attacks(@human_player)
        @human_player.show_state
      else
        endgame
        break
      end
    end
  end

  def endgame
    puts "La partie est finie"
    (@human_player.life_points <= 0) ? (puts "Loser ! Tu as perdu !") : (puts "BRAVO ! TU AS GAGNE !")
  end
end
