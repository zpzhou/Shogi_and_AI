function validate_black(set::Pieces, enemy::Pieces, piece, source, cords, cords2, cords3)
  piece == "" && return 0
  haskey(set.active,piece) == 0 && return 0
  set.active[piece] != source && return 0
  if contains(piece, "pawn") || contains(piece, "Pawn")
        flag = move_black_p(set,enemy,piece,cords) 
  elseif contains(piece, "king")
        flag = move_k(set,enemy,piece,cords) 
  elseif contains(piece, "queen")
        flag = move_q(set,enemy,piece,cords) 
  elseif contains(piece, "lion")
        cords == cords2 ?
            flag = move_lion(set,enemy,piece,cords,0) :
            flag = move_lion(set,enemy,piece,cords,cords2)
  elseif contains(piece, "dragonking") || contains(piece, "Dragonking")
    cords == cords2 ?
            flag = move_d(set,enemy,piece,cords,0) :
            flag = move_d(set,enemy,piece,cords,cords2)
  elseif contains(piece, "dragonhorse") || contains(piece, "Dragonhorse")
    cords == cords2 ?
            flag = move_h(set,enemy,piece,cords,0) :
            flag = move_h(set,enemy,piece,cords,cords2)
  elseif contains(piece, "kirin") || contains(piece, "Kirin")
    cords == cords2 ?
            flag = move_n(set,enemy,piece,cords,0) :
            flag = move_n(set,enemy,piece,cords,cords2)
  elseif contains(piece, "phoenix") || contains(piece, "Phoenix")
    cords == cords2 ?
            flag = move_x(set,enemy,piece,cords,0) :
            flag = move_x(set,enemy,piece,cords,cords2)
  elseif contains(piece, "drunkelephant") || contains(piece, "Drunkelephant")
        flag = move_black_e(set,enemy,piece,cords) 
  elseif contains(piece, "blindtiger") || contains(piece, "Blindtiger")
        flag = move_black_t(set,enemy,piece,cords) 
  elseif contains(piece, "ferociousleopard") || contains(piece, "Ferociousleopard")
        flag = move_f(set,enemy,piece,cords) 
  elseif contains(piece, "verticalmover") || contains(piece, "Verticalmover")
        flag = move_v(set,enemy,piece,cords) 
  elseif contains(piece, "sidemover") || contains(piece, "Sidermover")
        flag = move_m(set,enemy,piece,cords) 
  elseif contains(piece, "reversechariot") || contains(piece, "Reversechariot")
        flag = move_a(set,enemy,piece,cords) 
  elseif contains(piece, "gobetween") || contains(piece, "Gobetween")
        println("yes")
        flag = move_o(set,enemy,piece,cords) 
  elseif contains(piece, "goldgeneral") || contains(piece, "Goldgeneral")
      flag = move_black_g(set,enemy,piece,cords)
  elseif contains(piece, "silvergeneral") || contains(piece, "Silvergeneral")
      flag = move_black_s(set,enemy,piece,cords) 
  elseif contains(piece, "coppergeneral") || contains(piece, "Coppergeneral")
      flag = move_black_c(set,enemy,piece,cords) 
  elseif contains(piece, "bishop") || contains(piece, "Bishop")
      flag = move_bishop(set,enemy,piece,cords) 
  elseif contains(piece, "rook") || contains(piece, "Rook")
      flag = move_rook(set,enemy,piece,cords) 
  elseif contains(piece, "lance") || contains(piece, "Lance")
      flag = move_b_l(set,enemy,piece,cords) 
  end
  return flag
end

