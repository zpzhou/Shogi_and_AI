# input function
function input()
    return chomp(readline(STDIN))
end

function fill_black{Pieces}(set::Pieces)
    #fill go-betweens
    get!(set.active,"dog1_b",(5,11)); get!(set.activeS,(5,11),"dog1_b")
    get!(set.active,"dog2_b",(12,11)); get!(set.activeS,(12,11),"dog2_b")
    for i = 1:16
        get!(set.active,"pawn$(i)_b",(i,12))
        get!(set.activeS,(i,12),"pawn$(i)_b")
    end
    # fill side movers
    get!(set.active,"sidemover1_b",(1,13)); get!(set.activeS,(1,13),"sidemover1_b")
    get!(set.active,"sidemover2_b",(16,13)); get!(set.activeS,(16,13),"sidemover2_b")
    # fill vertical movers
    get!(set.active,"verticalmover1_b",(2,13)); get!(set.activeS,(2,13),"verticalmover1_b")
    get!(set.active,"verticalmover2_b",(15,13)); get!(set.activeS,(15,13),"verticalmover2_b")
    # fill rooks
    get!(set.active,"rook1_b",(3,13)); get!(set.activeS,(3,13),"rook1_b")
    get!(set.active,"rook2_b",(14,13)); get!(set.activeS,(14,13),"rook2_b")
    # fill dragon horse
    get!(set.active,"hornedfalcon1_b",(4,13)); get!(set.activeS,(4,13),"hornedfalcon1_b")
    get!(set.active,"hornedfalcon2_b",(13,13)); get!(set.activeS,(13,13),"hornedfalcon2_b")
    # fill dragon king
    get!(set.active,"soaringeagle1_b",(5,13)); get!(set.activeS,(5,13),"soaringeagle1_b")
    get!(set.active,"soaringeagle2_b",(12,13)); get!(set.activeS,(12,13),"soaringeagle2_b")
    # biship general
    get!(set.active,"bishopgeneral1_b",(6,13)); get!(set.activeS,(6,13),"bishopgeneral1_b")
    get!(set.active,"bishopgeneral2_b",(11,13)); get!(set.activeS,(11,13),"bishopgeneral2_b")
    # rook general
    get!(set.active,"rookgeneral1_b",(7,13)); get!(set.activeS,(7,13),"rookgeneral1_b")
    get!(set.active,"rookgeneral2_b",(10,13)); get!(set.activeS,(10,13),"rookgeneral2_b")
    # vice general
    get!(set.active,"vicegeneral_b",(8,13)); get!(set.activeS,(8,13),"vicegeneral_b")
    # great general
    get!(set.active,"greatgeneral_b",(9,13)); get!(set.activeS,(9,13),"greatgeneral_b")
    # side soldier
    get!(set.active,"sidesoldier1_b",(1,14)); get!(set.activeS,(1,14),"sidesoldier1_b")
    get!(set.active,"sidesoldier2_b",(16,14)); get!(set.activeS,(16,14),"sidesoldier2_b")
    # vertical soldier
    get!(set.active,"verticalsoldier1_b",(2,14)); get!(set.activeS,(2,14),"verticalsoldier1_b")
    get!(set.active,"verticalsoldier2_b",(15,14)); get!(set.activeS,(15,14),"verticalsoldier2_b")
    # bishop
    get!(set.active,"bishop1_b",(3,14)); get!(set.activeS,(3,14),"bishop1_b")
    get!(set.active,"bishop2_b",(14,14)); get!(set.activeS,(14,14),"bishop2_b")
    # dragon horse
    get!(set.active,"dragonhorse1_b",(4,14)); get!(set.activeS,(4,14),"dragonhorse1_b")
    get!(set.active,"dragonhorse2_b",(13,14)); get!(set.activeS,(13,14),"dragonhorse2_b")
    # dragon king
    get!(set.active,"dragonking1_b",(5,14)); get!(set.activeS,(5,14),"dragonking1_b")
    get!(set.active,"dragonking2_b",(12,14)); get!(set.activeS,(12,14),"dragonking2_b")
    # water buffalo
    get!(set.active,"waterbuffalo1_b",(6,14)); get!(set.activeS,(6,14),"waterbuffalo1_b")
    get!(set.active,"waterbuffalo2_b",(11,14)); get!(set.activeS,(11,14),"waterbuffalo2_b")
    # fire demon
    get!(set.active,"firedemon1_b",(7,14)); get!(set.activeS,(7,14),"firedemon1_b")
    get!(set.active,"firedemon2_b",(10,14)); get!(set.activeS,(10,14),"firedemon2_b")
    # free eagle
    get!(set.active,"freeeagle_b",(8,14)); get!(set.activeS,(8,14),"freeeagle_b")
    # lion hawk
    get!(set.active,"lionhawk_b",(9,14)); get!(set.activeS,(9,14),"lionhawk_b")
    # fill reverse chariot
    get!(set.active,"reversechariot1_b",(1,15)); get!(set.activeS,(1,15),"reversechariot1_b")
    get!(set.active,"reversechariot2_b",(16,15)); get!(set.activeS,(16,15),"reversechariot2_b")
    # fill chariot solder
    get!(set.active,"chariotsoldier1_b",(3,15)); get!(set.activeS,(3,15),"chariotsoldier1_b")
    get!(set.active,"chariotsoldier2_b",(4,15)); get!(set.activeS,(4,15),"chariotsoldier2_b")
    get!(set.active,"chariotsoldier3_b",(14,15)); get!(set.activeS,(14,15),"chariotsoldier3_b")
    get!(set.active,"chariotsoldier4_b",(13,15)); get!(set.activeS,(13,15),"chariotsoldier4_b")
    # fill blind tigers
    get!(set.active,"blindtiger1_b",(6,15)); get!(set.activeS,(6,15),"blindtiger1_b")
    get!(set.active,"blindtiger2_b",(11,15)); get!(set.activeS,(11,15),"blindtiger2_b")
    # fill phoenix
    get!(set.active,"phoenix_b",(7,15)); get!(set.activeS,(7,15),"phoenix_b")
    # fill queen
    get!(set.active,"queen_b",(8,15)); get!(set.activeS,(8,15),"queen_b")
    # fill liioon
    get!(set.active,"lion_b",(9,15)); get!(set.activeS,(9,15),"lion_b")
    # fill kirin
    get!(set.active,"kirin_b",(10,15)); get!(set.activeS,(10,15),"kirin_b")
    # fill lances
    get!(set.active,"lance1_b",(1,16)); get!(set.activeS,(1,16),"lance1_b")
    get!(set.active,"lance2_b",(16,16)); get!(set.activeS,(16,16),"lance2_b")
    # fill knights
    get!(set.active,"knight1_b",(2,16)); get!(set.activeS,(2,16),"knight1_b")
    get!(set.active,"knight2_b",(15,16)); get!(set.activeS,(15,16),"knight2_b")
    # fill ferocious leopards
    get!(set.active,"ferociousleopard1_b",(3,16)); get!(set.activeS,(3,16),"ferociousleopard1_b")
    get!(set.active,"ferociousleopard2_b",(14,16)); get!(set.activeS,(14,16),"ferociousleopard2_b")
    # fill iron generals
    get!(set.active,"irongeneral1_b",(4,16)); get!(set.activeS,(4,16),"irongeneral1_b")
    get!(set.active,"irongeneral2_b",(13,16)); get!(set.activeS,(13,16),"irongeneral2_b")
    # fill copper generals
    get!(set.active,"coppergeneral1_b",(5,16)); get!(set.activeS,(5,16),"coppergeneral1_b")
    get!(set.active,"coppergeneral2_b",(12,16)); get!(set.activeS,(12,16),"coppergeneral2_b")
    # fill silver generals
    get!(set.active,"silvergeneral1_b",(6,16)); get!(set.activeS,(6,16),"silvergeneral1_b")
    get!(set.active,"silvergeneral2_b",(11,16)); get!(set.activeS,(11,16),"silvergeneral2_b")
    # fill gold generals
    get!(set.active,"goldgeneral1_b",(7,16)); get!(set.activeS,(7,16),"goldgeneral1_b")
    get!(set.active,"goldgeneral2_b",(10,16)); get!(set.activeS,(10,16),"goldgeneral2_b")
    # fill drunk elephant
    get!(set.active,"drunkelephant_b",(8,16)); get!(set.activeS,(8,16),"drunkelephant_b")
    # fill king
    get!(set.active,"king_b",(9,16)); get!(set.activeS,(9,16),"king_b")
   
