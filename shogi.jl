### functions needed to run regular shogi

function fill_black{Pieces}(set::Pieces)
	# fill rooks
	for i = 1:9
		get!(set.active,"pawn$(i)_b",(i,7))
		get!(set.activeS,(i,7),"pawn$(i)_b")
	end
	# fill bishop
	get!(set.active,"bishop_b",(8,8)); get!(set.activeS,(8,8),"bishop_b")
	# fill rook
	get!(set.active,"rook_b",(2,8)); get!(set.activeS,(2,8),"rook_b")
	# fill lancerss
	get!(set.active,"lance2_b",(9,9)); get!(set.active,"lance1_b",(1,9))
	get!(set.activeS,(9,9),"lance2_b"); get!(set.activeS,(1,9),"lance1_b")
	#fill knights
	get!(set.active,"knight2_b",(8,9)); get!(set.active,"knight1_b",(2,9))
	get!(set.activeS,(8,9),"knight2_b"); get!(set.activeS,(2,9),"knight1_b")
	# fill silver generals
	get!(set.active,"silvergeneral2_b",(7,9)); get!(set.active,"silvergeneral1_b",(3,9))
	get!(set.activeS,(7,9),"silvergeneral2_b"); get!(set.activeS,(3,9),"silvergeneral1_b")
	# fill gold generals
	get!(set.active,"goldgeneral2_b",(6,9)); get!(set.active,"goldgeneral1_b",(4,9))
	get!(set.activeS,(6,9),"goldgeneral2_b"); get!(set.activeS,(4,9),"goldgeneral1_b")
	# place king
	get!(set.active,"king_b",(5,9)); get!(set.activeS,(5,9),"king_b")
end

function fill_red{Pieces}(set::Pieces)
	for i = 1:9
		get!(set.active,"pawn$(i)_r",(i,3))
		get!(set.activeS,(i,3),"pawn$(i)_r")
	end
	get!(set.active,"bishop_r",(2,2)); get!(set.activeS,(2,2),"bishop_r")
	get!(set.active,"rook_r",(8,2)); get!(set.activeS,(8,2),"rook_r")
	get!(set.active,"lance2_r",(9,1)); get!(set.active,"lance1_r",(1,1))
	get!(set.activeS,(9,1),"lance2_r"); get!(set.activeS,(1,1),"lance1_r")
	get!(set.active,"knight2_r",(8,1)); get!(set.active,"knight1_r",(2,1))
	get!(set.activeS,(8,1),"knight2_r"); get!(set.activeS,(2,1),"knight1_r")
	get!(set.active,"silvergeneral1_r",(3,1)); get!(set.active,"silvergeneral2_r",(7,1))
	get!(set.activeS,(3,1),"silvergeneral1_r"); get!(set.activeS,(7,1),"silvergeneral2_r")
	get!(set.active,"goldgeneral1_r",(4,1)); get!(set.active,"goldgeneral2_r",(6,1))
	get!(set.activeS,(4,1),"goldgeneral1_r"); get!(set.activeS,(6,1),"goldgeneral2_r")
	get!(set.active,"king_r",(5,1)); get!(set.activeS,(5,1),"king_r")
end

# 9-i+1 - arranges coordinates in terms of rows and column
function display_board(B::Board,red::Pieces,black::Pieces)
	for i = 1:9
		for j = 1:9
			unit = B.board[i,j]; r = shift_cord(i); c = j
			if unit != "#"
				if unit == "k "
					print_with_color(:yellow,"$unit  ")
				elseif haskey(red.activeS,(c,r)) == true
					print_with_color(:red,"$unit  ")
				else
					print_with_color(:blue,"$unit  ")
				end
			else
				print("$unit   ")
			end
		end
		println()
	end
	println()
end

# returns a shifted shogi board coordinate to the array coordinates of B.board
function shift_cord(i::Int)
    return 9-i+1
end

function promote_validate(set::Pieces, piece, cords)
	list = "plnsrb" # pieces possible to promote
	if searchindex(list,piece[1]) != 0
		if set.color == "black" && cords[2] < 4
			return 1
		elseif set.color == "red" && cords[2] > 6
			return 1
		end
	end
	return 0 # execution falls here => invalid promotion
end