function validate_red(set::Pieces, enemy::Pieces, piece, source, cords, cords2, cords3)
  piece == "" && return 0
  haskey(set.active,piece) == 0 && return 0
  set.active[piece] != source && return 0  
  if contains(piece, "pawn") || contains(piece, "Pawn")
        flag = move_red_p(set,enemy,piece,cords) 
  elseif contains(piece, "king")
        flag = move_k(set,enemy,piece,cords) 
  elseif contains(piece, "queen")
        flag = move_q(set,enemy,piece,cords) 
  elseif contains(piece, "lion")
        cords == cords2 ?
            flag = move_lion(set,enemy,piece,cords,0) :
            flag = move_lion(set,enemy,piece,cords,cords2) 
  elseif contains(piece, "dragonking") || contains(piece, "Dragonking")
        cords == cords2 ?
            flag = move_d(set,enemy,piece,cords,0) :
            flag = move_d(set,enemy,piece,cords,cords2) 
  elseif contains(piece, "dragonhorse") || contains(piece, "Dragonhorse")
        cords == cords2 ?
            flag = move_h(set,enemy,piece,cords,0) :
            flag = move_h(set,enemy,piece,cords,cords2)  
  elseif contains(piece, "kirin") || contains(piece, "Kirin")
    cords == cords2 ?
            flag = move_n(set,enemy,piece,cords,0) :
            flag = move_n(set,enemy,piece,cords,cords2) 
  elseif contains(piece, "phoenix") || contains(piece, "Phoenix")
    cords == cords2 ?
            flag = move_x(set,enemy,piece,cords,0) :
            flag = move_x(set,enemy,piece,cords,cords2) 
  elseif contains(piece, "drunkelephant") || contains(piece, "Drunkelephant")
        flag = move_red_e(set,enemy,piece,cords) 
  elseif contains(piece, "blindtiger") || contains(piece, "Blindtiger")
        flag = move_red_t(set,enemy,piece,cords) 
  elseif contains(piece, "ferociousleopard") || contains(piece, "Ferociousleopard")
        flag = move_f(set,enemy,piece,cords) 
  elseif contains(piece, "verticalmover") || contains(piece, "Verticalmover")
        flag = move_v(set,enemy,piece,cords) 
  elseif contains(piece, "sidemover") || contains(piece, "Sidermover")
        flag = move_m(set,enemy,piece,cords) 
  elseif contains(piece, "reversechariot") || contains(piece, "Reversechariot")
        flag = move_a(set,enemy,piece,cords) 
  elseif contains(piece, "gobetween") || contains(piece, "Gobetween")
        flag = move_o(set,enemy,piece,cords) 
  elseif contains(piece, "goldgeneral") || contains(piece, "Goldgeneral")
      flag = move_red_g(set,enemy,piece,cords)
  elseif contains(piece, "silvergeneral") || contains(piece, "Silvergeneral")
      flag = move_red_s(set,enemy,piece,cords) 
  elseif contains(piece, "coppergeneral") || contains(piece, "Coppergeneral")
      flag = move_red_c(set,enemy,piece,cords) 
  elseif contains(piece, "bishop") || contains(piece, "Bishop")
      flag = move_bishop(set,enemy,piece,cords) 
  elseif contains(piece, "rook") || contains(piece, "Rook")
      flag = move_rook(set,enemy,piece,cords) 
  elseif contains(piece, "lance") || contains(piece, "Lance")
      flag = move_red_l(set,enemy,piece,cords) 
  end
  return flag
end




# this function will be called if the coordinate where piece is moving to 
# is occupied by a liooon.
function lion_kill(set::Pieces, enemy::Pieces, piece::ASCIIString,cords,dead)
    if contains(piece,"lion") # lion on lion violence
        lion = enemy.activeS[cords]
        pop!(enemy.activeS,cords)
        if dead != "NULL" 
            dead_cords = enemy.active[dead]
            pop!(enemy.activeS,dead_cords) 
        end
        A = collect(keys(enemy.active))
        for i = 1:length(A)
            (A[i] == lion || A[i] == dead) && continue
            piece = ASCIIString(A[i]); 
            legal = generate_moves(enemy,set,piece)
            if findfirst(legal,cords) != 0 
                if contains(dead,"pawn") || contains(dead,"gobetween") || dead == "NULL"
                    get!(enemy.activeS,cords,lion)
                    dead != "NULL" && get!(enemy.activeS,dead_cords,dead)
                    return 0
                else 
                    get!(enemy.activeS,cords,lion)
                    dead != "NULL" && get!(enemy.activeS,dead_cords,dead)
                    break 
                end
            end
        end
        return 1
    else # non lion cant kill if lion was killed by non lion the previous turn
        if length(enemy.captured) != 0
            dead_lion = last(enemy.captured)
            prev_turn = parse(Int,dead_lion[3:length(dead_lion)])              
            (contains(dead_lion[2]), "lion") && (set.turn - prev_turn == 1) ? (return 0) : (return 1)
        end
        return 1
    end
end

function check_bounds(x::Int64, y::Int64)
    # check bounds
    if x < 1 || x > 12 
        return 0
    elseif y < 1 || y > 12
        return 0
    else return 1
    end
end

function top_right(set::Pieces, enemy::Pieces, source, target)
    xi = source[1]; yi = source[2]
    x = target[1]; y = target[2]
    delta = abs(x-xi)
    for i = 1:delta
        new_cords::Tuple{Int64,Int64} = (xi+i,yi+i)
        if haskey(enemy.activeS,new_cords) == true # if enemy is in the way
            return new_cords
            # println("illegal move")
            # return
        elseif haskey(set.activeS,new_cords) == true
            return 0
        end
    end
    return target
end