end

function fill_red{Pieces}(set::Pieces)
   #fill go-betweens
    get!(set.active,"dog1_r",(5,6)); get!(set.activeS,(5,6),"dog1_r")
    get!(set.active,"dog2_r",(12,6)); get!(set.activeS,(12,6),"dog2_r")
    for i = 1:16
        get!(set.active,"pawn$(i)_r",(i,5))
        get!(set.activeS,(i,5),"pawn$(i)_r")
    end
    # fill side movers
    get!(set.active,"sidemover1_r",(1,4)); get!(set.activeS,(1,4),"sidemover1_r")
    get!(set.active,"sidemover2_r",(16,4)); get!(set.activeS,(16,4),"sidemover2_r")
    # fill vertical movers
    get!(set.active,"verticalmover1_r",(2,4)); get!(set.activeS,(2,4),"verticalmover1_r")
    get!(set.active,"verticalmover2_r",(15,4)); get!(set.activeS,(15,4),"verticalmover2_r")
    # fill rooks
    get!(set.active,"rook1_r",(3,4)); get!(set.activeS,(3,4),"rook1_r")
    get!(set.active,"rook2_r",(14,4)); get!(set.activeS,(14,4),"rook2_r")
    # fill dragon horse
    get!(set.active,"hornedfalcon1_r",(4,4)); get!(set.activeS,(4,4),"hornedfalcon1_r")
    get!(set.active,"hornedfalcon2_r",(13,4)); get!(set.activeS,(13,4),"hornedfalcon2_r")
    # fill dragon king
    get!(set.active,"soaringeagle1_r",(5,4)); get!(set.activeS,(5,4),"soaringeagle1_r")
    get!(set.active,"soaringeagle2_r",(12,4)); get!(set.activeS,(12,4),"soaringeagle2_r")
    # biship general
    get!(set.active,"bishopgeneral1_r",(6,4)); get!(set.activeS,(6,4),"bishopgeneral1_r")
    get!(set.active,"bishopgeneral2_r",(11,4)); get!(set.activeS,(11,4),"bishopgeneral2_r")
    # rook general
    get!(set.active,"rookgeneral1_r",(7,4)); get!(set.activeS,(7,4),"rookgeneral1_r")
    get!(set.active,"rookgeneral2_r",(10,4)); get!(set.activeS,(10,4),"rookgeneral2_r")
    # vice general
    get!(set.active,"vicegeneral_r",(9,4)); get!(set.activeS,(9,4),"vicegeneral_r")
    # great general
    get!(set.active,"greatgeneral_r",(8,4)); get!(set.activeS,(8,4),"greatgeneral_r")
    # side soldier
    get!(set.active,"sidesoldier1_r",(1,3)); get!(set.activeS,(1,3),"sidesoldier1_r")
    get!(set.active,"sidesoldier2_r",(16,3)); get!(set.activeS,(16,3),"sidesoldier2_r")
    # vertical soldier
    get!(set.active,"verticalsoldier1_r",(2,3)); get!(set.activeS,(2,3),"verticalsoldier1_r")
    get!(set.active,"verticalsoldier2_r",(15,3)); get!(set.activeS,(15,3),"verticalsoldier2_r")
    # bishop
    get!(set.active,"bishop1_r",(3,3)); get!(set.activeS,(3,3),"bishop1_r")
    get!(set.active,"bishop2_r",(14,3)); get!(set.activeS,(14,3),"bishop2_r")
    # dragon horse
    get!(set.active,"dragonhorse1_r",(4,3)); get!(set.activeS,(4,3),"dragonhorse1_r")
    get!(set.active,"dragonhorse2_r",(13,3)); get!(set.activeS,(13,3),"dragonhorse2_r")
    # dragon king
    get!(set.active,"dragonking1_r",(5,3)); get!(set.activeS,(5,3),"dragonking1_r")
    get!(set.active,"dragonking2_r",(12,3)); get!(set.activeS,(12,3),"dragonking2_r")
    # water buffalo
    get!(set.active,"waterbuffalo1_r",(6,3)); get!(set.activeS,(6,3),"waterbuffalo1_r")
    get!(set.active,"waterbuffalo2_r",(11,3)); get!(set.activeS,(11,3),"waterbuffalo2_r")
    # fire demon
    get!(set.active,"firedemon1_r",(7,3)); get!(set.activeS,(7,3),"firedemon1_r")
    get!(set.active,"firedemon2_r",(10,3)); get!(set.activeS,(10,3),"firedemon2_r")
    # free eagle
    get!(set.active,"freeeagle_r",(9,3)); get!(set.activeS,(9,3),"freeeagle_r")
    # lion hawk
    get!(set.active,"lionhawk_r",(8,3)); get!(set.activeS,(8,3),"lionhawk_r")
    # fill reverse chariot
    get!(set.active,"reversechariot1_r",(1,2)); get!(set.activeS,(1,2),"reversechariot1_r")
    get!(set.active,"reversechariot2_r",(16,2)); get!(set.activeS,(16,2),"reversechariot2_r")
    # fill chariot solder
    get!(set.active,"chariotsoldier1_r",(3,2)); get!(set.activeS,(3,2),"chariotsoldier1_r")
    get!(set.active,"chariotsoldier2_r",(4,2)); get!(set.activeS,(4,2),"chariotsoldier2_r")
    get!(set.active,"chariotsoldier3_r",(14,2)); get!(set.activeS,(14,2),"chariotsoldier3_r")
    get!(set.active,"chariotsoldier4_r",(13,2)); get!(set.activeS,(13,2),"chariotsoldier4_r")
    # fill blind tigers
    get!(set.active,"blindtiger1_r",(6,2)); get!(set.activeS,(6,2),"blindtiger1_r")
    get!(set.active,"blindtiger2_r",(11,2)); get!(set.activeS,(11,2),"blindtiger2_r")
    # fill phoenix
    get!(set.active,"phoenix_r",(10,2)); get!(set.activeS,(10,2),"phoenix_r")
    # fill queen
    get!(set.active,"queen_r",(9,2)); get!(set.activeS,(9,2),"queen_r")
    # fill liioon
    get!(set.active,"lion_r",(8,2)); get!(set.activeS,(8,2),"lion_r")
    # fill kirin
    get!(set.active,"kirin_r",(7,2)); get!(set.activeS,(7,2),"kirin_r")
    # fill lances
    get!(set.active,"lance1_r",(1,1)); get!(set.activeS,(1,1),"lance1_r")
    get!(set.active,"lance2_r",(16,1)); get!(set.activeS,(16,1),"lance2_r")
    # fill knights
    get!(set.active,"knight1_r",(2,1)); get!(set.activeS,(2,1),"knight1_r")
    get!(set.active,"knight2_r",(15,1)); get!(set.activeS,(15,1),"knight2_r")
    # fill ferocious leopards
    get!(set.active,"ferociousleopard1_r",(3,1)); get!(set.activeS,(3,1),"ferociousleopard1_r")
    get!(set.active,"ferociousleopard2_r",(14,1)); get!(set.activeS,(14,1),"ferociousleopard2_r")
    # fill iron generals
    get!(set.active,"irongeneral1_r",(4,1)); get!(set.activeS,(4,1),"irongeneral1_r")
    get!(set.active,"irongeneral2_r",(13,1)); get!(set.activeS,(13,1),"irongeneral2_r")
    # fill copper generals
    get!(set.active,"coppergeneral1_r",(5,1)); get!(set.activeS,(5,1),"coppergeneral1_r")
    get!(set.active,"coppergeneral2_r",(12,1)); get!(set.activeS,(12,1),"coppergeneral2_r")
    # fill silver generals
    get!(set.active,"silvergeneral1_r",(6,1)); get!(set.activeS,(6,1),"silvergeneral1_r")
    get!(set.active,"silvergeneral2_r",(11,1)); get!(set.activeS,(11,1),"silvergeneral2_r")
    # fill gold generals
    get!(set.active,"goldgeneral1_r",(7,1)); get!(set.activeS,(7,1),"goldgeneral1_r")
    get!(set.active,"goldgeneral2_r",(10,1)); get!(set.activeS,(10,1),"goldgeneral2_r")
    # fill drunk elephant
    get!(set.active,"drunkelephant_r",(9,1)); get!(set.activeS,(9,1),"drunkelephant_r")
    # fill king
    get!(set.active,"king_r",(8,1)); get!(set.activeS,(8,1),"king_r")
   
