### FUNCTIONS NEEDED TO RUN CHU SHOGI
    
# include("general_functions.jl")
# include("move_functions_chushogi.jl")
# include("AI_chushogi.jl")

### INITIALIZATION/SETUP FUNCTIONS

# input function
function input()
    return chomp(readline(STDIN))
end

function fill_black{Pieces}(set::Pieces)
    #fill go-betweens
    get!(set.active,"gobetween1_b",(4,8)); get!(set.activeS,(4,8),"gobetween1_b")
    get!(set.active,"gobetween2_b",(9,8)); get!(set.activeS,(9,8),"gobetween2_b")
    # fill pawns
    for i = 1:12
        get!(set.active,"pawn$(i)_b",(i,9))
        get!(set.activeS,(i,9),"pawn$(i)_b")
    end
    # fill side movers
    get!(set.active,"sidemover1_b",(1,10)); get!(set.activeS,(1,10),"sidemover1_b")
    get!(set.active,"sidemover2_b",(12,10)); get!(set.activeS,(12,10),"sidemover2_b")
    # fill vertical movers
    get!(set.active,"verticalmover1_b",(2,10)); get!(set.activeS,(2,10),"verticalmover1_b")
    get!(set.active,"verticalmover2_b",(11,10)); get!(set.activeS,(11,10),"verticalmover2_b")
    # fill rooks
    get!(set.active,"rook1_b",(3,10)); get!(set.activeS,(3,10),"rook1_b")
    get!(set.active,"rook2_b",(10,10)); get!(set.activeS,(10,10),"rook2_b")
    # fill dragon horse
    get!(set.active,"dragonhorse1_b",(4,10)); get!(set.activeS,(4,10),"dragonhorse1_b")
    get!(set.active,"dragonhorse2_b",(9,10)); get!(set.activeS,(9,10),"dragonhorse2_b")
    # fill dragon king
    get!(set.active,"dragonking1_b",(5,10)); get!(set.activeS,(5,10),"dragonking1_b")
    get!(set.active,"dragonking2_b",(8,10)); get!(set.activeS,(8,10),"dragonking2_b")
    # fill queen
    get!(set.active,"queen_b",(6,10)); get!(set.activeS,(6,10),"queen_b")
    # fill reverse chariot
    get!(set.active,"reversechariot1_b",(1,11)); get!(set.activeS,(1,11),"reversechariot1_b")
    get!(set.active,"reversechariot2_b",(12,11)); get!(set.activeS,(12,11),"reversechariot2_b")
    # fill bishops
    get!(set.active,"bishop1_b",(3,11)); get!(set.activeS,(3,11),"bishop1_b")
    get!(set.active,"bishop2_b",(10,11)); get!(set.activeS,(10,11),"bishop2_b")
    # fill blind tigers
    get!(set.active,"blindtiger1_b",(5,11)); get!(set.activeS,(5,11),"blindtiger1_b")
    get!(set.active,"blindtiger2_b",(8,11)); get!(set.activeS,(8,11),"blindtiger2_b")
    # fill phoenix
    get!(set.active,"phoenix_b",(6,11)); get!(set.activeS,(6,11),"phoenix_b")
    # fill kirin
    get!(set.active,"kirin_b",(7,11)); get!(set.activeS,(7,11),"kirin_b")
    # fill lancers
    get!(set.active,"lance1_b",(1,12)); get!(set.activeS,(1,12),"lance1_b")
    get!(set.active,"lance2_b",(12,12)); get!(set.activeS,(12,12),"lance2_b")
    # fill ferocious leopards
    get!(set.active,"ferociousleopard1_b",(2,12)); get!(set.activeS,(2,12),"ferociousleopard1_b")
    get!(set.active,"ferociousleopard2_b",(11,12)); get!(set.activeS,(11,12),"ferociousleopard2_b")
    # fill copper generals
    get!(set.active,"coppergeneral1_b",(3,12)); get!(set.activeS,(3,12),"coppergeneral1_b")
    get!(set.active,"coppergeneral2_b",(10,12)); get!(set.activeS,(10,12),"coppergeneral2_b")
    # fill silver generals
    get!(set.active,"silvergeneral1_b",(4,12)); get!(set.activeS,(4,12),"silvergeneral1_b")
    get!(set.active,"silvergeneral2_b",(9,12)); get!(set.activeS,(9,12),"silvergeneral2_b")
    # fill gold generals
    get!(set.active,"goldgeneral1_b",(5,12)); get!(set.activeS,(5,12),"goldgeneral1_b")
    get!(set.active,"goldgeneral2_b",(8,12)); get!(set.activeS,(8,12),"goldgeneral2_b")
    # fill drunk elephant
    get!(set.active,"drunkelephant_b",(6,12)); get!(set.activeS,(6,12),"drunkelephant_b")
    # fill king
    get!(set.active,"king_b",(7,12)); get!(set.activeS,(7,12),"king_b")
    # fill liioon
    get!(set.active,"lion_b",(7,10)); get!(set.activeS,(7,10),"lion_b")