function bottom_right(set::Pieces, enemy::Pieces, source, target)
    xi = source[1]; yi = source[2]
    x = target[1]; y = target[2]
    delta = abs(x-xi)
    for i = 1:(delta-1)
        new_cords::Tuple{Int64,Int64} = (xi+i,yi-i)
        if haskey(enemy.activeS,new_cords) == true
            return new_cords
            # return 0
        elseif haskey(set.activeS,new_cords) == true
            return 0
        end
    end
    return target
end

function bottom_left(set::Pieces, enemy::Pieces, source, target)
    xi = source[1]; yi = source[2]
    x = target[1]; y = target[2]
    delta = abs(x-xi)
    for i = 1:(delta-1)
        new_cords::Tuple{Int64,Int64} = (xi-i,yi-i)
        if haskey(enemy.activeS,new_cords) == true
            return new_cords
            # return 0
        elseif haskey(set.activeS,new_cords) == true
            return 0
        end
    end
    return target
end

function top_left(set::Pieces, enemy::Pieces, source, target)
    xi = source[1]; yi = source[2]
    x = target[1]; y = target[2]
    delta = abs(x-xi)
    for i = 1:delta
        new_cords::Tuple{Int64,Int64} = (xi-i,yi+i)
        if haskey(enemy.activeS,new_cords) == true # if enemy is in the way
            return new_cords
        elseif haskey(set.activeS,new_cords) == true
            return 0
        end
    end
    return target
end

function horizontal(set::Pieces, enemy::Pieces, source, target)
    xi = source[1]; yi = source[2]
    x = target[1]; y = target[2]
    delta = x-xi
    delta < 0 ? inc = -1 : inc = 1
    for i = (xi+inc):inc:x
        new_cords::Tuple{Int64,Int64} = (i,y)
        if haskey(enemy.activeS,new_cords) == true # if enemy blocking path
            return new_cords
        elseif haskey(set.activeS,new_cords) == true # if friendly blocking path
            return 0
        end
    end
    return target
end

function vertical(set::Pieces, enemy::Pieces, source, target)
     xi = source[1]; yi = source[2]
    x = target[1]; y = target[2]
    delta = x-xi
    delta < 0 ? inc = -1 : inc = 1
    for i = (yi+inc):inc:y
        new_cords::Tuple{Int64,Int64} = (x,i)
        if haskey(enemy.activeS,new_cords) == true # if enemy blocking path
            return new_cords
        elseif haskey(set.activeS,new_cords) == true # if friendly blocking path
            return 0
        end
    end
    return target