end

# checks for promotion, and forces if necessary, otherwise prompts user
function promote_check(set::Pieces, piece, cords)
    list = ["waterbuffalo","rookgeneral","bishopgeneral","queen","lion",
            "soaringeagle","hornedfalcon","chariotsolder","dragonking",
            "dragonhorse","rook","verticalsoldier","sidersoldier","bishop",
            "verticalmover","sidemover","phoenix","kirin","lancer",
            "reversechariot","drunkelephant","goldgeneral","ferociousleapord",
            "blindtiger","silvergeneral","coppergeneral","irongeneral",
            "knight","dog","pawn"]
    if findfirst(list,chop(piece)) == 0
        return piece
    elseif set.color == "black"
        # force promotion if pawn or lancer is at furthest rank
        if (chop(piece)=="pawn" && cords[2]==1) || (chop(piece)=="lancer" && cords[2]==1)
            piece = promote_piece(set,piece,cords)
        # force promotion if knight is a furthest 2 ranks
        elseif chop(piece)=="knight" && (cords[2]==2 || cords[2]==1)
            piece = promote_piece(set,piece,cords)
        # otherwise
        elseif cords[2] < 6 # if piece is on red side
            promptPromote(set,piece,cords)
        end
    else    # set.color == "red"
        # force promotion if pawn or lancer is at furthest rank
        if (chop(piece)=="pawn" && cords[2]==16) || (chop(piece)=="lancer" && cords[2]==16)
            piece = promote_piece(set,piece,cords)
        # force promotion if knight is a furthest 2 ranks
        elseif chop(piece)=="knight" && (cords[2]==15 || cords[2]==16)
            piece = promote_piece(set,piece,cords)
        # otherwise
        elseif cords[2] > 10 # if piece is on black side
            promptPromote(set,piece,cords)
        end
    end
    return piece
