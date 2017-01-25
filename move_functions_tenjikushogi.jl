function validate_red(set::Pieces, enemy::Pieces, piece, source, cords, cords2, cords3)
    piece == "" && return 0
    haskey(set.active,piece) == 0 && return 0
    set.active[piece] != source && return 0
    if contains(piece, "pawn") || contains(piece, "Pawn")
        flag = move_red_p(red,black,piece,cords)
    elseif contains(piece, "king")
        flag = move_king(red,black,piece,cords)
    elseif contains(piece, "queen") || contains(piece, "Queen")
        flag = move_q(red,black,piece,cords)
    elseif contains(piece, "lionhawk")
        cords == cords2 ?
            flag = move_lion_hawk(red,black,piece,cords,0) :
            flag = move_lion_hawk(red,black,piece,cords,cords2)
    elseif contains(piece, "ion") 
        cords == cords2 ?
            flag = move_lion(red,black,piece,cords,0) :
            flag = move_lion(red,black,piece,cords,cords2)
    elseif contains(piece, "dragonking") || contains(piece, "Dragonking")
        cords == cords2 ?
            flag = move_d(red,black,piece,cords,0) :
            flag = move_d(red,black,piece,cords,cords2)
    elseif contains(piece, "dragonhorse") || contains(piece, "Dragonhorse")
        cords == cords2 ?
            flag = move_h(red,black,piece,cords,0) :
            flag = move_h(red,black,piece,cords,cords2)
    elseif contains(piece, "kirin") || contains(piece, "Kirin")
        cords == cords2 ?
            flag = move_n(red,black,piece,cords,0) :
            flag = move_n(red,black,piece,cords,cords2)
    elseif contains(piece, "knight") || contains(piece, "Knight")
        flag = move_red_knight(red,black,piece,cords)
    elseif contains(piece, "phoenix") || contains(piece, "Phoenix")
        cords == cords2 ?
            flag = move_x(red,black,piece,cords,0) :
            flag = move_x(red,black,piece,cords,cords2)
    elseif contains(piece, "drunkelephant") || contains(piece, "Drunkelephant")
        flag = move_red_e(red,black,piece,cords)
    elseif contains(piece, "blindtiger") || contains(piece, "Blindtiger")
        flag = move_red_t(red,black,piece,cords)
    elseif contains(piece, "ferociousleopard") || contains(piece, "Ferociousleopard")
        flag = move_f(red,black,piece,cords)
    elseif contains(piece, "verticalmover") || contains(piece, "Verticalmover")
        flag = move_v(red,black,piece,cords)
    elseif contains(piece, "verticalsoldier") || contains(piece, "Verticalsoldier")
      flag = move_red_vertical_soldier(red,black,piece,cords)
    elseif contains(piece, "vicegeneral")
        if cords == cords2 == cords3
            flag = move_vice_general(red,black,piece,cords,0,0)
        elseif cords2 == cords3
            flag = move_vice_general(red,black,piece,cords,cords2,0)
        elseif cords == cords2
            flag = move_vice_general(red,black,piece,cords,cords3,0)
        else
            flag = move_vice_general(red,black,piece,cords,cords2,cords3)
        end
    elseif contains(piece, "sidemover") || contains(piece, "Sidermover")
        flag = move_m(red,black,piece,cords)
    elseif contains(piece, "sidesoldier") || contains(piece, "Sidesoldier")
      flag = move_red_side_soldier(red,black,piece,cords)
    elseif contains(piece, "reversechariot") || contains(piece, "Reversechariot")
        flag = move_a(red,black,piece,cords)
    elseif contains(piece, "goldgeneral") || contains(piece, "Goldgeneral")
        flag = move_red_g(red,black,piece,cords)
    elseif contains(piece, "silvergeneral") || contains(piece, "Silvergeneral")
        flag = move_red_s(red,black,piece,cords)
    elseif contains(piece, "soaringeagle") || contains(piece, "Soaringeagle")
        flag = move_soaring_eagle(red,black,piece,cords,cords2)
    elseif contains(piece, "coppergeneral") || contains(piece, "Coppergeneral")
        flag = move_red_c(red,black,piece,cords)
    elseif contains(piece, "bishop1") || contains(piece, "bishop2") || contains(piece, "Bishop1") || contains(piece, "Bishop2")
        flag = move_bishop(red,black,piece,cords)
    elseif contains(piece, "bishopgeneral") || contains(piece, "Bishopgeneral")
        if cords == cords2 == cords3
            flag = move_vice_general(red,black,piece,cords,0,0)
        elseif cords2 == cords3
            flag = move_vice_general(red,black,piece,cords,cords2,0)
        elseif cords == cords2
            flag = move_vice_general(red,black,piece,cords,cords3,0)
        else
            flag = move_vice_general(red,black,piece,cords,cords2,cords3)
        end
    elseif ( contains(piece, "rook") && !contains(piece, "general") ) || ( contains(piece, "Rook") && !contains(piece, "general") )
        flag = move_rook(red,black,piece,cords)
    elseif contains(piece, "rookgeneral") || contains(piece, "Rookgeneral")
        flag = move_rook_general(red,black,piece,cords)
    elseif contains(piece, "lance") || contains(piece, "Lance")
        flag = move_r_l(red,black,piece,cords)
    elseif contains(piece, "dog") || contains(piece, "Dog")
        flag = move_red_dog(red,black,piece,cords)
    elseif contains(piece, "firedemon")
        if cords == cords2 == cords3
            flag = move_fire_demon(red,black,piece,cords,0,0)
        elseif cords2 == cords3
            flag = move_fire_demon(red,black,piece,cords,cords2,0)
        elseif cords == cords2
            flag = move_fire_demon(red,black,piece,cords,cords3,0)
        else
            flag = move_fire_demon(red,black,piece,cords,cords2,cords3)
        end
    elseif contains(piece, "freeeagle")
        flag = move_free_eagle(red,black,piece,cords,cords2)
    elseif contains(piece, "greatgeneral")
        flag = move_great_general(red,black,piece,cords)
    elseif contains(piece, "hornedfalcon") || contains(piece, "Hornedfalcon")
        cords == cords2 ?
            flag = move_red_horned_falcon(red,black,piece,cords,0) :
            flag = move_red_horned_falcon(red,black,piece,cords,cords2)
    elseif contains(piece, "irongeneral") || contains(piece, "Irongeneral")
        flag = move_red_iron_general(red,black,piece,cords)
    elseif contains(piece, "waterbuffalo") || contains(piece, "Waterbuffalo")
        flag = move_water_buffalo(red,black,piece,cords)
    end
    return flag
