class Protagonist < Creature
	# Add a leveling system

	life 20
	armor 5
	strength 10
	speed 10
	will 10
	
	# Basic attack
	def strike( enemy )
		fight( enemy, strength )
	end
	def cast( enemy, spell )
		if spell == :heal
			heal_amount = rand( will )
			@life += heal_amount
			puts "[You have healed yourself for	#{ heal_amount } points!]"
			fight( enemy, 0 )
		elsif spell == :arcane_bolt
			fight( enemy, will )
		end
	end
	
end