end

# displays game board
function display_board(B::Board,red::Pieces,black::Pieces)
    for i = 1:16
        for j = 1:16
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
    return 16-i+1
end

# checks for promotions
function promote_validate(set::Pieces, piece, cords)
   list = ["waterbuffalo","rookgeneral","bishopgeneral","queen","lion",
            "soaringeagle","hornedfalcon","chariotsolder","dragonking",
            "dragonhorse","rook","verticalsoldier","sidersoldier","bishop",
            "verticalmover","sidemover","phoenix","kirin","lancer",
            "reversechariot","drunkelephant","goldgeneral","ferociousleapord",
            "blindtiger","silvergeneral","coppergeneral","irongeneral",
            "knight","dog","pawn"]
    if findfirst(list,chop(piece)) != 0
        if set.color == "black" && cords[2] < 6
            return 1
        elseif set.color == "red" && cords[2] > 10
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

    passive_burn(B,active,inactive,old_cords,cords) == 1 && return
    piece = promote_check(active,piece,cords)
    # update location of piece in dict and board
    update_piece(B,active, piece, cords)
end

function move_piece(active::Pieces, inactive::Pieces, piece, cords)
    old_cords = active.active[piece]
    # check for kill
    dead = check_kill(inactive,cords)
    if dead != "NULL"
        dead == "l" ? dead = "$(dead)$(piece[1])$(active.turn)" : dead = "$(dead[1])"
        update_hand(active,dead)
    end

    passive_burn(active,inactive,old_cords,cords) == 1 && return
    piece = promote_check(active,piece,cords)
    # update location of piece in dict and board
    update_piece(active, piece, cords)  