end

function validate_black(set::Pieces, enemy::Pieces, piece, source, cords, cords2, cords3)
    piece == "" && return 0
    haskey(set.active,piece) == 0 && return 0
    set.active[piece] != source && return 0
    if contains(piece, "pawn") || contains(piece, "Pawn")
        flag = move_black_p(black,red,piece,cords)
    elseif contains(piece, "king")
        flag = move_king(black,red,piece,cords)
    elseif contains(piece, "queen") || contains(piece, "Queen")
        flag = move_q(black,red,piece,cords)
    elseif contains(piece, "lionhawk")
        cords == cords2 ?
            flag = move_lion_hawk(black,red,piece,cords,0) :
            flag = move_lion_hawk(black,red,piece,cords,cords2)
    elseif contains(piece, "ion") 
        cords == cords2 ?
            flag = move_lion(black,red,piece,cords,0) :
            flag = move_lion(black,red,piece,cords,cords2)
    elseif contains(piece, "dragonking") || contains(piece, "Dragonking")
        cords == cords2 ?
            flag = move_d(black,red,piece,cords,0) :
            flag = move_d(black,red,piece,cords,cords2)
    elseif contains(piece, "dragonhorse") || contains(piece, "Dragonhorse")
        cords == cords2 ?
            flag = move_h(black,red,piece,cords,0) :
            flag = move_h(black,red,piece,cords,cords2)
    elseif contains(piece, "kirin") || contains(piece, "Kirin")
        cords == cords2 ?
            flag = move_n(black,red,piece,cords,0) :
            flag = move_n(black,red,piece,cords,cords2)
    elseif contains(piece, "knight") || contains(piece, "Knight")
        flag = move_black_knight(black,red,piece,cords)
    elseif contains(piece, "phoenix") || contains(piece, "Phoenix")
        cords == cords2 ?
            flag = move_x(black,red,piece,cords,0) :
            flag = move_x(black,red,piece,cords,cords2)
    elseif contains(piece, "drunkelephant") || contains(piece, "Drunkelephant")
        flag = move_black_e(black,red,piece,cords)
    elseif contains(piece, "blindtiger") || contains(piece, "Blindtiger")
        flag = move_black_t(black,red,piece,cords)
    elseif contains(piece, "ferociousleopard") || contains(piece, "Ferociousleopard")
        flag = move_f(black,red,piece,cords)
    elseif contains(piece, "verticalmover") || contains(piece, "Verticalmover")
        flag = move_v(black,red,piece,cords)
    elseif contains(piece, "verticalsoldier") || contains(piece, "Verticalsoldier")
      flag = move_black_vertical_soldier(black,red,piece,cords)
    elseif contains(piece, "vicegeneral")
        if cords == cords2 == cords3
            flag = move_vice_general(black,red,piece,cords,0,0)
        elseif cords2 == cords3
            flag = move_vice_general(black,red,piece,cords,cords2,0)
        elseif cords == cords2
            flag = move_vice_general(black,red,piece,cords,cords3,0)
        else
            flag = move_vice_general(black,red,piece,cords,cords2,cords3)
        end
    elseif contains(piece, "sidemover") || contains(piece, "Sidermover")
        flag = move_m(black,red,piece,cords)
    elseif contains(piece, "sidesoldier") || contains(piece, "Sidesoldier")
      flag = move_black_side_soldier(black,red,piece,cords)
    elseif contains(piece, "reversechariot") || contains(piece, "Reversechariot")
        flag = move_a(black,red,piece,cords)
    elseif contains(piece, "goldgeneral") || contains(piece, "Goldgeneral")
        flag = move_black_g(black,red,piece,cords)
    elseif contains(piece, "silvergeneral") || contains(piece, "Silvergeneral")
        flag = move_black_s(black,red,piece,cords)
    elseif contains(piece, "soaringeagle") || contains(piece, "Soaringeagle")
        flag = move_soaring_eagle(black,red,piece,cords,cords2)
    elseif contains(piece, "coppergeneral") || contains(piece, "Coppergeneral")
        flag = move_black_c(black,red,piece,cords)
    elseif contains(piece, "bishop1") || contains(piece, "bishop2") || contains(piece, "Bishop1") || contains(piece, "Bishop2")
        flag = move_bishop(black,red,piece,cords)
    elseif contains(piece, "bishopgeneral") || contains(piece, "Bishopgeneral")
        if cords == cords2 == cords3
            flag = move_vice_general(black,red,piece,cords,0,0)
        elseif cords2 == cords3
            flag = move_vice_general(black,red,piece,cords,cords2,0)
        elseif cords == cords2
            flag = move_vice_general(black,red,piece,cords,cords3,0)
        else
            flag = move_vice_general(black,red,piece,cords,cords2,cords3)
        end
    elseif ( contains(piece, "rook") && !contains(piece, "general") ) || ( contains(piece, "Rook") && !contains(piece, "general") )
        flag = move_rook(black,red,piece,cords)
    elseif contains(piece, "rookgeneral") || contains(piece, "Rookgeneral")
        flag = move_rook_general(black,red,piece,cords)
    elseif contains(piece, "lance") || contains(piece, "Lance")
        flag = move_r_l(black,red,piece,cords)
    elseif contains(piece, "dog") || contains(piece, "Dog")
        flag = move_black_dog(black,red,piece,cords)
    elseif contains(piece, "firedemon")
        if cords == cords2 == cords3
            flag = move_fire_demon(black,red,piece,cords,0,0)
        elseif cords2 == cords3
            flag = more_fire_demon(black,red,piece,cords,cords2,0)
        elseif cords == cords2
            flag = move_fire_demon(black,red,piece,cords,cords3,0)
        else
            flag = move_fire_demon(black,red,piece,cords,cords2,cords3)
        end
    elseif contains(piece, "freeeagle")
        flag = move_free_eagle(black,red,piece,cords,cords2)
    elseif contains(piece, "greatgeneral")
        flag = move_great_general(black,red,piece,cords)
    elseif contains(piece, "hornedfalcon") || contains(piece, "Hornedfalcon")
        cords == cords2 ?
            flag = move_black_horned_falcon(black,red,piece,cords,0) :
            flag = move_black_horned_falcon(black,red,piece,cords,cords2)
    elseif contains(piece, "irongeneral") || contains(piece, "Irongeneral")
        flag = move_black_iron_general(black,red,piece,cords)
    elseif contains(piece, "waterbuffalo") || contains(piece, "Waterbuffalo")
        flag = move_water_buffalo(black,red,piece,cords)
    end
    return flag
