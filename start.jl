# Orange Julias
# start.jl <filename> <type> <cheating> <limit> <limit_add> will set up a game file.
# The file will be created, including all tables and key-value pairs.
# start.jl will make no moves. Make sure that the board is ready and black is set to move.
# If type is ”S” then start a game of standard shogi.
# If type is ”M” then start a game of minishogi.
# If type is ”C” then start a game of chu shogi.
# If cheating is ”T” then your move_cheat.jl program is permitted to
# try to play cheating moves, if it thinks it would be of benefit.
# move.jl never cheats, even in a game with cheating enabled.
# Limit will be set to an integer if there is to be a time limit.
# If limit is absent or 0, there is no time limit. This limit is the time allowance
# for the entire game’s worth of moves for a single player.
# If limit_add is present and nonzero then this is how much time should be added
# to a player’s clock, using the Fischer timing system.

# to remove .db file go to shell> rm file.db
include("database.jl")

toGo = 0
while toGo != 1
	if length(ARGS) < 2 || length(ARGS) > 5 || (ARGS[2] != "S" && ARGS[2] != "M" && ARGS[2] != "C" )
		println("\nInput is not valid. Please run the file again! 凸(｀ﾛ´)凸")
		break
	else
		toGo = 1
		filename = ASCIIString(ARGS[1])
		gametype = ASCIIString(ARGS[2])
		#create database
		init_database(filename)
		#set game type (standard or minishogi)
		if gametype == "S"
			set_gameType(filename,"standard")
		elseif gametype == "M"
			set_gameType(filename,"minishogi")
		elseif gametype == "C"
			set_gameType(filename,"chu")
		end
		#set if cheating allow or not
		length(ARGS) < 3 || ARGS[3] != "T" ? set_legality(filename,"legal") : set_legality(filename,"cheating")

		# set time limit
		if length(ARGS) < 4 || ARGS[4] == "0"
			set_isTimed(filename,"no")
		else
			set_isTimed(filename,"yes")
			t = parse(ARGS[4])
			set_senteTime(filename,t)
			set_goteTime(filename,t)
		end

		# set time being added
		length(ARGS) < 5 || ARGS[5] == "0" ? set_timeAdd(filename,0) : set_timeAdd(filename,parse(ARGS[5]))

		# set seed for AI
		# generate start of unix epoch
		const UNIXEPOCH = DateTime(1970)
		# takes current date time and returns number of seconds since unix epoch
		datetime2unix(dt::DateTime) = (dt - UNIXEPOCH)/1000
		# generate current unix time for seed
		seed = Int(datetime2unix(now()))
		set_seed(filename,seed)




		# print tables
		table_meta = get_table(filename,"meta")
		table_moves = get_table(filename,"moves")
		println(table_meta)
		println(table_moves)
	end
end