end

function fill_red{Pieces}(set::Pieces)
    #fill go-betweens
    get!(set.active,"gobetween1_r",(4,5)); get!(set.activeS,(4,5),"gobetween1_r")
    get!(set.active,"gobetween2_r",(9,5)); get!(set.activeS,(9,5),"gobetween2_r")
    # fill pawns
    for i = 1:12
        get!(set.active,"pawn$(i)_r",(i,4))
        get!(set.activeS,(i,4),"pawn$(i)_r")
    end
    # fill side movers
    get!(set.active,"sidemover1_r",(1,3)); get!(set.activeS,(1,3),"sidemover1_r")
    get!(set.active,"sidemover2_r",(12,3)); get!(set.activeS,(12,3),"sidemover2_r")
    # fill vertical movers
    get!(set.active,"verticalmover1_r",(2,3)); get!(set.activeS,(2,3),"verticalmover1_r")
    get!(set.active,"verticalmover2_r",(11,3)); get!(set.activeS,(11,3),"verticalmover2_r")
    # fill rooks
    get!(set.active,"rook1_r",(3,3)); get!(set.activeS,(3,3),"rook1_r")
    get!(set.active,"rook2_r",(10,3)); get!(set.activeS,(10,3),"rook2_r")
    # fill dragon horse
    get!(set.active,"dragonhorse1_r",(4,3)); get!(set.activeS,(4,3),"dragonhorse1_r")
    get!(set.active,"dragonhorse2_r",(9,3)); get!(set.activeS,(9,3),"dragonhorse2_r")
    # fill dragon king
    get!(set.active,"dragonking1_r",(5,3)); get!(set.activeS,(5,3),"dragonking1_r")
    get!(set.active,"dragonking2_r",(8,3)); get!(set.activeS,(8,3),"dragonking2_r")
    # fill queen
    get!(set.active,"queen_r",(7,3)); get!(set.activeS,(7,3),"queen_r")
    # fill reverse chariot
    get!(set.active,"reversechariot1_r",(1,2)); get!(set.activeS,(1,2),"reversechariot1_r")
    get!(set.active,"reversechariot2_r",(12,2)); get!(set.activeS,(12,2),"reversechariot2_r")
    # fill bishops
    get!(set.active,"bishop1_r",(3,2)); get!(set.activeS,(3,2),"bishop1_r")
    get!(set.active,"bishop2_r",(10,2)); get!(set.activeS,(10,2),"bishop2_r")
    # fill blind tigers
    get!(set.active,"blindtiger1_r",(5,2)); get!(set.activeS,(5,2),"blindtiger1_r")
    get!(set.active,"blindtiger2_r",(8,2)); get!(set.activeS,(8,2),"blindtiger2_r")
    # fill phoenix
    get!(set.active,"phoenix_r",(7,2)); get!(set.activeS,(7,2),"phoenix_r")
    # fill kirin
    get!(set.active,"kirin_r",(6,2)); get!(set.activeS,(6,2),"kirin_r")
    # fill lancers
    get!(set.active,"lance1_r",(1,1)); get!(set.activeS,(1,1),"lance1_r")
    get!(set.active,"lance2_r",(12,1)); get!(set.activeS,(12,1),"lance2_r")
    # fill ferocious leopards
    get!(set.active,"ferociousleopard1_r",(2,1)); get!(set.activeS,(2,1),"ferociousleopard1_r")
    get!(set.active,"ferociousleopard2_r",(11,1)); get!(set.activeS,(11,1),"ferociousleopard2_r")
    # fill copper generals
    get!(set.active,"coppergeneral1_r",(3,1)); get!(set.activeS,(3,1),"coppergeneral1_r")
    get!(set.active,"coppergeneral2_r",(10,1)); get!(set.activeS,(10,1),"coppergeneral2_r")
    # fill silver generals
    get!(set.active,"silvergeneral1_r",(4,1)); get!(set.activeS,(4,1),"silvergeneral1_r")
    get!(set.active,"silvergeneral2_r",(9,1)); get!(set.activeS,(9,1),"silvergeneral2_r")
    # fill gold generals
    get!(set.active,"goldgeneral1_r",(5,1)); get!(set.activeS,(5,1),"goldgeneral1_r")
    get!(set.active,"goldgeneral2_r",(8,1)); get!(set.activeS,(8,1),"goldgeneral2_r")
    # fill drunk elephant
    get!(set.active,"drunkelephant_r",(7,1)); get!(set.activeS,(7,1),"drunkelephant_r")
    # fill king
    get!(set.active,"king_r",(6,1)); get!(set.activeS,(6,1),"king_r")
     # fill liioon
    get!(set.active,"lion_r",(6,3)); get!(set.activeS,(6,3),"lion_r")