end



function check_bounds(x::Int64, y::Int64)
    # check bounds
    if x < 1 || x > 16
        return 0
    elseif y < 1 || y > 16
        return 0
    else return 1
    end
end

function >(op1::ASCIIString, op2::ASCIIString)
    rank = Dict("king"=>4,"prince"=>4,"greatgeneral1_"=>3,"greatgeneral2_"=>3,
        "vicegeneral1_"=>2, "vicegeneral2_"=>2, "bishopgeneral1_"=>1,"bishopgeneral2_"=>1,
        "rookgeneral1_"=>1, "rookgeneral2_"=>1)
    A = chop(op1); B = chop(op2)
    haskey(rank,B) != true && return true
    rank[A] > rank[B] ? (return true) : (return false)
end

function range_jump(set::Pieces, enemy::Pieces, piece, source, target)
    haskey(enemy.activeS,target) == true ? flag = 1 : flag = 0
    xi = source[1]; yi = source[2]
    x = target[1]; y = target[2]
    delta = abs(x-xi)
    if x > xi && y > yi 
        xInc = yInc = 1
    elseif x > xi && y < yi
        xInc = 1; yInc = -1
    elseif x < xi && y < yi
        xInc = yInc = -1
    else
        xInc = -1; yInc = 1
    end
    for i = 1:delta
        new_cords::Tuple{Int64,Int64} = (xi+i*xInc,yi+i*yInc)
        haskey(enemy.activeS,new_cords) == true ? jump = 1 : jump = 0
        haskey(set.activeS,new_cords) == true ? friend = 1 : friend = 0
        if jump == 1 && flag == 1
            # enemy.activeS[target] == "king" && return 0
            contains(enemy.activeS[target],"king") && return 0
            # enemy.activeS[target] == "prince" && return 0
            contains(enemy.activeS[target],"prince") && return 0
            piece > enemy.activeS[new_cords] ? (continue) : (return new_cords)
        elseif jump == 1
            return new_cords
        elseif friend == 1 && flag == 1
            # enemy.activeS[target] == "king" && return 0
            contains(enemy.activeS[target],"king") && return 0
            # enemy.activeS[target] == "prince" && return 0
            contains(enemy.activeS[target],"prince") && return 0
            piece > set.activeS[new_cords] ? (continue) : (return 0)
        elseif friend == 1
            return 0
        end
    end
    return target
end

function range(set::Pieces, enemy::Pieces, source, target)
     xi = source[1]; yi = source[2]
    x = target[1]; y = target[2]
    delta = abs(x-xi)
    if x > xi && y > yi 
        xInc = yInc = 1
    elseif x > xi && y < yi
        xInc = 1; yInc = -1
    elseif x < xi && y < yi
        xInc = yInc = -1
    else
        xInc = -1; yInc = 1
    end
    for i = 1:delta
        new_cords::Tuple{Int64,Int64} = (xi+i*xInc,yi+i*yInc)
        haskey(enemy.activeS,new_cords) == true ? kill = 1 : kill = 0
        haskey(set.activeS,new_cords) == true ? friend = 1 : friend = 0
        if kill == 1
            return new_cords
        elseif friend == 1
            return 0
        end
    end
    return target
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
    for i = 1:delta
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
    for i = 1:delta
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

function horizontal_jump(set::Pieces, enemy::Pieces, piece, source, target)
    haskey(enemy.activeS,target) == true ? flag = 1 : flag = 0
    xi = source[1]; yi = source[2]
    x = target[1]; y = target[2]
    delta = x-xi
    delta < 0 ? inc = -1 : inc = 1
    for i = (xi+inc):inc:x
        new_cords::Tuple{Int64,Int64} = (i,y)
        haskey(enemy.activeS,new_cords) == true ? jump = 1 : jump = 0
        haskey(set.activeS,new_cords) == true ? friend = 1 : friend = 0
        if jump == 1 && flag == 1
            # enemy.activeS[target] == "king" && return 0
            contains(enemy.activeS[target],"king") && return 0
            # enemy.activeS[target] == "prince" && return 0
            contains(enemy.activeS[target],"prince") && return 0
            piece > enemy.activeS[new_cords] ? (continue) : (return new_cords)
        elseif jump == 1
            return new_cords
        elseif friend == 1 && flag == 1
            # enemy.activeS[target] == "king" && return 0
            contains(enemy.activeS[target],"king") && return 0
            # enemy.activeS[target] == "prince" && return 0
            contains(enemy.activeS[target],"prince") && return 0
            piece > set.activeS[new_cords] ? (continue) : (return 0)
        elseif friend == 1
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

function vertical_jump(set::Pieces, enemy::Pieces, piece, source, target)
    haskey(enemy.activeS,target) == true ? flag = 1 : flag = 0
    xi = source[1]; yi = source[2]
    x = target[1]; y = target[2]
    delta = x-xi
    delta < 0 ? inc = -1 : inc = 1
    for i = (yi+inc):inc:y
        new_cords::Tuple{Int64,Int64} = (x,i)
        haskey(enemy.activeS,new_cords) == true ? jump = 1 : jump = 0
        haskey(set.activeS,new_cords) == true ? friend = 1 : friend = 0
        if jump == 1 && flag == 1
            # enemy.activeS[target] == "king" && return 0
            contains(enemy.activeS[target],"king") && return 0
            # enemy.activeS[target] == "prince" && return 0
            contains(enemy.activeS[target],"prince") && return 0
            piece > enemy.activeS[new_cords] ? (continue) : (return new_cords)
        elseif jump == 1
            return new_cords
        elseif friend == 1 && flag == 1
            # enemy.activeS[target] == "king" && return 0
            contains(enemy.activeS[target],"king") && return 0
            # enemy.activeS[target] == "prince" && return 0
            contains(enemy.activeS[target],"prince") && return 0
            piece > set.activeS[new_cords] ? (continue) : (return 0)
        elseif friend == 1
            return 0
        end
    end
    return target
end

