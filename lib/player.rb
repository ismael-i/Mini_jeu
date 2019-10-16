require "pry"

class Player
  attr_accessor :name, :life_points #declaration des attributs de Player

  def initialize(name) # methode pour construire un Player
    @name = name    # initialiser la variable d'instance name
    @life_points = 10   # initialiser la variable d'instance life_points
  end

  def show_state # fonction qui donne l'etat du player
    puts "#{@name} a #{@life_points} points de vie"
  end

  def gets_damage(number_of_damage)
    @life_points = @life_points - number_of_damage
    (@life_points <= 0) ? (puts "le joueur #{@name} a été tué !") : ()
  end

  def attacks(another_player)
    puts "le joueur #{@name} attaque le joueur #{another_player.name}"
    value_damage = compute_damage
    puts "il lui inflige #{value_damage} points de dommages"
    another_player.gets_damage(value_damage)
  end

  def compute_damage
    return rand(1..6)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    super(name)
    @life_points = 100
    @weapon_level = 1
  end

  def show_state # fonction qui donne l'etat du player
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{weapon_level}"
  end

  def compute_damage
    return rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon_searched = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_weapon_searched}"
    #(new_weapon_searched > @weapon_level) ? (@weapon_level = new_weapon_searched; puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."}") : (puts "")
    if new_weapon_searched > @weapon_level
      @weapon_level = new_weapon_searched
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
    else
      puts "elle n'est pas mieux que ton arme actuelle"
    end
  end

  def search_health_pack
    new_health_pack_searched = rand(1..6)
    if new_health_pack_searched == 1
      puts "Tu n'as rien trouvé..."
    end
    if new_health_pack_searched >= 2 && new_health_pack_searched <= 5
      @life_points += 50
      if @life_points > 100
        @life_points = 100
      end
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    end
    if new_health_pack_searched == 6
      @life_points += 80
      if @life_points > 100
        @life_points = 100
      end
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
    end
  end
end