end
# pawn
function move_red_p(set::Pieces, inactive::Pieces, piece, cords)
    # stores coordinates of legal moves
    legal = Tuple{Int,Int}[] 
    # initial legal cords
    x = set.active[piece][1]; y = set.active[piece][2]

    # check if given coordinates equal to current coordinates
    if cords == set.active[piece]
        return 0
    end

    if haskey(inactive.activeS,cords) == true  && inactive.activeS[cords] == "lion" 
        lion_kill(set,inactive,piece,cords,"NULL") == 0 && return 0
    end

    # basic move both unpromoted and promoted can make
    if y != 12 && haskey(set.activeS,(x,y+1)) == 0
        push!(legal,(x,y+1)) # add this location to list of possible ones
    end

    # if pawn is unpromoted, there is only one possible move: (x,y+1)
    if piece[1] == 'p'
        length(legal) == 0 && return 0
        if cords == legal[1] 
            move_piece(set,inactive,piece,cords); return 1;
        else
            return 0;
        end
    else # pawn is promoted to gold general - shiiiet 
        if y != 12 && x != 12 && x != 1 
            haskey(set.activeS,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
            haskey(set.activeS,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
            # add left and right movement
            haskey(set.activeS,(x+1,y)) == 0 && push!(legal,(x+1,y))
            haskey(set.activeS,(x-1,y)) == 0 && push!(legal,(x-1,y))
        elseif y == 12 && x != 12 && x != 1
            haskey(set.activeS,(x-1,y)) == 0 && push!(legal,(x-1,y))
            haskey(set.activeS,(x+1,y)) == 0 && push!(legal,(x+1,y))
        elseif y != 12 && x == 12 # if piece is on left side of board, and y != 12
            haskey(set.activeS,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
            haskey(set.activeS,(x,y+1)) == 0 && push!(legal,(x,y+1))
            haskey(set.activeS,(x-1,y)) == 0 && push!(legal,(x-1,y))
        elseif y != 12 && x == 1 # if piece is on right side of board, and y != 12
            haskey(set.activeS,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
            haskey(set.activeS,(x,y+1)) == 0 && push!(legal,(x,y+1))
            haskey(set.activeS,(x+1,y)) == 0 && push!(legal,(x+1,y))
        elseif x == 12 # if y == 12 and x == 12
            haskey(set.activeS,(x-1,y)) == 0 && push!(legal,(x-1,y))
        elseif x == 1 # if x == 1 and y = 12
            haskey(set.activeS,(x+1,y)) == 0 && push!(legal,(x+1,y))
        end
        # adds the backsetp allowable coordinates
        if y != 1
            haskey(set.activeS,(x,y-1)) == 0 && push!(legal,(x,y-1))
        end
        # check if user input matches a legal move
        if findfirst(legal,cords) != 0 
            move_piece(set, inactive, piece, cords); return 1
        else
            return 0
        end
    end
end

function move_black_p(set::Pieces, inactive::Pieces, piece, cords)
    # stores coordinates of legal moves
    legal = Tuple{Int,Int}[] 
    # initial legal cords
    x = set.active[piece][1]; y = set.active[piece][2]

    # check if given coordinates equal to current coordinates
    if cords == set.active[piece]
        return 0
    end

    if haskey(inactive.activeS,cords) == true  && inactive.activeS[cords] == "lion" 
        lion_kill(set,inactive,piece,cords,"NULL") == 0 && return 0
    end

    # basic move both unpromoted and promoted can make
    if y != 1 && haskey(set.activeS,(x,y-1)) == 0
        push!(legal,(x,y-1)) # add this location to list of possible ones
    end

    # if pawn is unpromoted, there is only one possible move: (x,y-1)
    if piece[1] == 'p'
        length(legal) == 0 && return 0
        if cords == legal[1] 
            move_piece(set,inactive,piece,cords); return 1;
        else
            return 0;
        end
    else # pawn is promoted to gold general - shiiiet 
        if y != 1 && x != 1 && x != 12 
            haskey(set.activeS,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
            haskey(set.activeS,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
            # add left and right movement
            haskey(set.activeS,(x+1,y)) == 0 && push!(legal,(x+1,y))
            haskey(set.activeS,(x-1,y)) == 0 && push!(legal,(x-1,y))
        elseif y == 1 && x != 1 && x != 12
            haskey(set.activeS,(x-1,y)) == 0 && push!(legal,(x-1,y))
            haskey(set.activeS,(x+1,y)) == 0 && push!(legal,(x+1,y))
        elseif y != 1 && x == 12 # if piece is on left side of board, and y != 1
            haskey(set.activeS,(x-1,y-1)) == 0 && push!(legal,(x-1,y+1))
            haskey(set.activeS,(x-1,y)) == 0 && push!(legal,(x-1,y))
        elseif y != 1 && x == 1 # if piece is on right side of board, and y != 1
            haskey(set.activeS,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
            haskey(set.activeS,(x+1,y)) == 0 && push!(legal,(x+1,y))
        elseif x == 12 # if x == 12 and y == 1
            haskey(set.activeS,(x-1,y)) == 0 && push!(legal,(x-1,y))
        elseif x == 1 # if x == 1 and y = 1
            haskey(set.activeS,(x+1,y)) == 0 && push!(legal,(x+1,y))
        end
        # adds the backsetp allowable coordinates
        if y != 12
            haskey(set.activeS,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end
        # check if user input matches a legal move
        if findfirst(legal,cords) != 0 
            move_piece( set, inactive, piece, cords); return 1
        else 
            return 0
        end
    end
end

# go-betweens
function move_o(set::Pieces, enemy::Pieces, piece, cords)
    # initial cords
    x = set.active[piece][1]; y = set.active[piece][2]
    check_bounds(cords[1],cords[2]) == 0 && return 0
    y == cords[2] && (return 0)
    if haskey(set.activeS,cords) == true
            return 0
    elseif piece[1] == 'G'
        set.color == "black" ?
            flag = move_black_e(set,enemy,piece,cords) :
            flag = move_red_e(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif cords[1] != x && abs(y-cords[2]) != 1 
        return 0
    else
        if haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
            lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
        end
        move_piece(set,enemy,piece,cords); return 1
    end
end 

# Side movers
function move_m(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif piece[1] == 'S'
        flag = move_promoted_m(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    # vertical movement
    elseif delta_x == 0 && abs(delta_y) == 1 
        if haskey(set.activeS,cords) == true
            return 0
        else
            move_piece(set,enemy,piece,cords); return 1
        end
    # horizontal movemement
    elseif delta_x != 0 && delta_y == 0
        cords = horizontal(set,enemy,(xi,yi),cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0
        end
    else return 0
    end
end

# Vertical movers
function move_v(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'V'
        flag = move_promoted_v(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    # horizontal movement
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif delta_y == 0 && abs(delta_x) == 1
        if haskey(set.activeS,cords) == true
            return 0
        else
            move_piece(set,enemy,piece,cords); return 1
        end
    # vertical movement
    elseif delta_y != 0 && delta_x == 0 # vertical movement
        cords = vertical(set,enemy,(xi,yi),cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0
        end
    else return 0
    end
end

# bishops
function move_bishop(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences 
    delta_x = x-xi; delta_y = y-yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    end
    # otherwise compare if unequal => illegal
    if abs(delta_x) != abs(delta_y)
        # check if promoted to DRAGON HORSE!!!
        if piece[1] == 'B'
            if haskey(set.activeS,cords) == true
                return 0
            elseif delta_x <= 1 && delta_y <= 1
                move_piece(set,enemy,piece,cords); return 1
            else
                return 0
            end
        else
            return 0
        end
    # if moving towards top right (9,9)
    elseif x > xi && y > yi
        cords = top_right(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    # if moving towards bottom right (9,1)
    elseif x > xi && y < yi
        cords = bottom_right(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    # if moving towards bottom left (1,1)
    elseif x < xi && y < yi 
        cords = bottom_left(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0
        end
    # if moving towards top left (1,9)
    elseif x < xi && y > yi 
        cords = top_left(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0
        end
    end
end

# rook
function move_rook(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    end
    #inc::Int64 # used in for loops
    if delta_x != 0 && delta_y != 0 # illegal movement
        if piece[1] == 'R'
            if haskey(set.activeS,cords) == true
                return 0
            elseif abs(delta_x) <= 1 && abs(delta_y <= 1)
                move_piece(set,enemy,piece,cords); return 1
            else
                return 0
            end
        else
            return 0
        end
    elseif delta_x != 0 # horizontal movemement
        cords = horizontal(set,enemy,(xi,yi),cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    elseif delta_y != 0 # vertical movement
       cords = vertical(set,enemy,(xi,yi),cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    else 
        return 0 
    end
end

# dragon horse == promoted bishop
function move_h(set::Pieces, enemy::Pieces, piece, cords, cords2)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # check for out of bounds
    if x < 1 || x > 9 
        return 0
    elseif y < 1 || y > 9
        return 0
    end
    # take differences 
    delta_x = abs(x-xi); delta_y = abs(y-yi)
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    end
    if piece[1] == 'D'
        flag = move_promoted_h(set,enemy,piece,cords,cords2)
        flag == 1 ? (return 1) : (return 0)
    elseif delta_x != delta_y
        if haskey(set.activeS,cords) == true
            return 0
        elseif delta_x <= 1 && delta_y <= 1
            move_piece(set,enemy,piece,cords); return 1
        else
            return 0
        end
    # if moving towards top right (9,9)
    elseif x > xi && y > yi
        cords = top_right(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    # if moving towards bottom right (9,1)
    elseif x > xi && y < yi
        cords = bottom_right(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    # if moving towards bottom left (1,1)
    elseif x < xi && y < yi 
        cords = bottom_left(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    # if moving towards top left (1,9)
    elseif x < xi && y > yi 
        cords = top_left(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    end
end

# dragon king 
function move_d(set::Pieces, enemy::Pieces, piece, cords, cords2)
# initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2]
    source = (xi,yi) 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    end
    #inc::Int64 # used in for loops
    if piece[1] == 'D'
        flag = move_promoted_d(set,enemy,piece,cords,cords2)
        flag == 1 ? (return 1) : (return 0)
    elseif delta_x != 0 && delta_y != 0 
        if haskey(set.activeS,cords) == true
            return 0
        elseif abs(delta_x) <= 1 && abs(delta_y <= 1)
            move_piece(set,enemy,piece,cords); return 1
        else
            return 0
        end
    elseif delta_x != 0 # horizontal movemement
        cords = horizontal(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    elseif delta_y != 0 # vertical movement
        cords = vertical(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    end
end

# lancers
function move_b_l(set::Pieces, enemy::Pieces, piece, cords)
    # check if promoted
    if piece[1] == 'L'
        flag = move_promoted_a(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    end
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif delta_x != 0 # illegal movement
        return 0
    elseif delta_y > 0 # backwards movement
        return 0
    else
        cords = vertical(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    end
end

function move_red_l(set::Pieces, enemy::Pieces, piece, cords)
    # check if promoted
    if piece[1] == 'L'
        flag = move_promoted_l(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    end
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif delta_x != 0 # illegal movement
        return 0
    elseif delta_y < 0 # backwards movement
        return 0
    else
       cords = vertical(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    end
end

# reverse chariot
function move_a(set::Pieces, enemy::Pieces, piece, cords)
    if piece[1] == 'R'
        if set.color == "black"
            flag = move_promoted_l(set,enemy,piece,cords)
            flag == 1 ? (return 1) : (return 0)
        else
            flag = move_promoted_a(set,enemy,piece,cords)
            flag == 1 ? (return 1) : (return 0)
        end
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    check_bounds(x,y) == 0 && return 0
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    # check for illegal horizontal movement
    elseif delta_x != 0
        return 0
    elseif abs(delta_y) > 0 # vertical movement
        cords = vertical(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    else return 0
    end
end

# blind tiger

function move_black_t(set::Pieces, enemy::Pieces, piece, cords)
    if piece[1] == 'B'
        flag = move_promoted_t(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    end
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif delta_x == 0 && delta_y == -1
        return 0
    elseif abs(delta_x) <= 1 && abs(delta_y) <= 1
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end
end

function move_red_t(set::Pieces, enemy::Pieces, piece, cords)
    if piece[1] == 'B'
        flag = move_promoted_t(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    end
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif delta_x == 0 && delta_y == 1
        return 0
    elseif abs(delta_x) <= 1 && abs(delta_y) <= 1
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end
end

# ferocious leopard

function move_f(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if piece[1] == 'F'
        flag = move_bishop(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif abs(delta_x) <= 1 && abs(delta_y) == 1
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end
end

# copper general

function move_black_c(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'C'
        flag = move_m(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif delta_y == -1 && abs(delta_x) <= 1
        move_piece(set,enemy,piece,cords); return 1
    elseif delta_y == 1 && delta_x == 0
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end
end

function move_red_c(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'C'
        flag = move_m(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif delta_y == 1 && abs(delta_x) <= 1
        move_piece(set,enemy,piece,cords); return 1
    elseif delta_y == -1 && delta_x == 0
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end
end

# silver generals
function move_black_s(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'S'
        flag = move_v(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif delta_y == 1 && abs(delta_x) == 1
        move_piece(set,enemy,piece,cords); return 1
    elseif delta_y == -1 && abs(delta_x) <= 1
         move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end    
end

function move_red_s(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'S'
        flag = move_v(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif delta_y == -1 && abs(delta_x) == 1
        move_piece(set,enemy,piece,cords); return 1
    elseif delta_y == 1 && abs(delta_x) <= 1
         move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end    
end

# gold generals
function move_black_g(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'G'
        flag = move_rook(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif delta_y == -1 && abs(delta_x) == 1
        move_piece(set,enemy,piece,cords); return 1
    elseif delta_y == 1 && delta_x == 0
         move_piece(set,enemy,piece,cords); return 1
    elseif delta_y == 0 && abs(delta_x) == 1
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end    
end

function move_red_g(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'G'
        flag = move_rook(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif delta_y == 1 && abs(delta_x) == 1
        move_piece(set,enemy,piece,cords); return 1
    elseif delta_y == -1 && delta_x == 0
         move_piece(set,enemy,piece,cords); return 1
    elseif delta_y == 0 && abs(delta_x) == 1
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end    
end

# drunk elephants
function move_black_e(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'D'
        flag = move_k(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif delta_y == 1 && delta_x == 0
        return 0
    elseif abs(delta_y) <= 1 && abs(delta_x) <= 1
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end
end

function move_red_e(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
     # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'D'
        flag = move_k(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif delta_y == -1 && delta_x == 0
        return 0
    elseif abs(delta_y) <= 1 && abs(delta_x) <= 1
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end
end

# kirin
function move_n(set::Pieces, enemy::Pieces, piece, cords, cords2)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if haskey(set.activeS,cords) == true
        return 0
    elseif piece[1] == 'K'
        flag = move_lion(set,enemy,piece,cords,cords2)
        flag == 1 ? (return 1) : (return 0)
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif abs(delta_x) == 2 && delta_y == 0
        move_piece(set,enemy,piece,cords); return 1
    elseif abs(delta_y) == 2 && delta_x == 0
        move_piece(set,enemy,piece,cords); return 1
    elseif abs(delta_x) == 1 && abs(delta_y) == 1
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end
end

# phoenix
function move_x(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'P'
        flag = move_q(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif abs(delta_x) == 2 && abs(delta_y) == 2
        move_piece(set,enemy,piece,cords); return 1
    elseif abs(delta_y) == 1 && delta_x == 0
        move_piece(set,enemy,piece,cords); return 1
    elseif abs(delta_x) == 1 && delta_y == 0
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end
end

# queen
function move_q(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if haskey(set.activeS,cords) == true
        return 0
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif abs(delta_x) <= 1 && abs(delta_y) <= 1
        move_piece(set,enemy,piece,cords); return 1
    elseif delta_x == delta_y
        # if moving towards top right (9,9)
        if x > xi && y > yi
            cords = top_right(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards bottom right (9,1)
        elseif x > xi && y < yi
            cords = bottom_right(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards bottom left (1,1)
        elseif x < xi && y < yi 
            cords = bottom_left(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards top left (1,9)
        elseif x < xi && y > yi 
            cords = top_left(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        end
    elseif delta_x != 0 && delta_y == 0 # horizontal movemement
        cords = horizontal(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    elseif delta_y != 0 && delta_x == 0 # vertical movement
        cords = vertical(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    else return 0
    end
end

# promoted blind tiger = flying stag
function move_promoted_t(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if haskey(set.activeS,cords) == true
        return 0
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif abs(delta_x) <= 1 && abs(delta_y) <= 1
        move_piece(set,enemy,piece,cords); return 1
    elseif delta_y != 0 && delta_x == 0 # vertical movement
        cords = vertical(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    else return 0
    end
end

# promoted vertical mover == flying ox
function move_promoted_v(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if haskey(set.activeS,cords) == true
        return 0
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif delta_x == delta_y
        # if moving towards top right (9,9)
        if x > xi && y > yi
            cords = top_right(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards bottom right (9,1)
        elseif x > xi && y < yi
            cords = bottom_right(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards bottom left (1,1)
        elseif x < xi && y < yi 
            cords = bottom_left(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards top left (1,9)
        elseif x < xi && y > yi 
            cords = top_left(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        end
    elseif delta_y != 0 && delta_x == 0 # vertical movement
        cords = vertical(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    else return 0
    end
end

# promoted side mover == free boar
function move_promoted_m(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if haskey(set.activeS,cords) == true
        return 0
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif delta_x == delta_y
        # if moving towards top right (9,9)
        if x > xi && y > yi
            cords = top_right(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards bottom right (9,1)
        elseif x > xi && y < yi
            cords = bottom_right(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards bottom left (1,1)
        elseif x < xi && y < yi 
            cords = bottom_left(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards top left (1,9)
        elseif x < xi && y > yi 
            cords = top_left(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        end
    elseif delta_x != 0 && delta_y == 0 # horizontal movemement
        cords = horizontal(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    else return 0
    end
end

# promoted red reverse chariot and promoted black lance == whale
function move_promoted_a(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if haskey(set.activeS,cords) == true
        return 0
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif delta_x == delta_y
        # if moving towards bottom right (9,1)
        if x > xi && y < yi
            cords = bottom_right(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards bottom left (1,1)
        elseif x < xi && y < yi 
            cords = bottom_left(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        else return 0
        end
    elseif delta_x != 0 && delta_y == 0 # vertical movemement
        cords = vertical(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    else return 0
    end
end

# promoted red lance and promoted black chariot == white horse
function move_promoted_l(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if haskey(set.activeS,cords) == true
        return 0
    elseif haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif delta_x == delta_y
        # if moving towards top right (9,9)
        if x > xi && y > yi
            cords = top_right(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards top left (1,9)
        elseif x < xi && y > yi 
            cords = top_left(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        else return 0
        end
    elseif delta_x != 0 && delta_y == 0 # vertical movemement
        cords = vertical(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    else return 0
    end
end

# king/prince
function move_k(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi;
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif abs(delta_x) > 1 || abs(delta_y) > 1 
        return 0
    elseif delta_x == 0 && delta_y == 0
        return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    else # legal move
        move_piece(set,enemy,piece,cords);return 1
    end
end

# promoted dragon horse == horned falcon
function move_promoted_h(set::Pieces, enemy::Pieces, piece, cords, cords2)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi; 
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif haskey(enemy.activeS,cords2) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords2,"NULL") == 0 && return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif cords2 != 0
        if set.color == "black"
            if delta_y == -1 && abs(delta_x) == 1
                move_piece(set,enemy,piece,cords)
                if abs(cords2[2]-y) == 1 && abs(cords2[1]-x) == 1 && haskey(set.activeS,cords2) != true
                    move_piece(set,enemy,piece,cords2) 
                    return 1
                else # if second move is illegal revert the first move
                    move_piece(set,enemy,piece,(xi,yi))
                    return 0
                end
            end
            return 0
        else
            if delta_y == 1 && abs(delta_x) == 1 
                move_piece(set,enemy,piece,cords)
                if abs(cords2[2]-y) == 1 && abs(cords2[1]-x) == 1 && haskey(set.activeS,cords2) != true
                    move_piece(set,enemy,piece,cords2) 
                    return 1   
                else 
                    move_piece(set,enemy,piece,(xi,yi))
                    return 0
                end
            end
            return 0
        end
    elseif delta_y == -2 && delta_x == 0 && set.color == "black"
        move_piece(set,enemy,piece,cords)
    elseif delta_y == 2 && delta_x == 0 && set.color == "red"
        move_piece(set,enemy,piece,cords)
    elseif abs(delta_x) == abs(delta_y)
        # if moving towards top right (9,9)
        if x > xi && y > yi
            cords = top_right(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards bottom right (9,1)
        elseif x > xi && y < yi
            cords = bottom_right(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards bottom left (1,1)
        elseif x < xi && y < yi 
            cords = bottom_left(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards top left (1,9)
        elseif x < xi && y > yi 
            cords = top_left(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        end
    elseif delta_x != 0 && delta_y == 0 # horizontal movemement
        cords = horizontal(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    else
        return 0
    end
end

# promoted dragon king = soaring eagle
function move_promoted_d(set::Pieces, enemy::Pieces, piece, cords, cords2)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi; 
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif haskey(enemy.activeS,cords2) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords2,"NULL") == 0 && return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif cords2 != 0
        if set.color == "black"
            if delta_y == -1 && abs(delta_x) == 1
                move_piece(set,enemy,piece,cords)
                if abs(cords2[2]-y) == 1 && abs(cords2[1]-x) == 1 && haskey(set.activeS,cords2) != true
                    move_piece(set,enemy,piece,cords2) 
                    return 1
                else # if second move is illegal revert the first move
                    move_piece(set,enemy,piece,(xi,yi))
                    return 0
                end
            end
            return 0
        else
            if delta_y == 1 && abs(delta_x) == 1 
                move_piece(set,enemy,piece,cords)
                if abs(cords2[2]-y) == 1 && abs(cords2[1]-x) == 1 && haskey(set.activeS,cords2) != true
                    move_piece(set,enemy,piece,cords2) 
                    return 1   
                else 
                    move_piece(set,enemy,piece,(xi,yi))
                    return 0
                end
            end
            return 0
        end
    elseif delta_y == 2 && abs(delta_x) == 2 && set.color == "red"
        move_piece(set,enemy,piece,cords)
    elseif delta_y == -2 && abs(delta_x) == 2 && set.color == "black"
        move_piece(set,enemy,piece,cords)
    elseif abs(delta_x) == abs(delta_y)
        # if moving towards top right (9,9)
        if x > xi && y > yi
            cords = top_right(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards bottom right (9,1)
        elseif x > xi && y < yi
            cords = bottom_right(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards bottom left (1,1)
        elseif x < xi && y < yi 
            cords = bottom_left(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        # if moving towards top left (1,9)
        elseif x < xi && y > yi 
            cords = top_left(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        end
    elseif delta_x != 0 && delta_y == 0 # horizontal movemement
        cords = horizontal(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    else
        return 0
    end
end

# lion
function move_lion(set::Pieces, enemy::Pieces, piece, cords, cords2)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi; 
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    elseif abs(delta_x) > 2 || abs(delta_y) > 2
        return 0
    elseif (abs(delta_x) > 1 || abs(delta_y) > 1) && cords2 != 0
        return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif cords2 != 0
        if abs(cords2[1]-x) <= 1 && abs(cords2[2]-y) <= 1 
            # record first kill for lion if there is one
            haskey(enemy.activeS,cords) == true ? dead = enemy.activeS[cords] : dead = "NULL"
            if haskey(set.activeS,cords2) != true
                # check if a lion is occupying cords2
                if haskey(enemy.activeS,cords2) == true && ( enemy.activeS[cords2] == "lion" || enemy.activeS[cords2] == "lion" )
                    flag = lion_kill(set,enemy,piece,cords2,dead)
                    flag == 0 && return 0
                end
                move_piece(set,enemy,piece,cords)
                move_piece(set,enemy,piece,cords2); return 1
            else # if second move is illegal revert the first move and return 0
                move_piece(set,enemy,piece,(xi,yi)); return 0
            end
        else
            return 0
        end
    elseif cords2 == 0
        if (abs(delta_y) > 1 || abs(delta_x) > 1) && 
            haskey(enemy.activeS,cords) == true &&
            ( enemy.activeS[cords] == "lion" || enemy.activeS[cords] == "lion" )
                flag = lion_kill(set,enemy,piece,cords,"NULL")
                flag == 0 && (return 0)
        end
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end
end




### tests