end

function replay_piece(active::Pieces, inactive::Pieces, piece, cords, promote)
    old_cords = active.active[piece]
    # check for kill
    dead = check_kill(inactive,cords)
    if dead != "NULL"
        dead == "l" ? dead = "$(dead)$(piece[1])$(active.turn)" : dead = "$(dead[1])"
        update_hand(active,dead)
    end

    passive_burn(active,inactive,old_cords,cords) == 1 && return
    promote == 1 && promote_piece(active,piece,cords)
    # update location of piece in dict and board
    update_piece(active, piece, cords)  
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
   
    passive_burn(B,active,inactive,old_cords,cords) == 1 && return
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
   
    passive_burn(active,inactive,old_cords,cords) == 1 && return
    piece = promote_AI(active,piece,cords)
    # update location of piece in dict and board
    update_piece(active,piece, cords)
end

### testing
# GB = Board(fill("#",16,16))
# red = Pieces("red"); fill_red(red)
# black = Pieces("black"); fill_black(black)
# init_board(GB,red,black)

# testing multigeneral
# move_piece(GB,red,black,"dog1",(9,9))
# println(move_multi_general(GB,red,black,"dog1",(9,9)))

# testing water buffalo
# move_piece(GB,red,black,"waterbuffalo1",(9,9))
# println(move_water_buffalo(GB,red,black,"waterbuffalo1",(9,9)))

