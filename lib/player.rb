require "pry"
# declaration
class Player
  # declaration des attributs de Player
  attr_accessor :name, :life_points

  # methode pour construire un Player
  def initialize(name)
    # initialiser la variable d'instance name
    @name = name
    # initialiser la variable d'instance life_points
    @life_points = 10
  end

  # fonction qui donne l'etat du player
  def show_state
    # affichage nom et point de vie
    puts "#{@name} a #{@life_points} points de vie"
  end

  # fonction qui retourne le dommage
  def gets_damage(number_of_damage)
    # soustraire le point de vie
    @life_points = @life_points - number_of_damage
    # si point de vie est inferieur ou egal à 0, afficher que le joueur a été tué
    (@life_points <= 0) ? (puts "le joueur #{@name} a été tué !") : ()
  end

  # fonction attaquer un autre player
  def attacks(another_player)
    puts "le joueur #{@name} attaque le joueur #{another_player.name}"
    # definition du point de dommage en appelant la fonction domute damage
    value_damage = compute_damage
    puts "il lui inflige #{value_damage} points de dommages"
    another_player.gets_damage(value_damage)
  end

  # fonction qui retourne un nombre entre 1 et 6
  def compute_damage
    return rand(1..6)
  end
end

# declaration de la classe humanPlayer qui herite la classe Player
class HumanPlayer < Player
  # declaration des attributs du classe HumanPlayer
  attr_accessor :weapon_level

  #declaration du constructeur
  def initialize(name)
    # appelation du constructeur de la classe mere
    super(name)
    # initialisation du point de vie à 100
    @life_points = 100
    # initialisation du level de son arme à 1
    @weapon_level = 1
  end

  # fonction qui affiche l'etat du humanplayer courant
  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{weapon_level}"
  end

  # fonction qui retourne par hasard un integer apelé domage
  def compute_damage
    return rand(1..6) * @weapon_level
  end

  # fonction recherche d'arme
  def search_weapon
    new_weapon_searched = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_weapon_searched}"
    if new_weapon_searched > @weapon_level
      @weapon_level = new_weapon_searched
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
    else
      puts "elle n'est pas mieux que ton arme actuelle"
    end
  end

  #fonction recherche du pack de santé
  def search_health_pack
    # possibilté de valeur du variable new_health_pack_searched est entre 1 et 6
    new_health_pack_searched = rand(1..6)
    # si la valeur de la pack est égal à 1 afficher Tu n'as rien trouvé...
    if new_health_pack_searched == 1
      puts "Tu n'as rien trouvé..."
    end
    # si la valeur de la pack est superieur ou égal à 2 et inferieur ou egal à 5 ajouter 50 à son poitn de vie
    if new_health_pack_searched >= 2 && new_health_pack_searched <= 5
      @life_points += 50
      # si la valeur de la pack est superieur strict à 100
      if @life_points > 100
        # fixer son point de vie à 100
        @life_points = 100
      end
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    end
    # si la valeur de la pack est égal à 6
    if new_health_pack_searched == 6
      # ajouter 80 à son point de vie
      @life_points += 80
      if @life_points > 100
        # affecter 100 à son point de vie
        @life_points = 100
      end
      # afficher point de vie
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
    end
  end
end