function promote_check(set::Pieces, piece, cords)
    if promote_validate(set,piece,cords) == 0
        return piece
    elseif set.color == "black"
        # force promotion if pawn or lancer is at furthest rank
        if (piece[1]=='p' && cords[2]==1) || (piece[1]=='l' && cords[2]==1)
            piece = promote_piece(set,piece,cords)
        # force promotion if knight is a furthest 2 ranks
        elseif piece[1]=='n' && (cords[2]==2 || cords[2]==1)
            piece = promote_piece(set,piece,cords)
        # otherwise
        else
            promptPromote(set,piece,cords)
        end
    else    # set.color == "red"
        # force promotion if pawn or lancer is at furthest rank
        if (piece[1]=='p' && cords[2]==9) || (piece[1]=='l' && cords[2]==9)
            piece = promote_piece(set,piece,cords)
        # force promotion if knight is a furthest 2 ranks
        elseif piece[1]=='n' && (cords[2]==8 || cords[2]==9)
            promote_piece(set,piece,cords)
        # otherwise
        else
            promptPromote(set,piece,cords)
        end
    end
    return piece
end

function drop_piece(set::Pieces, piece, cords)
        set.color == "black" ? tag = 'b' : tag = 'r'
		# pop piece from hand
		i = findfirst(set.captured,piece)
		#println(set.captured); println(piece)
		length(set.captured) != 1 && (set.captured[i] = last(set.captured))
		set.captured[length(set.captured)] = piece
		pop!(set.captured)
		# unpromote piece of promoted
		piece = lcfirst(piece)
		# add piece to active list
		A = Array{Int64}(0)
		if piece != "rook" && piece != "bishop"
			for pair in set.active
				pair[1][1] == piece && push!(A,parse(Int64,(pair[1][2])))
			end
		end
		# piece will be the i'th piece of its type on the board
		i::Int64
		if piece[1] == 'p'
			for j = 1:9
				if findfirst(A,j) == 0
					i = j; break
				end
			end
            len = length(piece); piece = piece[1:len-1]
			piece = ASCIIString("$(piece)$(i)_$tag")
		elseif piece == "rook" || piece == "bishop"
			if haskey(set.active) == true
				temp = set.active[piece]
				pop!(set.active,piece)
				set.activeS[temp] = ASCIIString("$(piece)1_$tag")
				get!(set.active,set.activeS[temp],temp)
				piece = ASCIIString("$(piece)2_$tag")
			end
			# piece is unchanged if above condition fails
		else
			i = 1 + length(A)
            len = length(piece); piece = piece[1:len-1]
			piece = ASCIIString("$(piece)$(i)_$tag")
		end
		# add piece to active list
		get!(set.active,piece,cords)
		get!(set.activeS,cords,piece)
end

function drop_piece(B::Board, set::Pieces, piece, cords)
		# pop piece from hand
		i = findfirst(set.captured,piece)
		set.captured[i] = last(set.captured)
		piece = set.captured[length(set.captured)] 
		pop!(set.captured)
		# unpromote piece of promoted
		piece = lcfirst(piece)
		# add piece to active list
		A = Int64[]
		if piece != "r" && piece != "b"
			for pair in set.active
				pair[1][1] == piece[1] && push!(A,parse(Int64,(pair[1][2])))
			end
		end
		#println(A)
		i::Int64
		if piece[1] == 'p'
			for j = 1:9
				if findfirst(A,j) == 0
					i = j; break
				end
			end
			piece = ASCIIString("$(piece[1])$i")
		elseif piece == "r" || piece == "b"
			if haskey(set.active,piece) == true
				temp = set.active[piece]
				set.activeS[temp] = ASCIIString("$(piece)1")
				pop!(set.active,piece)
				get!(set.active,set.activeS[temp],temp)
				set_board(B,Pair(set.activeS[temp],temp))
				piece = ASCIIString("$(piece[1])2")
			end
			# piece is unchanged if above condition fails
		else
			i = 1 + length(A)
			piece = ASCIIString("$(piece[1])$i")
		end
		# add piece to active list
		get!(set.active,piece,cords)
		get!(set.activeS,cords,piece)
		# set piece onto board
		set_board(B,Pair(piece,cords))
end