end
# handles lion killing rules
#function check_lion_kill(enemy::Pieces, )

# checks for promotion, and forces if necessary, otherwise prompts user
function promote_check(set::Pieces, piece, cords)
    list = "PLNSRB"
    if searchindex(list,piece[1]) != 0
        return piece
    elseif set.color == "black"
        # force promotion if pawn or lancer is at furthest rank
        if (piece[1]=='p' && cords[2]==1) || (piece[1]=='l' && cords[2]==1)
            piece = promote(set,piece,cords)
        # force promotion if knight is a furthest 2 ranks
        elseif piece[1]=='n' && (cords[2]==2 || cords[2]==1)
            piece = promote(set,piece,cords)
        # otherwise
        elseif cords[2] < 4 # if piece is on red side
            promptPromote(set,piece,cords)
        end
    else    # set.color == "red"
        # force promotion if pawn or lancer is at furthest rank
        if (piece[1]=='p' && cords[2]==9) || (piece[1]=='l' && cords[2]==9)
            piece = promote(set,piece,cords)
        # force promotion if knight is a furthest 2 ranks
        elseif piece[1]=='n' && (cords[2]==8 || cords[2]==9)
            piece = promote(set,piece,cords)
        # otherwise
        elseif cords[2] > 9 # if piece is on black side
            promptPromote(set,piece,cords)
        end
    end
    return piece
end

# displays game board
function display_board(B::Board,red::Pieces,black::Pieces)
    for i = 1:12
        for j = 1:12
            unit = B.board[i,j]; r = shift_cord(i); c = j
            if unit != "#"
                if unit == "k "
                    print_with_color(:yellow,"$unit ")
                elseif haskey(red.activeS,(c,r)) == true
                    print_with_color(:red,"$unit ")
                else
                    print_with_color(:blue,"$unit ")
                end
            else
                print("$unit  ")
            end
        end
        println()
    end
end


# returns a shifted shogi board coordinate to the array coordinates of B.board
function shift_cord(i::Int)
    return 12-i+1
end


# checks for promotions
function promote_validate(set::Pieces, piece, cords)
    list = "pomvbrhdlatfcsgenx" # pieces possible to promote
    if searchindex(list,piece[1]) != 0
        if set.color == "black" && cords[2] < 5
            return 1
        elseif set.color == "red" && cords[2] > 8
            return 1
        end
    end
    return 0 # execution falls here => invalid promotion
end

function move_piece(B::Board, active::Pieces, inactive::Pieces, piece, cords)
    # replace old location of piece with 'x' on gameboard
    old_cords = active.active[piece]
    set_board(B,Pair("#",old_cords))

    # shift coords
    x = cords[1]; y = shift_cord(cords[2])

    # check for kill
    dead = check_kill(B,inactive,cords)
    if dead != "NULL"
        dead == "l" ? dead = "$(dead)$(piece[1])$(active.turn)" : dead = "$(dead[1])"
        update_hand(active,dead)
    end

    piece = promote_check(active,piece,cords)
    # update location of piece in dict and board
    update_piece(B,active, piece, cords)
    # update turn for chu shogi
    active.turn += 1; inactive.turn += 1
end

