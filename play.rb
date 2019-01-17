require_relative 'creature'
require_relative 'manuel'
require_relative 'protagonist'

require 'io/console'
#input = STDIN.getch

player = Protagonist.new
dummy = TrainingDummy.new

def clear n
	print "\n" * n
end

clear 50

def help
	puts "Instructions:"
	puts "s:		Strike"
	puts "c:		Cast"
	puts "q:		Quit"
	puts "h:		Display this message"
end

def spells( player, enemy )
	puts "Choose spell:"
	puts "h:		Heal - A small, curative spell"
	puts "a:		Arcane Bolt - Casters gotta start somewhere, right?"
	puts "c:		Cancel"
	clear 2

	key = STDIN.getch
	while true
		if key == 'h'
			player.cast enemy, :heal
			break
		elsif key == 'a'
			player.cast enemy, :arcane_bolt
			break
		elsif key == 'c'
			break
		else
			puts "Invalid choice!"
		end
	end
end

def the_choice
	puts "Now, brave adventurer, choose thy enemy!"
	puts "t: Training Dummy - A simple but surprisingly resistant construct made for the sole purpose of being hit"
	clear 1
	
	while true
		key = STDIN.getch
		if key == 't'
			return TrainingDummy.new
		else
			puts "Invalid choice!"
		end
	end
end

puts "Welcome! To the Dungeon of Dreadless!"
puts "You, brave adventurer are:"
clear 1
player.show_stats
clear 1
enemy = the_choice
clear 5
puts "Today, you will be facing:"
clear 1
enemy.show_stats
clear 1
help
clear 10
puts "Now, without further ado... BEGIN!"
clear 0

while true do
	#print "\n"
	clear 1
	key = STDIN.getch
	if key == 'q'
		break
	elsif key == 's'
		player.strike enemy
	elsif key == 'c'
		spells player, enemy
	elsif key == 'h'
		help
	end
end