# testing fire demon
# move_piece(GB,red,black,"firedemon1",(9,9))
# println(move_fire_demon(GB,red,black,"firedemon1",(8,8),(9,9),(11,11)))

# testing heavenly tetrarch
# move_piece(GB,red,black,"chariotsoldier1",(9,9))
# println(move_heavenly_tetrarch(GB,red,black,"chariotsoldier1",(10,10),(9,9),0))

# testing free eagle
# move_piece(GB,red,black,"freeeagle",(9,9))
# move_piece(GB,red,black,"pawn1",(9,10))
# println(move_free_eagle(GB,red,black,"freeeagle",(9,11),0))

# testing lion hawk
# move_piece(GB,red,black,"lionhawk",(9,9))
# println(move_lion_hawk(GB,red,black,"lionhawk",(12,12),0))

# testing firedemon burn
# move_piece(GB,red,black,"firedemon1",(9,9))
# # set up pawns to be burned
# move_piece(GB,black,red,"pawn1",(10,11))
# move_piece(GB,black,red,"pawn2",(11,11))
# move_piece(GB,black,red,"pawn3",(11,10))
# move_piece(GB,black,red,"pawn4",(11,9))
# move_piece(GB,black,red,"pawn5",(10,9))
# move_piece(GB,black,red,"pawn6",(9,10))
# move_piece(GB,black,red,"pawn7",(9,11))
# println(move_fire_demon(GB,red,black,"firedemon1",(8,8),(9,9),(10,10)))
# println(red.captured)


# testing bishop general
# move_piece(GB,red,black,"bishopgeneral1",(9,9))
# move_piece(GB,red,black,"rookgeneral1",(10,10))
# println(move_bishop_general(GB,red,black,"bishopgeneral1",(12,12)))

# testing rook general
# move_piece(GB,red,black,"rookgeneral1",(9,9))
# move_piece(GB,red,black,"bishopgeneral1",(9,10))
# println(move_rook_general(GB,red,black,"rookgeneral1",(9,12)))

# testing vice general
# move_piece(GB,red,black,"vicegeneral1",(9,9))
# move_piece(GB,black,red,"pawn1",(10,11))
# println(move_vice_general(GB,red,black,"vicegeneral1",(9,10),(10,11),(11,12)))

# testing side soldier
# move_piece(GB,black,red,"sidesoldier1",(9,9))
# println(move_black_side_soldier(GB,black,red,"sidesoldier1",(9,11)))

# testing vertical soldier
# move_piece(GB,black,red,"verticalsoldier1",(9,9))
# println(move_black_vertical_soldier(GB,black,red,"verticalsoldier1",(9,1)))