function move_piece(active::Pieces, inactive::Pieces, piece, cords)
    # check for kill
    dead = check_kill(inactive,cords)
    if dead != "NULL"
        dead == "l" ? dead = "$(dead)$(piece[1])$(active.turn)" : dead = "$(dead[1])"
        update_hand(active,dead)
    end
    piece = promote_check(active,piece,cords)
    # update location of piece in dict and board
    update_piece(active, piece, cords)
    # update turn for chu shogi
    active.turn += 1; inactive.turn += 1
end

function replay_piece(active::Pieces, inactive::Pieces, piece, cords, promote)
    # check for kill
    dead = check_kill(inactive,cords)
    if dead != "NULL"
        dead == "l" ? dead = "$(dead)$(piece[1])$(active.turn)" : dead = "$(dead[1])"
        update_hand(active,dead)
    end
   promote == 1 && promote_piece(active,piece,cords)
    # update location of piece in dict and board
    update_piece(active, piece, cords)
    # update turn for chu shogi
    active.turn += 1; inactive.turn += 1
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
        dead == "l" ? dead = "$(dead)$(piece[1])$(active.turn)" : dead = "$(dead[1])"
        update_hand(active,dead)
    end
   
    
    piece = promote_AI(active,piece,cords)
    # update location of piece in dict and board
    update_piece(B,active, piece, cords)
    # update turn for chu shogi
    active.turn += 1; inactive.turn += 1
end

function AI_move_piece(active::Pieces, inactive::Pieces, piece, cords)
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
    # update turn for chu shogi
    active.turn += 1; inactive.turn += 1
end


### tests

# GB = Board(fill("#",12,12))
# red = Pieces("red"); fill_red(red)
# black = Pieces("black"); fill_black(black)
# init_board(GB,red,black)

# move_red_c(GB,red,black,"c2",(11,2))

#move_black_p(GB,red,black,"p7",(7,6))
#println(move_lion(GB,red,black,"i",(7,4),(8,5)))
# legal = generate_moves(black,red,"i")
# println(legal)
#move_piece(GB,black,red,"i")
# testing AI
#println(length(minimax_AB(black,red,-Inf,Inf,0,3)))

# testing move promoted dragon horse (horned falcon)
# move_piece(GB,black,red,"h1",(7,6))
# println(move_promoted_h(GB,black,red,"h1",(7,4),0)) # legal
# move_piece(GB,black,red,"h1",(7,6))
# println(move_promoted_h(GB,black,red,"h1",(7,3),0)) # illegal
# println(move_promoted_h(GB,black,red,"h1",(7,5),(7,6))) # legal
# move_piece(GB,black,red,"h1",(7,6))
# println(move_promoted_h(GB,black,red,"h1",(2,1),0)) # legal
# move_piece(GB,black,red,"h1",(7,6))
# println(move_promoted_h(GB,black,red,"h1",(7,6),0)) # illegal
# println(move_promoted_h(GB,black,red,"h1",(12,6),0)) # legal

# # testing move promoted dragon king (soaring eagle)
# move_piece(GB,black,red,"d1",(6,6)) # black side
# println(move_promoted_d(GB,black,red,"d1",(12,6),0)) # illegal
# println(move_promoted_d(GB,black,red,"d1",(8,5),(9,6))) # illegal
# println(move_promoted_d(GB,black,red,"d1",(7,5),(8,4))) # legal
# move_piece(GB,red,black,"d1",(6,6)) # red side
# #println(move_promoted_d(GB,red,black,"d1",(5,7),(4,8))) # legal
# println(move_promoted_d(GB,red,black,"d1",(5,5),(4,4))) # illegal
# println(move_promoted_d(GB,red,black,"d1",(8,4),0)) # legal
# #println(move_promoted_d(GB,red,black,"d1",(5,7),(4,8))) # legal
# #println(move_promoted_d(GB,red,black,"d1",(7,7),(8,8))) # legal

# # testing move/AI lion and lion_kill

# # setting up lion on lion kill scenario
# move_piece(GB,black,red,"i",(6,6)) # black lion
# move_piece(GB,red,black,"i",(5,6)) # red lion 
# move_piece(GB,black,red,"p6",(5,7)) # position red pawn next to black lion
# move_piece(GB,red,black,"d1",(6,6)) # red dragon king kills black lion
# #println(move_lion(GB,red,black,"i",(6,8),0)) # red lion kills black lion
# move_black_p(GB,black,red,"p6",(5,6)) # black pawn kills red lion - ILLEGAL
# display_board(GB,red,black)
#println(move_lion(GB,black,red,"i",(6,6),0)) # illegal








