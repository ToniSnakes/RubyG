# This is the lifeblood of the game
class Creature

	# Get a metaclass for this class
	def self.metaclass; class << self; self; end; end
	
	# Advanced metaprogrammin gcode for nice, clean traits
	def self.traits( *arr )
		return @traits if arr.empty?
		
		# 1. Set up accessors for each variable
		attr_accessor( *arr )
		
		# 2. Add a new class method to for each trait
		arr.each do |a|
			metaclass.instance_eval do
				define_method( a ) do |val|
					@traits ||= {}
					@traits[a] = val
				end
			end
		end
		
		# 3. For each monster, the 'initialize' method
		#		 should use the default number for each trait
		class_eval do
			define_method( :initialize ) do
				self.class.traits.each do |k,v|
					instance_variable_set("@#{k}", v)
				end
			end
		end
		
	end
	
	# Creature attributes are read-only
	traits :life, :armor, :strength, :speed, :will
	
	# This method applies damage taken if hit
	def hit( damage )
		grit = rand( will ).floor
		damage -= (grit / 4).floor
		damage = 0 if damage < 0
		@life -= damage
		puts "[#{ self.class } has died.]" if @life <= 0
	end
	
	# This method takes one turn in a fight
	def fight( enemy, stat )
		if life <= 0
			puts "[#{ self.class } is too dead to fight!]"
			return
		end
		
		# Attempt the attack
		unless stat == 0
			your_speed_roll = rand( speed ).floor
			enemy_speed_roll = rand( enemy.speed ).floor
			unless your_speed_roll > enemy_speed_roll
				puts "[Your hit misses the enemy!!!]"
			else
				# Deal damage if hit landed
				your_hit = rand( stat ).floor
				enemy_defense = rand( armor ).floor
				your_hit -= enemy_defense
				if your_hit < 1
					puts "[You hit the enemy, but the attack glances away!!]"
				else
					puts "[You hit the enemy, dealing	#{ your_hit } points of damage!]"
					enemy.hit( your_hit )
				end
			end
		end
		
		# Retaliation
		p enemy
		#enemy.show_stats
		if enemy.life > 0
			enemy_speed_roll = rand( enemy.speed ).floor
			your_speed_roll = rand( speed ).floor
			unless enemy_speed_roll > your_speed_roll
				puts "[You dodge the enemy's attack!!]"
			else
				enemy_hit = rand( enemy.strength ).floor
				your_defense = rand ( armor ).floor
				enemy_hit -= your_defense
				if enemy_hit < 1
					puts "[The enemy hits you, but the attack glances away!!]"
				else
					puts "[The enemy hits you, dealing #{ enemy_hit } points of damage!]"
					self.hit( enemy_hit )
				end
			end
		end
		p self
		#show_stats
	end

	def show_stats
		puts "Name:	#{ self.class }\n\n"
		self.class.traits.each do |k,v|
			puts k.capitalize.to_s + " " + v.to_s
		end
	end
	
end