# function drop_piece(B::GtkGridLeaf, set::Pieces, piece, cords)
# 		# pop piece from hand
# 		i = findfirst(set.captured,piece)
# 		set.captured[i] = last(set.captured)
# 		set.captured[length(set.captured)] = piece
# 		pop!(set.captured)
# 		# unpromote piece of promoted
# 		piece = lcfirst(piece)
# 		# add piece to active list
# 		A = Int64[]
# 		if piece != "r" && piece != "b"
# 			for pair in set.active
# 				pair[1][1] == piece[1] && push!(A,parse(Int64,(pair[1][2])))
# 			end
# 		end
# 		#println(A)
# 		i::Int64
# 		if piece[1] == 'p'
# 			for j = 1:9
# 				if findfirst(A,j) == 0
# 					i = j; break
# 				end
# 			end
# 			piece = ASCIIString("$(piece[1])$i")
# 		elseif piece == "r" || piece == "b"
# 			if haskey(set.active,piece) == true
# 				temp = set.active[piece]
# 				set.activeS[temp] = ASCIIString("$(piece)1")
# 				pop!(set.active,piece)
# 				get!(set.active,set.activeS[temp],temp)
# 				set_board(B,Pair(set.activeS[temp],temp))
# 				piece = ASCIIString("$(piece[1])2")
# 			end
# 			# piece is unchanged if above condition fails
# 		else
# 			i = 1 + length(A)
# 			piece = ASCIIString("$(piece[1])$i")
# 		end
# 		# add piece to active list
# 		get!(set.active,piece,cords)
# 		get!(set.activeS,cords,piece)
# 		# set piece onto board
# 		set_board(B,Pair(piece,cords))
# end

function drop_check(set::Pieces, enemy::Pieces, piece, cords)
	if piece[1] == 'p'
        A = Int64[]
        for pair in set.active
            pair[1][1] == 'p' && push!(A,pair[2][1])
        end
       	if findfirst(A,cords[1]) == 0
       		if haskey(set.activeS,cords) != true && haskey(enemy.activeS,cords) != true
       			return 1
       		end
       	end
    elseif piece[1] == 'n' || piece[1] == 'l'
     	if haskey(set.activeS,cords) != true && haskey(enemy.activeS,cords) != true
       		return 1
       	end
   	else
   		if haskey(set.activeS,cords) != true && haskey(enemy.activeS,cords) != true
   			return 1
   		end
   	end
   	return 0
end

function move_piece(active::Pieces, inactive::Pieces, piece, cords)
    # check for kill
    dead = check_kill(inactive,cords)
    if dead != "NULL"
        chop(dead); chop(dead);
        update_hand(active,lcfirst(dead))
    end
    piece = promote_check(active,piece,cords)
    # update location of piece in dict and board
    update_piece(active, piece, cords)
end

function replay_piece(active::Pieces, inactive::Pieces, piece, cords, promote::Bool)
    # check for kill
    dead = check_kill(inactive,cords)
    if dead != "NULL"
        chop(dead); chop(dead);
        update_hand(active,lcfirst(dead))
    end
    promote == 1 && promote_piece(active,piece,cords)
    # update location of piece in dict and board
    update_piece(active, piece, cords)
end

# for montecarlo/AB simulations
function AI_move_piece(active::Pieces, inactive::Pieces, piece, cords)
    # shift coords
    x = cords[1]; y = shift_cord(cords[2])
    # check for kill
    dead = check_kill(inactive,cords)
    if dead != "NULL"
        dead == "l" ? dead = "$(dead)$(piece[1])$(active.turn)" : dead = "$(dead[1])"
        update_hand(active,dead)
    end
 	# check for promotion
    piece = promote_AI(active,piece,cords)
    # update location of piece in dict and board
    update_piece(active, piece, cords)
end

### TESTING FUNCTIONS

# test = Board()
# fill_pieces(test) # give pieces their starting coordinates
# set_board(test)

# # print initial state of game board
# display_board(test)

# # move some pieces
# move_piece(test,"p9","49")
# test.turn = 1 # red turn
# move_piece(test,"k","25") # illegal move
# test.turn = 0 # black turn
# move_piece(test,"p8","48")
# test.turn = 1 # red turn
# move_piece(test,"k",[1,5]) # kill black king
# test.turn = 0 # black turn
# move_piece(test,"g2","27")
# test.turn = 1 # red turn
# drop_piece(test,"k_b",[9,5]) # drop black king


# # print current state of game board
# display_board(test)