# fire demon burn
function burn(set::Pieces, enemy::Pieces, cords)
    # initial cords
    x = cords[1]; y = cords[2]
    if haskey(enemy.activeS,(x,y+1)) == true 
        dead = enemy.activeS[(x,y+1)]
        pop!(enemy.activeS,(x,y+1))
        pop!(enemy.active,dead)
        update_hand(set,dead)
    end
    if haskey(enemy.activeS,(x+1,y+1)) == true
        dead = enemy.activeS[(x+1,y+1)]
        pop!(enemy.activeS,(x+1,y+1))
        pop!(enemy.active,dead)
        update_hand(set,dead)
    end
    if haskey(enemy.activeS,(x+1,y)) == true
        dead = enemy.activeS[(x+1,y)]
        pop!(enemy.activeS,(x+1,y))
        pop!(enemy.active,dead)
        update_hand(set,dead)
    end
    if haskey(enemy.activeS,(x+1,y-1)) == true
        dead = enemy.activeS[(x+1,y-1)]
        pop!(enemy.activeS,(x+1,y-1))
        pop!(enemy.active,dead)
        update_hand(set,dead)
    end
    if haskey(enemy.activeS,(x,y-1)) == true
        dead = enemy.activeS[(x,y-1)]
        pop!(enemy.activeS,(x,y-1))
        pop!(enemy.active,dead)
        update_hand(set,dead)
    end
    if haskey(enemy.activeS,(x-1,y-1)) == true
        dead = enemy.activeS[(x-1,y-1)]
        pop!(enemy.activeS,(x-1,y-1))
        pop!(enemy.active,dead,)
        update_hand(set,dead)
    end
    if haskey(enemy.activeS,(x-1,y)) == true
        dead = enemy.activeS[(x-1,y)]
        pop!(enemy.activeS,(x-1,y))
        pop!(enemy.active,dead)
        update_hand(set,dead)
    end
    if haskey(enemy.activeS,(x-1,y+1)) == true
        dead = enemy.activeS[(x-1,y+1)]
        pop!(enemy.activeS,(x-1,y+1))
        pop!(enemy.active,dead)
        update_hand(set,dead)
    end
end

