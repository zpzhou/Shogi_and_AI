### FUNCTIONS NEED TO RUN MINI SHOGI

### INITIALIZATION/SETUP FUNCTIONS
function fill_black{Pieces}(set::Pieces)
    # fill pawn
    get!(set.active,"pawn_b",(5,4)); get!(set.activeS,(5,4),"pawn_b")
    # fill bishop
    get!(set.active,"bishop_b",(2,5)); get!(set.activeS,(2,5),"bishop_b")
    # fill rook
    get!(set.active,"rook_b",(1,5)); get!(set.activeS,(1,5),"rook_b")
    # fill silver generals
    get!(set.active,"silvergeneral_b",(3,5)); get!(set.activeS,(3,5),"silvergeneral_b")
    # fill gold generals
    get!(set.active,"goldgeneral_b",(4,5)); get!(set.activeS,(4,5),"goldgeneral_b")
    # place king
    get!(set.active,"king_b",(5,5)); get!(set.activeS,(5,5),"king_b")
end

function fill_red{Pieces}(set::Pieces)
    #fill pawn
    get!(set.active,"pawn_r",(1,2)); get!(set.activeS,(1,2),"pawn_r")
    # fill bishop
    get!(set.active,"bishop_r",(4,1)); get!(set.activeS,(4,1),"bishop_r")
    # fill rook
    get!(set.active,"rook_r",(5,1)); get!(set.activeS,(5,1),"rook_r")
    # fill silver generals
    get!(set.active,"silvergeneral_r",(3,1)); get!(set.activeS,(3,1),"silvergeneral_r")
    # fill gold generals
    get!(set.active,"goldgeneral_r",(2,1)); get!(set.activeS,(2,1),"goldgeneral_r")
    # place king
    get!(set.active,"king_r",(1,1)); get!(set.activeS,(1,1),"king_r")
end

# returns a shifted shogi board coordinate to the array coordinates of B.board
function shift_cord(i::Int)
	return 5-i+1
end

# 5-i+1 - arranges coordinates in terms of rows and column
function display_board(B::Board,red::Pieces,black::Pieces)
	for i = 1:5
		for j = 1:5
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

function promote_validate(set::Pieces, piece, cords)
	list = "rbsp" # pieces possible to promote
	if searchindex(list,piece[1]) != 0
		if set.color == "black" && cords[2] < 2
			return 1
		elseif set.color == "red" && cords[2] > 4
			return 1
		end
	end
	return 0 # execution falls here => invalid promote
end

# check for promotion
function promote_check(set::Pieces, piece, cords)
	if promote_validate(set,piece,cords) == 0
		return piece
	elseif set.color == "black"
		# force promotion if pawn or lancer is at furthest rank
		if (piece[1]=='p' && cords[2]==1) || (piece[1]=='l' && cords[2]==1)
			piece = promote_piece(set,piece,cords)
		# otherwise
		else
			promotePrompt(set,piece,cords)
		end
	else 	# set.color == "red"
		# force promotion if pawn or lancer is at furthest rank
		if (piece[1]=='p' && cords[2]==5) || (piece[1]=='l' && cords[2]==5)
			piece = promote_piece(set,piece,cords)
		else # otherwise
			promotePrompt(set,piece,cords)
		end
	end
	return piece
end

function drop_piece(set::Pieces, piece, cords)
    set.color == "black" ? tag = 'b' : tag = 'r'
	# pop piece from hand
	i = findfirst(set.captured,piece)
	set.captured[i] = last(set.captured)
	set.captured[length(set.captured)] = piece
	pop!(set.captured)
	# unpromote piece of promoted
	piece = lcfirst(piece)
	# check for existing piece of the same type
	if haskey(set.active,piece) == true
		cords = set.active[piece]
		set.activeS[cords] = ASCIIString("$(piece)1_$tag")
		pop!(set.active,piece)
		get!(set.active,set.activeS[cords],cords)
		piece = ASCIIString("$(piece)2_$tag")
	end
	# add piece to active list
	get!(set.active,piece,cords)
	get!(set.activeS,cords,piece)
end

function drop_piece(B::Board, set::Pieces, piece, cords)
	# pop piece from hand
	i = findfirst(set.captured,piece)
	length(set.captured) != 1 && (set.captured[i] = last(set.captured))
	piece = set.captured[length(set.captured)] 
	pop!(set.captured)
	# unpromote piece of promoted
	piece = lcfirst(piece)
	# check for existing piece of the same type
	if haskey(set.active,piece) == true
		temp = set.active[piece]
		set.activeS[temp] = ASCIIString("$(piece)1")
		pop!(set.active,piece)
		get!(set.active,set.activeS[temp],temp)
		piece = ASCIIString("$(piece[1])2")
		set_board(B,Pair(set.activeS[temp],temp))
	end
	# add piece to active list
	get!(set.active,piece,cords)
	get!(set.activeS,cords,piece)
	# set piece onto board
	set_board(B,Pair(piece,cords))
end

function drop_check(set::Pieces, enemy::Pieces, piece, cords)
	if piece[1] == 'p'
        A = Int64[]
        for pair in set.active
            pair[1]== 'p' && push!(A,pair[2][1])
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
    dead = check_kill(B,inactive,cords)
    if dead != "NULL"
        chop(dead); chop(dead)
        update_hand(active,lcfirst(dead))
    end

    piece = promote_check(active,piece,cords)
    # update location of piece in dict and board
    update_piece(B,active, piece, cords)
end

function replay_piece(active::Pieces, inactive::Pieces, piece, cords, promote)
    # check for kill
    dead = check_kill(B,inactive,cords)
    if dead != "NULL"
        chop(dead); chop(dead)
        update_hand(active,lcfirst(dead))
    end

    promote == 1 && promote_piece(active,piece,cords)
    # update location of piece in dict and board
    update_piece(B,active, piece, cords)
end

function AI_move_piece(B::Board, active::Pieces, inactive::Pieces, piece, cords)
    # replace old location of piece with 'x' on gameboard
    old_cords = active.active[piece]
    set_board(B,Pair("#",old_cords))

    # shift coords
    x = cords[1]; y = shift_cord(cords[2])

    # check for kill
    dead = check_kill(B,inactive,cords)
    if dead != "NULL"
        update_hand(active,dead)
    end
   
    
    piece = promote_AI(active,piece,cords)
    # update location of piece in dict and board
    update_piece(B,active, piece, cords)
end

function AI_move_piece(active::Pieces, inactive::Pieces, piece, cords)
    # replace old location of piece with 'x' on gameboard
    old_cords = active.active[piece]

    # shift coords
    x = cords[1]; y = shift_cord(cords[2])

    # check for kill
    dead = check_kill(inactive,cords)
    if dead != "NULL"
        dead == "l" ? dead = "$(dead)$(piece[1])$(active.turn)" : dead = "$(dead[1])"
        update_hand(active,dead)
    end
   
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