function passive_burn(set::Pieces, enemy::Pieces, old_cords, cords)
    x = cords[1]; y = cords[2]
    for i = 1:4
        if haskey(enemy.active,"firedemon$(i)_b") == true || haskey(enemy.active,"firedemon$(i)_r") == true
            if set.color == "black"
                target = enemy.active["firedemon$(i)_r"]
            else
                target = enemy.active["firedemon$(i)_b"]
            end
            delta_x = x - target[1]; delta_y = y - target[2]
            if abs(delta_x) <= 1 && abs(delta_y) <= 1
                dead = set.activeS[old_cords]
                pop!(set.activeS,old_cords)
                pop!(enemy.active,dead)
                update_hand(enemy,dead)
                println(dead)
                return 1
            end
        end
   end
   return 0
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

    # basic move both unpromoted and promoted can make
    if y != 16 && haskey(set.activeS,(x,y+1)) == 0
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
        if y != 16 && x != 16 && x != 1 
            haskey(set.activeS,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
            haskey(set.activeS,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
            # add left and right movement
            haskey(set.activeS,(x+1,y)) == 0 && push!(legal,(x+1,y))
            haskey(set.activeS,(x-1,y)) == 0 && push!(legal,(x-1,y))
        elseif y == 16 && x != 16 && x != 1
            haskey(set.activeS,(x-1,y)) == 0 && push!(legal,(x-1,y))
            haskey(set.activeS,(x+1,y)) == 0 && push!(legal,(x+1,y))
        elseif y != 16 && x == 16 # if piece is on left side of board, and y != 16
            haskey(set.activeS,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
            haskey(set.activeS,(x,y+1)) == 0 && push!(legal,(x,y+1))
            haskey(set.activeS,(x-1,y)) == 0 && push!(legal,(x-1,y))
        elseif y != 16 && x == 1 # if piece is on right side of board, and y != 16
            haskey(set.activeS,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
            haskey(set.activeS,(x,y+1)) == 0 && push!(legal,(x,y+1))
            haskey(set.activeS,(x+1,y)) == 0 && push!(legal,(x+1,y))
        elseif x == 16 # if y == 16 and x == 16
            haskey(set.activeS,(x-1,y)) == 0 && push!(legal,(x-1,y))
        elseif x == 1 # if x == 1 and y = 16
            haskey(set.activeS,(x+1,y)) == 0 && push!(legal,(x+1,y))
        end
        # adds the backsetp allowable coordinates
        if y != 1
            haskey(set.activeS,(x,y-1)) == 0 && push!(legal,(x,y-1))
        end
        # check if user input matches a legal move
        if findfirst(legal,cords) != 0 
            move_piece( set, inactive, piece, cords); return 1
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
        if y != 1 && x != 1 && x != 16 
            haskey(set.activeS,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
            haskey(set.activeS,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
            # add left and right movement
            haskey(set.activeS,(x+1,y)) == 0 && push!(legal,(x+1,y))
            haskey(set.activeS,(x-1,y)) == 0 && push!(legal,(x-1,y))
        elseif y == 1 && x != 1 && x != 16
            haskey(set.activeS,(x-1,y)) == 0 && push!(legal,(x-1,y))
            haskey(set.activeS,(x+1,y)) == 0 && push!(legal,(x+1,y))
        elseif y != 1 && x == 16 # if piece is on left side of board, and y != 1
            haskey(set.activeS,(x-1,y-1)) == 0 && push!(legal,(x-1,y+1))
            haskey(set.activeS,(x-1,y)) == 0 && push!(legal,(x-1,y))
        elseif y != 1 && x == 1 # if piece is on right side of board, and y != 1
            haskey(set.activeS,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
            haskey(set.activeS,(x+1,y)) == 0 && push!(legal,(x+1,y))
        elseif x == 16 # if x == 16 and y == 1
            haskey(set.activeS,(x-1,y)) == 0 && push!(legal,(x-1,y))
        elseif x == 1 # if x == 1 and y = 1
            haskey(set.activeS,(x+1,y)) == 0 && push!(legal,(x+1,y))
        end
        # adds the backsetp allowable coordinates
        if y != 16
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

# dogs
function move_black_dog(set::Pieces, enemy::Pieces, piece, cords)
    # initial cords
    xi = set.active[piece][1]; yi = set.active[piece][2]
    # target cords
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    check_bounds(cords[1],cords[2]) == 0 && return 0
    if haskey(set.activeS,cords) == true
        return 0
    elseif piece[1] == 'D'
        flag = move_multi_general(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif delta_x == 0 && delta_y == -1
        move_piece(set,enemy,piece,cords); return 1
    elseif abs(delta_x) == 1 && delta_y == 1
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end
end

function move_red_dog(set::Pieces, enemy::Pieces, piece, cords)
    # initial cords
    xi = set.active[piece][1]; yi = set.active[piece][2]
    # target cords
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    check_bounds(cords[1],cords[2]) == 0 && return 0
    if haskey(set.activeS,cords) == true
        return 0
    elseif piece[1] == 'D'
        flag = move_multi_general(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif delta_x == 0 && delta_y == 1
        move_piece(set,enemy,piece,cords); return 1
    elseif abs(delta_x) == 1 && delta_y == -1
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end
end

# multigeneral == promoted dog
function move_multi_general(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    # forward vertical movement
    if set.color == "red" && delta_x == 0 && delta_y > 0
        cords = vertical(set,enemy,(xi,yi),cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0
        end
    elseif set.color == "black" && delta_x == 0 && delta_y < 0
        cords = vertical(set,enemy,(xi,yi),cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0
        end
    elseif abs(delta_x) == abs(delta_y)
        if set.color == "red"
            if x > xi && y < yi
                cords = bottom_right(set,enemy,(xi,yi),cords)
                if cords != 0
                    move_piece(set,enemy,piece,cords); return 1
                else return 0
                end
            elseif x < xi && y < yi
                cords = bottom_left(set,enemy,(xi,yi),cords)
                if cords != 0
                    move_piece(set,enemy,piece,cords); return 1
                else return 0
                end
            else return 0
            end
        else
            if x > xi && y > yi
                cords = top_right(set,enemy,(xi,yi),cords)
                if cords != 0
                    move_piece(set,enemy,piece,cords); return 1
                else return 0
                end
            elseif x < xi && y > yi
                cords = top_left(set,enemy,(xi,yi),cords)
                if cords != 0
                    move_piece(set,enemy,piece,cords); return 1
                else return 0
                end
            else return 0
            end
        end
    else return 0
    end
end

# water buffalo
function move_water_buffalo(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2]; source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if piece[1] == 'W'
        move_fire_demon(set,enemy,piece,cords) == 1 ? (return 1)   : (return 0)
    elseif delta_x == 0 && abs(delta_y) <= 2
        if haskey(set.activeS,cords) != true
            move_piece(set,enemy,piece,cords); return 1
        else return 0
        end
    else
        if delta_y == 0 && delta_x != 0
            cords = horizontal(set,enemy,source,cords)
        elseif abs(delta_x) == abs(delta_y)
            cords = range(set,enemy,source,target)
        end
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0
        end
    end
end


# chariot soldier
function move_chariot_soldier(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2]; source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'C'
        move_heavenly_tetrarch(set,enemy,piece,cords) == 1 ? (return 1) : (return 0)
    elseif delta_y == 0 && abs(delta_x) <= 2
        move_piece(set,enemy,piece,cords); return 1
    else
        if delta_x == 0 && abs(delta_y) != 0
            cords = vertical(set,enemy,source,cords)
        elseif abs(delta_x) == abs(delta_y)
            cords = range(set,enemy,piece,cords)
        end
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0
        end
    end
end

# Side movers
function move_m(set::Pieces, enemy::Pieces, piece, cords)
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

function move_black_side_soldier(set::Pieces, enemy::Pieces, piece, cords)
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
        move_water_buffalo(set,enemy,piece,cords) == 1 ? (return 1) : (return 0)
    elseif haskey(set.activeS,cords) == true
        return 0
   elseif delta_x == 0 && (delta_y >= -2 && delta_y <= 1) 
        move_piece(set,enemy,piece,cords); return 1
    elseif delta_x != 0 && delta_y == 0
        cords = horizontal(set,enemy,(xi,yi),cords)
        if cords == 0
            return 0
        else move_piece(set,enemy,piece,cords); return 1
        end
    else return 0
    end
end

function move_red_side_soldier(set::Pieces, enemy::Pieces, piece, cords)
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
        move_water_buffalo(set,enemy,piece,cords) == 1 ? (return 1) : (return 0)
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif delta_x == 0 && (delta_y >= -1 && delta_y <= 2) 
        move_piece(set,enemy,piece,cords); return 1
    elseif delta_x != 0 && delta_y == 0
        cords = horizontal(set,enemy,(xi,yi),cords)
        if cords == 0
            return 0
        else move_piece(set,enemy,piece,cords); return 1
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'V'
        flag = move_promoted_v(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    # horizontal movement
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

function move_black_vertical_soldier(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'V'  
        move_chariot_soldier(set,enemy,piece,cords) == 1 ? (return 1) : (return 0)
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif abs(delta_x) <= 2 && delta_y == 0
       move_piece(set,enemy,piece,cords); return 1
    elseif delta_x == 0 && delta_y == 1
        move_piece(set,enemy,piece,cords); return 1
    elseif delta_x == 0 && delta_y < 0
        cords = vertical(set,enemy,(xi,yi),cords)
        if cords == 0
            return 0
        else move_piece(set,enemy,piece,cords); return 1
        end
    else return 0
    end
end

function move_red_vertical_soldier(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'V'  
        move_chariot_soldier(set,enemy,piece,cords) == 1 ? (return 1) : (return 0)
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif abs(delta_x) <= 2 && delta_y == 0
       move_piece(set,enemy,piece,cords); return 1
    elseif delta_x == 0 && delta_y == -1
        move_piece(set,enemy,piece,cords); return 1
    elseif delta_x == 0 && delta_y > 0
        cords = vertical(set,enemy,(xi,yi),cords)
        if cords == 0
            return 0
        else move_piece(set,enemy,piece,cords); return 1
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
    else
        cords = range(set,enemy,source,cords)
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords] == "lion_b" || enemy.activeS[cords] == "lion_r" )
        lion_kill(set,enemy,piece,cords,"NULL") == 0 && return 0
    end
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
function move_h(set::Pieces, enemy::Pieces, piece, cords)
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
    if piece[1] == 'D'
        set.color == "black" ? 
            flag = move_black_horned_falcon(B,set,enemy,piece,cords) :
            flag = move_red_horned_falcon(B,set,enemy,piece,cords) 
        flag == 1 ? (return 1) : (return 0)
    elseif abs(delta_x) != abs(delta_y)
        if haskey(set.activeS,cords) == true
            return 0
        elseif delta_x <= 1 && delta_y <= 1
            move_piece(set,enemy,piece,cords); return 1
        else
            return 0
        end
    elseif abs(delta_x) == abs(delta_y)
        cords = range(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0
        end
    else return 0
    end
end

# dragon king 
function move_d(set::Pieces, enemy::Pieces, piece, cords)
# initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if piece[1] == 'D'
        flag = move_soaring_eagle(B,set,enemy,piece,cords)
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if haskey(set.activeS,cords) == true
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if haskey(set.activeS,cords) == true
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
    end
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    check_bounds(x,y) == 0 && return 0
    if haskey(set.activeS,cords) == true
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if haskey(set.activeS,cords) == true
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if haskey(set.activeS,cords) == true
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if piece[1] == 'F'
        flag = move_bishop(set,enemy,piece,cord)
        flag == 1 ? (return 1) : (return 0)
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'C'
        flag = move_m(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'C'
        flag = move_m(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'G'
        flag = move_rook(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'G'
        flag = move_rook(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'D'
        flag = move_k(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
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
    delta_x = x - xi; delta_y = y - yi
     # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'D'
        flag = move_k(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if haskey(set.activeS,cords) == true
        return 0
    elseif piece[1] == 'K'
        flag = move_lion(set,enemy,piece,cords,cords2)
        flag == 1 ? (return 1) : (return 0)
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

# knight
function move_red_knight(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'K'
        flag = move_red_side_soldier(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif abs(delta_x) == 1 && delta_y == 2
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end
end

function move_black_knight(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'K'
        flag = move_red_side_soldier(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif abs(delta_x) == 1 && delta_y == -2
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'P'
        flag = move_q(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
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
function move_q(set::Pieces, enemy::Pieces, piece, cords, cords2)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    # check for promotion, becomes free eagle
    if piece[1] == 'Q'
        legal = move_free_eagle(set,enemy,piece,cords,cords2)
    else
        if haskey(set.activeS,cords) == true
            return 0
        elseif abs(delta_x) <= 1 && abs(delta_y) <= 1
            move_piece(set,enemy,piece,cords); return 1
        elseif delta_x == 0 && abs(delta_y) > 1
            cords = vertical(set,enemy,piece,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0
            end
        elseif delta_y == 0 && abs(delta_x) > 1
            cords = horizontal(set,enemy,piece,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0
            end
        elseif abs(delta_x) == abs(delta_y)
            cords = range(set,enemy,piece,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0
            end
        else return 0
        end
    end
end

# promoted blind tiger = flying stag
function move_promoted_t(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if haskey(set.activeS,cords) == true
        return 0
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if abs(delta_x) == abs(delta_y)
        cords = range(set,enemy,piece,cords)
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

# promoted side mover == free boar
function move_promoted_m(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if abs(delta_x) == abs(delta_y)
        cords = range(set,enemy,piece,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if abs(delta_x) == abs(delta_y) # diagonal movement
        if set.color == "red"
            delta_y > 0 && return 0
           cords = range(set,enemy,piece,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0
            end
        else
            delta_y < 0 && return 0
            cords = range(set,enemy,piece,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0
            end
        end
    elseif delta_y != 0 && delta_x == 0 # vertical movemement
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if abs(delta_x) == abs(delta_y)
        if set.color == "red"
            delta_y < 0 && return 0
            cords = range(set,enemy,piece,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0
            end
        else
            delta_y > 0 && return 0
            cords = range(set,enemy,piece,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0
            end
        end
    elseif delta_x == 0 && delta_y != 0 # vertical movemement
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
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if haskey(enemy.activeS,cords) == true  && ( enemy.activeS[cords][1] == "lion_b" || enemy.activeS[cords] == "lion_r" )
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
function move_black_horned_falcon(set::Pieces, enemy::Pieces, piece, cords, cords2)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi 
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'D'
        move_bishop_general(set,enemy,piece,cords) == 1 ? (return 1) : (return 0)
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif cords2 != 0
        pop!(set.activeS,source)
        if delta_y != 1 || abs(delta_x) != 1 || abs(cords2[2]-y) != 1 || 
           abs(cords2[1]-x) != 1 || haskey(set.activeS,cords2) != true
                return 0 
        else
            get!(set.activeS,source,piece)
            move_piece(set,enemy,piece,cords)
            move_piece(set,enemy,piece,cords2) 
            return 1   
        end
    elseif delta_y == -2 && delta_x == 0 
        move_piece(set,enemy,piece,cords); return 1
    else
        if abs(delta_x) == abs(delta_y)
            cords = range(set,enemy,piece,cords)
        elseif delta_x != 0 && delta_y == 0 # horizontal movemement
            cords = horizontal(set,enemy,source,cords)
        elseif delta_x == 0 && delta_y > 0
            cords = vertical(set,enemy,source,cords)
        end
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0
        end
    end
end

function move_red_horned_falcon(set::Pieces, enemy::Pieces, piece, cords, cords2)
     # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi 
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if piece[1] == 'H'
        move_bishop_general(set,enemy,piece,cords) == 1 ? (return 1) : (return 0)
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif cords2 != 0
        pop!(set.activeS,source)
        if delta_y != 1 || abs(delta_x) != 1 || abs(cords2[2]-y) != 1 || 
           abs(cords2[1]-x) != 1 || haskey(set.activeS,cords2) != true
                return 0 
        else
            get!(set.activeS,source,piece)
            move_piece(set,enemy,piece,cords)
            move_piece(set,enemy,piece,cords2) 
            return 1   
        end
    elseif delta_y == 2 && delta_x == 0 
        move_piece(set,enemy,piece,cords); return 1
    else
        if abs(delta_x) == abs(delta_y)
            cords = range(set,enemy,piece,cords)
        elseif delta_x != 0 && delta_y == 0 # horizontal movemement
            cords = horizontal(set,enemy,source,cords)
        elseif delta_x == 0 && delta_y > 0
            cords = vertical(set,enemy,source,cords)
        end
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0
        end
    end
end
    
# promoted dragon king = soaring eagle
function move_soaring_eagle(set::Pieces, enemy::Pieces, piece, cords, cords2)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi 
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'S'
        move_rook_general(set,enemy,piece,cords) == 1 ? (return 1) : (return 0)
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
        if set.color == "red"
            delta_y > 0 && return 0
        elseif set.color == "black"
            delta_y < 0 && return 0
        end
        cords = range(set,enemy,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
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
    delta_x = x - xi; delta_y = y - yi 
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if piece[1] == 'L'
        move_lion_hawk(set,enemy,piece,cords,cords) == 1 ? (return 1) : (return 0)
    elseif abs(delta_x) > 2 || abs(delta_y) > 2
        return 0
    elseif (abs(delta_x) > 1 || abs(delta_y) > 1) && cords2 != 0
        return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif cords2 != 0
        if abs(cords2[1]-x) <= 1 && 
           abs(cords2[2]-y) <= 1 
            pop!(set.activeS,source)
            if haskey(set.activeS,cords) != true && haskey(set.activeS,cords2) != true
                get!(set.activeS,source,piece)
                move_piece(set,enemy,piece,cords)
                move_piece(set,enemy,piece,cords2); return 1
            else return 0
            end
        else
            return 0
        end
    elseif cords2 == 0
        if (abs(delta_y) <= 2 && abs(delta_x) <= 2) && haskey(set.activeS,cords) != true 
            move_piece(set,enemy,piece,cords); return 1
        else return 0
        end
    else
        return 0
    end
end

# fire demon
function move_fire_demon(set::Pieces, enemy::Pieces, piece, 
                         cords,
                         cords2,
                         cords3)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2]; source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi 
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if cords2 != 0 && cords3 != 0
        pop!(set.activeS,source)
        if abs(delta_x) > 1 || abs(delta_y) > 1 ||
           abs(cords2[1]-cords[1]) > 1 || abs(cords2[2]-cords[2]) > 1 || 
           abs(cords3[1]-cords2[1]) > 1 || abs(cords3[2]-cords2[2]) > 1 ||
           haskey(set.activeS,cords) == true || haskey(enemy.activeS,cords) == true ||
           haskey(set.activeS,cords2) == true || haskey(enemy.activeS,cords2) == true ||
           haskey(set.activeS,cords3) == true

            get!(set.activeS,source,piece); return 0
        else       
            get!(set.activeS,source,piece)
            move_piece(set,enemy,piece,cords)
            move_piece(set,enemy,piece,cords2)
            move_piece(set,enemy,piece,cords3)
            burn(set,enemy,cords3); return 1
        end
    elseif cords2 != 0
        pop!(set.activeS,source)
        if abs(delta_x) > 1 || abs(delta_y) > 1 ||
           abs(cords2[1]-x) > 1 || abs(cords2[2]-y) > 1 ||
           haskey(set.activeS,cords) == true || haskey(enemy.activeS,cords) == true ||
           haskey(set.activeS,cords2) == true
            
            get!(set.activeS,source,piece); return 0
        else
            get!(set.activeS,source,piece)
            move_piece(set,enemy,piece,cords)
            move_piece(set,enemy,piece,cords2)
            burn(set,enemy,cords2); return 1
        end
    else
        if abs(delta_y) <= 1 && abs(delta_x) <= 1 && haskey(set.activeS,cords) != true 
            move_piece(set,enemy,piece,cords); return 1
        elseif delta_y == 0 && abs(delta_x) != 0
            cords = horizontal(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords)
                burn(B,set,enemy,cords); return 1
            else return 0
            end
        elseif abs(delta_x) == abs(delta_y)
            if x > xi && y > yi
                cords = top_right(set,enemy,source,cords)
            elseif x > xi && y < yi
                cords = bottom_right(set,enemy,source,cords)
            elseif x < xi && y < yi 
                cords = bottom_left(set,enemy,source,cords)
            elseif x < xi && y > yi 
                cords = top_left(set,enemy,source,cords)
            end
            if cords != 0
                move_piece(set,enemy,piece,cords)
                burn(set,enemy,cords); return 1
            else return 0
            end
        else return 0
        end
    end
end

# heavenly tetrarch == promoted chariot soldier
function move_heavenly_tetrarch(set::Pieces, enemy::Pieces, piece, 
                         cords,
                         cords2,
                         cords3)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2]; source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi 
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if cords2 != 0 && cords3 != 0 
        pop!(set.activeS,source)
        if haskey(enemy.activeS,cords2) == true || (cords2 == cords3)
            return 0
        elseif abs(delta_x) > 1 || abs(delta_y) > 1 ||
               abs(cords2[1]-cords[1]) > 1 || cords2[2]-cords[2] != 0 ||
               abs(cords3[1]-cords2[1]) > 1 || cords3[2]-cords2[2] != 0 ||
               haskey(set.activeS,cords2) == true ||  haskey(set.activeS,cords3) != true ||
               haskey(enemy.activeS,cords2) == true 
            return 0
        else
            get!(set.activeS,source,piece)
            haskey(set.activeS,cords) != true && move_piece(set,enemy,piece,cords)
            move_piece(set,enemy,piece,cords2); return 1
            move_piece(set,enemy,piece,cords3); return 1
        end
    elseif cords2 != 0 
        pop!(set.activeS,source)
        if abs(delta_x) > 1 || abs(delta_y) > 1 ||
           abs(cords2[1]-x) > 1 || abs(cords2[2]-y) > 1 ||
           haskey(set.activeS,cords) == true || haskey(set.activeS,cords2) == true
                return 0
        else
            get!(set.activeS,source,piece)
            move_piece(set,enemy,piece,cords)
            move_piece(set,enemy,piece,cords2); return 1
        end
    else
        if (delta_y == 0 && abs(delta_x) == 2) && haskey(set.activeS,cords) != true 
            move_piece(set,enemy,piece,cords); return 1
        elseif delta_x == 0 && abs(delta_y) > 1
            cords = vertical(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0
            end
        elseif abs(delta_x) == abs(delta_y) && abs(delta_x) > 1
            cords = range(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        else return 0
        end
    end
end

# free eagle
function move_free_eagle(set::Pieces, enemy::Pieces, piece, 
                         cords,
                         cords2)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2]; source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi 
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if cords2 != 0
        pop!(set.activeS,source)
        if abs(delta_y) != 1 && abs(delta_y) != 1
            return 0
        elseif abs(cords2[1]-cords[1]) != 1 || abs(cords2[2]-cords[2]) != 1
            return 0
        elseif haskey(set.activeS,cords) == true || haskey(set.activeS,cords2) == true
            return 0
        else
            get!(set.activeS,source,piece)
            move_piece(set,enemy,piece,cords)
            move_piece(set,enemy,piece,cords2); return 1
        end
    else
        if (abs(delta_y) <= 2 && abs(delta_x) <= 2) && haskey(set.activeS,cords) != true 
            move_piece(set,enemy,piece,cords); return 1
        elseif delta_y == 0 && abs(delta_x) != 0
            cords = horizontal(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0
            end
        elseif delta_x == 0 && abs(delta_y) != 0
            cords = vertical(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0
            end
        elseif abs(delta_x) == abs(delta_y)
            cords = range(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        else return 0
        end
    end
end

# lion hawk
function move_lion_hawk(set::Pieces, enemy::Pieces, piece, 
                         cords,
                         cords2)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2]; source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi 
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if (abs(delta_x) > 1 || abs(delta_y) > 1) && cords2 != 0
        return 0
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif cords2 != 0
        if abs(cords2[1]-x) <= 1 && 
           abs(cords2[2]-y) <= 1 
            pop!(set.activeS,source)
            if haskey(set.activeS,cords) != true && haskey(set.activeS,cords2) != true
                get!(set.activeS,source,piece)
                move_piece(set,enemy,piece,cords)
                move_piece(set,enemy,piece,cords2); return 1
            else return 0
            end
        else
            return 0
        end
    elseif cords2 == 0
        if (abs(delta_y) <= 2 && abs(delta_x) <= 2) && haskey(set.activeS,cords) != true 
            move_piece(set,enemy,piece,cords); return 1
        elseif abs(delta_x) == abs(delta_y)
            cords = range(set,enemy,source,cords)
            if cords != 0
                move_piece(set,enemy,piece,cords); return 1
            else return 0 
            end
        else return 0
        end
    else
        return 0
    end
end

# iron general
function move_red_iron_general(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'I'
        flag = move_v(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif delta_y == -1 && abs(delta_x) <= 1
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end
end

function move_black_iron_general(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2] 
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if piece[1] == 'I'
        flag = move_v(set,enemy,piece,cords)
        flag == 1 ? (return 1) : (return 0)
    elseif haskey(set.activeS,cords) == true
        return 0
    elseif delta_y == 1 && abs(delta_x) <= 1
        move_piece(set,enemy,piece,cords); return 1
    else
        return 0
    end
end

# bishop general
function move_bishop_general(set::Pieces, enemy::Pieces, piece, 
                             cords,
                             cords2,
                             cords3)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2]; source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if piece[1] == 'B'
        move_vice_general(set,enemy,piece,cords,cords2,cords3) == 1 ?
            (return 1) : 
            (return 0)
    elseif abs(delta_x) == abs(delta_y)
        cords = range_jump(set,enemy,piece,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    else return 0
    end
end

# rook general
function move_rook_general(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2]; source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0
    if piece[1] == 'R'
        move_rook_general(set,enemy,piece,cords,cords2,cords3) == 1 ?
            (return 1) : 
            (return 0)
    elseif delta_x == 0 && delta_y != 0
        cords = vertical_jump(set,enemy,piece,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    elseif delta_y == 0 && delta_x != 0
        cords = horizontal_jump(set,enemy,piece,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    else return 0
    end
end

# vice general
function move_vice_general(set::Pieces, enemy::Pieces, piece, 
                             cords,
                             cords2,
                             cords3)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2]; source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if cords2 != 0 && cords3 != 0
        pop!(set.activeS,source)
        if abs(delta_x) > 1 || abs(delta_y) > 1 ||
           abs(cords2[1]-cords[1]) > 1 || abs(cords2[2]-cords[2]) > 1 ||
           abs(cords3[1]-cords2[1]) > 1 || abs(cords3[2]-cords2[2]) > 1 ||
           haskey(set.activeS,cords) == true || haskey(enemy.activeS,cords) == true ||
           haskey(set.activeS,cords2) == true ||  haskey(enemy.activeS,cords2) == true ||
           haskey(set.activeS,cords3) == true 

            get!(set.activeS,source,piece); return 0
        else   
            get!(set.activeS,source,piece)
            move_piece(set,enemy,piece,cords)
            move_piece(set,enemy,piece,cords2)
            move_piece(set,enemy,piece,cords3); return 1
        end
    elseif cords2 != 0
        pop!(set.activeS,source)
        if abs(delta_x) > 1 || abs(delta_y) > 1 ||
           abs(cords2[1]-cords[1]) > 1 || abs(cords2[2]-cords[2]) > 1 ||
           haskey(set.activeS,cords) == true || haskey(enemy.activeS,cords) == true ||
           haskey(set.activeS,cords2) == true 
          
            get!(set.activeS,source,piece); return 0
        else   
            get!(set.activeS,source,piece)
            move_piece(set,enemy,piece,cords)
            move_piece(set,enemy,piece,cords2); return 1
        end
    elseif abs(delta_x) == abs(delta_y)
        cords = range_jump(set,enemy,piece,source,cords)
        if cords != 0
            move_piece(set,enemy,piece,cords); return 1
        else return 0 
        end
    else return 0
    end
end

# great general
function move_great_general(set::Pieces, enemy::Pieces, piece, cords)
    # initial x and y cords 
    xi = set.active[piece][1]; yi = set.active[piece][2]; source = (xi,yi)
    # target coordinates
    x = cords[1]; y = cords[2]
    # take differences
    delta_x = x - xi; delta_y = y - yi
    # check for inactivity and bounds
    (delta_x == 0 && delta_y == 0) && return 0 
    check_bounds(x,y) == 0 && return 0

    if abs(delta_x) == abs(delta_y)
        cords = range_jump(set,enemy,piece,source,cords)
    elseif delta_x == 0 && delta_y != 0
        cords = vertical_jump(set,enemy,piece,source,cords)
    elseif delta_y == 0 && delta_x != 0
        cords = horizontal_jump(set,enemy,piece,source,cords)
    end
    if cords != 0
        move_piece(set,enemy,piece,cords)
        burn(B,set,enemy,cords); return 1
    else 
        return 0
    end
end



### tests