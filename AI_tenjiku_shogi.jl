# include("general_functions.jl")
# include("tenjiku_shogi.jl")

# UTILITY FUNCTIONS
#--------------------------------------------------------------------------------
function range_AI(set::Pieces, enemy::Pieces, legal, source)
    friends = set.activeS; enemy = enemy.activeS
    x = source[1]; y = source[2]
    i = 1; cords = (x,y)
    while (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
        cords = (x+i,y+i)
        if haskey(friends,cords) == true
            break
        elseif haskey(enemy,cords) == true
            push!(legal,cords); break
        else push!(legal,cords)
        end
        i += 1
    end
    # moves towards the bottom right
    i = 1; cords = (x,y)
    while (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
        cords = (x+i,y-i)
       if haskey(friends,cords) == true
            break
        elseif haskey(enemy,cords) == true
            push!(legal,cords); break
        else push!(legal,cords)
        end
        i += 1
    end
    # moves towards bottom left
    i = 1; cords = (x,y)
    while (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
        cords = (x-i,y-i)
        if haskey(friends,cords) == true
            break
        elseif haskey(enemy,cords) == true
            push!(legal,cords); break
        else push!(legal,cords)
        end
        i += 1
    end
    # moves towards top left
    i = 1; cords = (x,y)
    while (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
        cords = (x-i,y+i)
        if haskey(friends,cords) == true
            break
        elseif haskey(enemy,cords) == true
            push!(legal,cords); break
        else push!(legal,cords)
        end
        i += 1
    end
    return legal
end

function range_jump_AI(set::Pieces, enemy::Pieces, legal, source)
    friends = set.activeS; enemy = enemy.activeS
    x = source[1]; y = source[2]
    i = 1; cords = (x,y); jumpFlag = 1
    while (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
        jumpFlag == 0 && break
        cords = (x+i,y+i)
        if haskey(enemy,cords) == true 
            temp_piece = enemy[cords] ; jump = 1 
        else jump = 0
        end
        if haskey(friends,cords) == true 
            temp_piece = friends[cords]; friend = 1 
        else friend = 0
        end
        if jump == 1 
            contains(enemy[cords],"king") && (jumpFlag = 0)
            contains(enemy[cords],"prince") && (jumpFlag = 0)
            enemy[cords] > temp_piece && (jumpFlag = 0)
            push!(legal,cords)
        elseif friend == 1 
            friends[cords] > temp_piece && (jumpFlag = 0)
        else
            push!(legal,cords)
        end
        i += 1
    end
    i = 1; cords = (x,y); jumpFlag = 1
    while (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
        jumpFlag == 0 && break
        cords = (x+i,y-i)
        if haskey(enemy,cords) == true 
            temp_piece = enemy[cords] ; jump = 1 
        else jump = 0
        end
        if haskey(friends,cords) == true 
            temp_piece = friends[cords]; friend = 1 
        else friend = 0
        end
        if jump == 1 
            contains(enemy[cords],"king") && (jumpFlag = 0)
            contains(enemy[cords],"prince") && (jumpFlag = 0)
            enemy[cords] > temp_piece && (jumpFlag = 0)
            push!(legal,cords)
        elseif friend == 1 
            friends[cords] > temp_piece && (jumpFlag = 0)
        else
            push!(legal,cords)
        end
        i += 1
    end 
    i = 1; cords = (x,y); jumpFlag = 1
    while (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
        jumpFlag == 0 && break
        cords = (x-i,y-i)
        if haskey(enemy,cords) == true 
            temp_piece = enemy[cords] ; jump = 1 
        else jump = 0
        end
        if haskey(friends,cords) == true 
            temp_piece = friends[cords]; friend = 1 
        else friend = 0
        end
        if jump == 1 
            contains(enemy[cords],"king") && (jumpFlag = 0)
            contains(enemy[cords],"prince") && (jumpFlag = 0)
            enemy[cords] > temp_piece && (jumpFlag = 0)
            push!(legal,cords)
        elseif friend == 1 
            friends[cords] > temp_piece && (jumpFlag = 0)
        else
            push!(legal,cords)
        end
        i += 1
    end
    i = 1; cords = (x,y); jumpFlag = 1
    while (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
        jumpFlag == 0 && break
        cords = (x-i,y+i)
        if haskey(enemy,cords) == true 
            temp_piece = enemy[cords] ; jump = 1 
        else jump = 0
        end
        if haskey(friends,cords) == true 
            temp_piece = friends[cords]; friend = 1 
        else friend = 0
        end
        if jump == 1 
            contains(enemy[cords],"king") && (jumpFlag = 0)
            contains(enemy[cords],"prince") && (jumpFlag = 0)
            enemy[cords] > temp_piece && (jumpFlag = 0)
            push!(legal,cords)
        elseif friend == 1 
            friends[cords] > temp_piece && (jumpFlag = 0)
        else
            push!(legal,cords)
        end
        i += 1
    end
    return legal
end

function rear_range_AI(set::Pieces, enemy::Pieces, legal, source)
    friends = set.activeS; enemy = enemy.activeS
    x = source[1]; y = source[2]
    # moves towards the bottom right
    i = 1; cords = (x,y)
    while (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
        cords = (x+i,y-i)
       if haskey(friends,cords) == true
            break
        elseif haskey(enemy,cords) == true
            push!(legal,cords); break
        else push!(legal,cords)
        end
        i += 1
    end
    # moves towards bottom left
    i = 1; cords = (x,y)
    while (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
        cords = (x-i,y-i)
        if haskey(friends,cords) == true
            break
        elseif haskey(enemy,cords) == true
            push!(legal,cords); break
        else push!(legal,cords)
        end
        i += 1
    end
    return legal
end

function front_range_AI(set::Pieces, enemy::Pieces, legal, source)
    friends = set.activeS; enemy = enemy.activeS
    x = source[1]; y = source[2]
    i = 1; cords = (x,y)
    while (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
        cords = (x+i,y+i)
        if haskey(friends,cords) == true
            break
        elseif haskey(enemy,cords) == true
            push!(legal,cords); break
        else push!(legal,cords)
        end
        i += 1
    end
    i = 1; cords = (x,y)
    while (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
        cords = (x-i,y+i)
        if haskey(friends,cords) == true
            break
        elseif haskey(enemy,cords) == true
            push!(legal,cords); break
        else push!(legal,cords)
        end
        i += 1
    end
    return legal
end

function top_right_diagonal_AI(set::Pieces, enemy::Pieces, legal, source)
    friends = set.activeS; enemy = enemy.activeS
    x = source[1]; y = source[2]
    i = 1; cords = (x,y)
    while (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
        cords = (x+i,y+i)
        if haskey(friends,cords) == true
            break
        elseif haskey(enemy,cords) == true
            push!(legal,cords); break
        else push!(legal,cords)
        end
        i += 1
    end
    return legal
end

function top_left_diagonal_AI(set::Pieces, enemy::Pieces, legal, source)
    friends = set.activeS; enemy = enemy.activeS
    x = source[1]; y = source[2]
    i = 1; cords = (x,y)
    while (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
        cords = (x-i,y+i)
        if haskey(friends,cords) == true
            break
        elseif haskey(enemy,cords) == true
            push!(legal,cords); break
        else push!(legal,cords)
        end
        i += 1
    end
    return legal
end

function bottom_right_diagonal_AI(set::Pieces, enemy::Pieces, legal, source)
    friends = set.activeS; enemy = enemy.activeS
    x = source[1]; y = source[2]
    i = 1; cords = (x,y)
    while (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
        cords = (x+i,y-i)
        if haskey(friends,cords) == true
            break
        elseif haskey(enemy,cords) == true
            push!(legal,cords); break
        else push!(legal,cords)
        end
        i += 1
    end
    return legal
end

function bottom_left_diagonal_AI(set::Pieces, enemy::Pieces, legal, source)
    friends = set.activeS; enemy = enemy.activeS
    x = source[1]; y = source[2]
    i = 1; cords = (x,y)
    while (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
        cords = (x-i,y-i)
        if haskey(friends,cords) == true
            break
        elseif haskey(enemy,cords) == true
            push!(legal,cords); break
        else push!(legal,cords)
        end
        i += 1
    end
    return legal
end

function cross_AI(set::Pieces, enemy::Pieces, legal, source)
    x = source[1]; y = source[2]
    friends = set.activeS; enemy = enemy.activeS
    for i = y+1:16 # move upwards
        cords = (x,i)
        if haskey(enemy,cords) == true
            push!(legal,cords); break
        elseif haskey(friends,cords) != true
            push!(legal,cords)
        else break
        end
    end
    for i = y-1:-1:1 # move downwards
        cords = (x,i)
        if haskey(enemy,cords) == true
            push!(legal,cords); break
        elseif haskey(friends,cords) != true
            push!(legal,cords)
        else break
        end
    end
    for i = x+1:16 # move rightwards
        cords = (i,y)
        if haskey(enemy,cords) == true
            push!(legal,cords); break
        elseif haskey(friends,cords) != true
            push!(legal,cords)
        else break
        end
    end
    for i = x-1:-1:1
     # move leftwards
        cords = (i,y)
        if haskey(enemy,cords) == true
            push!(legal,cords); break
        elseif haskey(friends,cords) != true
            push!(legal,cords)
        else break
        end
    end
    return legal
end

function cross_jump_AI(set::Pieces, enemy::Pieces, legal, source)
    x = source[1]; y = source[2]
    cords = (x,y)
    friends = set.activeS; enemy = enemy.activeS
    jumpFlag = 1
    for i = y+1:16 # move upwards
        cords = (x,i)
        jumpFlag == 0 && break
        if haskey(enemy,cords) == true 
            temp_piece = enemy[cords] ; jump = 1 
        else jump = 0
        end
        if haskey(friends,cords) == true 
            temp_piece = friends[cords]; friend = 1 
        else friend = 0
        end
        if jump == 1 
            contains(enemy[cords],"king") && (jumpFlag = 0)
            contains(enemy[cords],"prince") && (jumpFlag = 0)
            enemy[cords] > temp_piece && (jumpFlag = 0)
            push!(legal,cords)
        elseif friend == 1 
            friends[cords] > temp_piece && (jumpFlag = 0)
        else
            push!(legal,cords)
        end
    end
    jumpFlag = 1
    for i = y-1:-1:1 # move upwards
        cords = (x,i)
        jumpFlag == 0 && break
        if haskey(enemy,cords) == true 
            temp_piece = enemy[cords] ; jump = 1 
        else jump = 0
        end
        if haskey(friends,cords) == true 
            temp_piece = friends[cords]; friend = 1 
        else friend = 0
        end
        if jump == 1 
            contains(enemy[cords],"king") && (jumpFlag = 0)
            contains(enemy[cords],"prince") && (jumpFlag = 0)
            enemy[cords] > temp_piece && (jumpFlag = 0)
            push!(legal,cords)
        elseif friend == 1 
            friends[cords] > temp_piece && (jumpFlag = 0)
        else
            push!(legal,cords)
        end
    end
    jumpFlag = 1
    for i = x+1:16 # move upwards
        cords = (i,y)
        jumpFlag == 0 && break
        if haskey(enemy,cords) == true 
            temp_piece = enemy[cords] ; jump = 1 
        else jump = 0
        end
        if haskey(friends,cords) == true 
            temp_piece = friends[cords]; friend = 1 
        else friend = 0
        end
        if jump == 1 
            contains(enemy[cords],"king") && (jumpFlag = 0)
            contains(enemy[cords],"prince") && (jumpFlag = 0)
            enemy[cords] > temp_piece && (jumpFlag = 0)
            push!(legal,cords)
        elseif friend == 1 
            friends[cords] > temp_piece && (jumpFlag = 0)
        else
            push!(legal,cords)
        end
    end
     jumpFlag = 1
    for i = x-1:-1:1 # move upwards
        cords = (i,y)
        jumpFlag == 0 && break
        if haskey(enemy,cords) == true 
            temp_piece = enemy[cords]; jump = 1 
        else jump = 0
        end
        if haskey(friends,cords) == true 
            temp_piece = friends[cords]; friend = 1 
        else friend = 0
        end
        if jump == 1 
            contains(enemy[cords],"king") && (jumpFlag = 0)
            contains(enemy[cords],"prince") && (jumpFlag = 0)
            enemy[cords] > temp_piece && (jumpFlag = 0)
            push!(legal,cords)
        elseif friend == 1 
            friends[cords] > temp_piece && (jumpFlag = 0)
        else
            push!(legal,cords)
        end
    end
    return legal
end

function vertical_AI(set::Pieces, enemy::Pieces, legal, source)
    x = source[1]; y = source[2]
    friends = set.activeS; enemy = enemy.activeS
    for i = y+1:16 # move upwards
        cords = (x,i)
        if haskey(enemy,cords) == true
            push!(legal,cords); break
        elseif haskey(friends,cords) != true
            push!(legal,cords)
        else break
        end
    end
    for i = y-1:-1:1 # move downwards
        cords = (x,i)
        if haskey(enemy,cords) == true
            push!(legal,cords); break
        elseif haskey(friends,cords) != true
            push!(legal,cords)
        else break
        end
    end
    return legal
end

function front_vertical_AI(set::Pieces, enemy::Pieces, legal, source)
    x = source[1]; y = source[2]
    friends = set.activeS; enemy = enemy.activeS
    for i = y+1:16 # move upwards
        cords = (x,i)
        if haskey(enemy,cords) == true
            push!(legal,cords); break
        elseif haskey(friends,cords) != true
            push!(legal,cords)
        else break
        end
    end
    return legal
end

function rear_vertical_AI(set::Pieces, enemy::Pieces, legal, source)
    x = source[1]; y = source[2]
    friends = set.activeS; enemy = enemy.activeS
    for i = y-1:-1:1 # move downwards
        cords = (x,i)
        if haskey(enemy,cords) == true
            push!(legal,cords); break
        elseif haskey(friends,cords) != true
            push!(legal,cords)
        else break
        end
    end
    return legal
end

function horizontal_AI(set::Pieces, enemy::Pieces, legal, source)
    x = source[1]; y = source[2]
    friends = set.activeS; enemy = enemy.activeS
    for i = x+1:16 # move rightwards
        cords = (i,y)
        if haskey(enemy,cords) == true
            push!(legal,cords); break
        elseif haskey(friends,cords) != true
            push!(legal,cords)
        else break
        end
    end
    for i = x-1:-1:1
     # move leftwards
        cords = (i,y)
        if haskey(enemy,cords) == true
            push!(legal,cords); break
        elseif haskey(friends,cords) != true
            push!(legal,cords)
        else break
        end
    end
    return legal
end
#----------------------------------------------------------------------------------

# GENERATING MOVE FUNCTIONS
#-----------------------------------------------------------------------------------
# Pawns
# this function will be called in the main, and calls correct pawn function 
function pawn_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    set.color == "black" ? 
        black_pawn_AI(set,enemy,legal,piece) : 
        red_pawn_AI(set,enemy,legal,piece)
end

function red_pawn_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords
    x = set.active[piece][1]; y = set.active[piece][2]
    # friendly units
    friendly = set.activeS
    if piece[1] == 'P' # check for promotion
        legal = gold_general_AI(set,enemy,legal,piece)
        return legal
    else
        if y != 16
            haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end
    end
    return legal
end

function black_pawn_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords
    x = set.active[piece][1]; y = set.active[piece][2]
    # friendly units
    friendly = set.activeS
    if piece[1] == 'P' # check for promotion
        legal = gold_general_AI(set,enemy,legal,piece)
        return legal
    else
        if y != 1
            haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        end
    end
    return legal
end

# vertical mover, v
function vertical_mover_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords
    x = set.active[piece][1]; y = set.active[piece][2]
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS
    if piece[1] == 'V'
        legal = flying_ox_AI(set,enemy,legal,piece)
        (x != 16 && haskey(friendly,(x+1,y)) != true) && push!(legal,(x+1,y))
        (x != 1 && haskey(friendly,(x-1,y)) != true) && push!(legal,(x-1,y))
        return legal
    else
        legal = vertical_AI(set,enemy,legal,cords)
        cords = (x+1,y) # move right
        if x != 16 && haskey(friendly,cords) != true
            push!(legal,cords)
        end
        cords = (x-1,y) # move left
        if x != 1 && haskey(friendly,cords) != true
            push!(legal, cords)
        end
        return legal
    end
end

function flying_ox_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords
    x = set.active[piece][1]; y = set.active[piece][2]
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS
    legal = range_AI(set,enemy,legal,cords)
    legal = vertical_AI(set,enemy,legal,cords)
    return legal
end

# dragon king, d
function dragon_king_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS

    # check if promoted, becomes soaring eagle
    if piece[1] == 'D'
        legal = soaring_eagle_AI(set,enemy,legal,piece); return legal
    end
    legal = cross_AI(set,enemy,legal,cords)
    # step bottom left and bottom right
    if y != 1 && x != 1
        haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
    end
    if y != 1 && x != 16
        haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
    end
    # step top left and top right
    if y != 16 && x != 16
        haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
    end
    if y != 16 && x != 1
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
    end    
    return legal
end

function soaring_eagle_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS
    if set.color == "red" 
        legal = rear_range_AI(set,enemy,legal,cords)
        # lion moves
        if x != 1 && y != 16# step top left
            haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
        end
        if x > 2 && y < 15 # jump top left
            haskey(friendly,(x-2,y+2)) == 0 && push!(legal,(x-2,y+2))
        end
        if x > 2 && y < 15 # step top left, step top left
            (haskey(friendly,(x-1,y+1)) == 0 && haskey(friendly,(x-2,y+2)) == 0) && push!(legal,((x-1,y+1),(x-2,y+2)))
        end
        if x != 1 && y != 16 # step top left, step bottom right
            haskey(friendly,(x-1,y+1)) == 0 && push!(legal,((x-1,y+1),(x,y)))
        end

        if x != 16 && y != 16 # step top right
            haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
        end
        if x < 15 && y < 15 # jump top right
            haskey(friendly,(x+2,y+2)) == 0 && push!(legal,(x+2,y+2))
        end
        if x < 15 && y < 15 # step top right, step top right
            (haskey(friendly,(x+1,y+1)) == 0 && haskey(friendly,(x+2,y+2)) == 0) && push!(legal,((x+1,y+1),(x+2,y+2)))
        end
        if x != 16 && y != 16 # step top right, step bottom left
            haskey(friendly,(x+1,y+1)) == 0 && push!(legal,((x+1,y+1),(x,y)))
        end
    else
        legal = front_range_AI(set,enemy,legal,cords)
        # lion moves
        if x != 1 && y != 1 # step bottom left
            haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
        end
        if x > 2 && y > 2 # jump bottom left
            haskey(friendly,(x-2,y-2)) == 0 && push!(legal,(x-2,y-2))
        end
        if x > 2 && y > 2 # step bottom left, step bottom left
            (haskey(friendly,(x-1,y-1)) && haskey(friendly,(x-2,y-2)) == 0) && push!(legal,((x-1,y-1),(x-2,y-2))) 
        end
        if x != 1 && y != 1 # step bottom left, step top right
            haskey(friendly,(x-1,y-1)) == 0 && push!(legal,((x-1,y-1),(x,y)))
        end

        if x != 16 && y != 1 # step bottom right
            haskey(friendly,(x+1,y-2)) == 0 && push!(legal,(x+1,y-2))
        end
        if x < 15 && y > 2 # jump bottom right
            haskey(friendly,(x+2,y-2)) == 0 && push!(legal,(x+2,y-2))
        end
        if x < 15 && y > 2 # step bottom right, step bottom right
            (haskey(friendly,(x+1,y-1)) && haskey(friendly,(x+2,y-2)) == 0) && push!(legal,((x+1,y-1),(x+2,y-2)))
        end
        if x != 16 && y != 1 # step bottom right, step top left
            haskey(friendly,(x+1,y-1)) == 0 && push!(legal,((x+1,y-1),(x,y)))
        end
    end
    return legal
end

# reverse chariot, a
function reverse_chariot_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS
    legal = vertical_AI(set,enemy,legal,cords)
    legal = horizontal_AI(set,enemy,legal,cords)
    # check if promoted, becomes whale
    if piece[1] == 'R' && set.color == "red"   
        legal = rear_range_AI(set,enemy,legal,cords)
    elseif piece[1] == 'R' && set.color == "black"    
        legal = front_range_AI(set,enemy,legal,cords)
    end
    return legal
end

# finds all the possible moves for bishop given its position
function bishop_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friends = set.activeS
    # if piece is promoted add additional moves of king
    piece == "B" && (legal = king_AI(set,legal,piece))
    # if unpromoted
    legal = range_AI(set,enemy,legal,cords)
    return legal
end

# finds all possible moves for rook given its current coordinates
function rook_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friends = set.activeS
    # check if promoted
    piece == "R" && (legal = king_AI(set,legal,piece))
    # if unpromoted
    legal = cross_AI(set,enemy,legal,cords)
    return legal
end

# ferocious leopard, f
function ferocious_leopard_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2]
    # friendly units
    friendly = set.activeS

    # check if promoted, becomes bishop
    if piece[1] == 'F'
        legal = bishop_AI(set,enemy,legal,piece)
    # not promoted
    else
        # step bottom left and bottom right
        if y != 1 && x != 1
            haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
        end
        if y != 1 && x != 16
            haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
        end
        # step top left and top right
        if y != 12 && x != 16
            haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
        end
        if y != 12 && x != 1
             haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
         end
        # step up
        if y != 16
            haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end
        # step down
        if y != 1
            haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        end
    end
    return legal
end

# silver general, s

# general silver general function calls correct colored silver general function
function silver_general_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    set.color == "black" ?
        black_silver_general_AI(set,enemy,legal,piece) :
        red_silver_general_AI(set,enemy,legal,piece)
end

function black_silver_general_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    # friendly units
    friendly = set.activeS
    if piece[1] == 'S'
        legal = vertical_mover_AI(set,enemy,legal,piece)
        return legal
    elseif y != 1 && x != 1 && x != 16 # if piece is not on a boundary
        haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
        haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
    elseif y != 1 && x == 16 # if piece is on right side of board, and y != 1
        haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
        haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
    elseif y != 1 && x == 1 # if piece is on left side of board, and y != 1
        haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
        haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
    end
    if y != 16 && x != 1
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
    end
    if y != 16 && x != 16
        haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
    end
    return legal
end

function red_silver_general_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    # friendly units
    friendly = set.activeS
    if piece[1] == 'S' # if silver general is promoted
        legal = vertical_mover_AI(set,enemy,legal,piece)
        return legal
    elseif y != 16 && x != 16 && x != 1 
        haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
    elseif y != 16 && x == 16 # if piece is on left side of board, and y != 16
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
        haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
    elseif y != 16 && x == 1 # if piece is on right side of board, and y != 16
        haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
        haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
    end
   if y != 16 && x != 1
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
    end
    if y != 16 && x != 16
        haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
    end
    return legal
end

# king, k
function king_AI(set::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} # stores possible coordinates 
    # friendly units
    friends = set.activeS
    cords = (x,y+1)  # step up
    if y != 16 && haskey(friends,cords) != true
        push!(legal,cords) 
    end
    cords = (x,y-1) # step down
    if y != 1 && haskey(friends,cords) != true
        push!(legal,cords)
    end
    cords = (x+1,y) # step right    
    if x != 16 && haskey(friends,cords) != true
        push!(legal,cords)
    end
    cords = (x-1,y) # step left
    if x != 1 && haskey(friends,cords) != true
        push!(legal,cords)
    end
    if x != 16 && y != 16 # step top right
        haskey(friends,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
    end
    if x != 1 && y != 16 # step top left
        haskey(friends,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
    end
    if x != 16 && y != 1 # step bottom right
        haskey(friends,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
    end
    if x != 1 && y != 1 # step bottom left
        haskey(friends,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
    end
    return legal
end

# drunk elephant, e
function drunk_elephant_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    # friendly units
    friendly = set.activeS

    # these moves are allowable for both promoted and unpromoted
    # step bottom left and bottom right
    if y != 1 && x != 1
        haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
    end
    if y != 1 && x != 16
        haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
    end
    # step top left and top right
    if y != 16 && x != 16
        haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
    end
    if y != 16 && x != 1
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
    end
    # step left
    if x != 1
        haskey(friendly,(x-1,y)) == 0 && push!(legal,(x-1,y))
    end
    # step right
    if x != 16
        haskey(friendly,(x+1,y)) == 0 && push!(legal,(x+1,y))
    end

    # check if promoted, becomes prince (same moveset as king)
    if piece == 'E'
        # step down
        if y != 1
            haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        end
        # step up
        if y != 16
            haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end

    # if not promoted
    else
        if set.color == "black"
            # step down
            if y != 1
                haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
            end
        elseif set.color == "red"
            # step up
            if y != 16
                haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
            end
        end
    end
    return legal
end

# queen, q (promotes to free eagle)
function queen_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords
    x = set.active[piece][1]; y = set.active[piece][2]
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS
    # check for promotion, becomes free eagle
    if piece[1] == 'Q'
        legal = free_eagle_AI(set,enemy,legal,piece)
    else
        legal = cross_AI(set,enemy,legal,cords)
        legal = range_AI(set,enemy,legal,cords)
    end
    return legal
end

# phoenix, x
function phoenix_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    # friendly units
    friendly = set.activeS

    # check if promoted, becomes queen
    if piece == 'P'
        legal = queen_AI(set,enemy,legal,piece)
    # not promoted
    else
        # step left
        if x != 1
            haskey(friendly,(x-1,y)) == 0 && push!(legal,(x-1,y))
        end
        # step right
        if x != 16
            haskey(friendly,(x+1,y)) == 0 && push!(legal,(x+1,y))
        end
        # step down
        if y != 1
            haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        end
        # step up
        if y != 16
            haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end

        # original position at bottom left corner
        if x <= 2 && y <= 2
            haskey(friendly,(x+2,y+2)) == 0 && push!(legal,(x+2,y+2))   # top right
        # original position at bottom right corner
        elseif x >= 15 && y <= 2
            haskey(friendly,(x-2,y+2)) == 0 && push!(legal,(x-2,y+2))   # top left
        # original position at top left coner
        elseif x <= 2 && y >= 15
            haskey(friendly,(x+2,y-2)) == 0 && push!(legal,(x+2,y-2))   # bottom right
        # original position at top right corner
        elseif x >= 15 && y >= 15
            haskey(friendly,(x-2,y-2)) == 0 && push!(legal,(x-2,y-2))   # bottom left
        # original position at bottom (but not corners)
        elseif x >= 3 && x <= 14 && y <= 2 && y >= 1
            haskey(friendly,(x-2,y+2)) == 0 && push!(legal,(x-2,y+2))   # top left
            haskey(friendly,(x+2,y+2)) == 0 && push!(legal,(x+2,y+2))   # top right
        # original position at top (but not corners)
        elseif x >= 3 && x <= 14 && y <= 16 && y >= 15
            haskey(friendly,(x-2,y-2)) == 0 && push!(legal,(x-2,y-2))   # bottom left
            haskey(friendly,(x+2,y-2)) == 0 && push!(legal,(x+2,y-2))   # bottom right
        # original position at left side (but not corners)
        elseif x >= 1 && x <= 2 && y >= 3 && y <= 14
            haskey(friendly,(x+2,y+2)) == 0 && push!(legal,(x+2,y+2))   # top right
            haskey(friendly,(x+2,y-2)) == 0 && push!(legal,(x+2,y-2))   # bottom right
        # original position at right side (but not corners)
        elseif x >= 15 && x <= 16 && y >= 3 && y <= 14
            haskey(friendly,(x-2,y+2)) == 0 && push!(legal,(x-2,y+2))   # top left
            haskey(friendly,(x-2,y-2)) == 0 && push!(legal,(x-2,y-2))   # bottom left
        # otherwise, original position within centre of board
        else
            haskey(friendly,(x-2,y+2)) == 0 && push!(legal,(x-2,y+2))   # top left
            haskey(friendly,(x+2,y+2)) == 0 && push!(legal,(x+2,y+2))   # top right
            haskey(friendly,(x-2,y-2)) == 0 && push!(legal,(x-2,y-2))   # bottom left
            haskey(friendly,(x+2,y-2)) == 0 && push!(legal,(x+2,y-2))   # bottom right
        end
    end
    return legal
end

# go-between, o
function go_between_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    # friendly units
    friendly = set.activeS

    # check if promoted, becomes drunk elephant
    if piece[1] == 'G'
        legal = drunk_elephant_AI(set,enemy,legal,piece)
    # not promoted
    else
        # step up
        if y != 16
            haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end
        # step down
        if y != 1
            haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        end
    end
    return legal 
end

# side mover, m
function side_mover_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2]
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS

    # check if promoted, becomes free boar
    if piece[1] == 'S' 
        legal = range_AI(set,enemy,legal,cords); return legal
    else # not promoted
    # move leftwards and rightwards allowable for promoted and unpromoted
        legal = horizontal_AI(set,enemy,legal,cords)
        if y != 16
            haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end
        # step down
        if y != 1
            haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        end
    end
    return legal
end

# dragon horse, h
function dragon_horse_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2]
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS
    if piece[1] == 'D'
        legal = horned_falcon_AI(set,enemy,legal,piece); return legal
    end
    legal = range_AI(set,enemy,legal,cords)   
    (y != 16 && haskey(friendly,(x,y+1)) == 0) && push!(legal,(x,y+1))
    (y != 1 && haskey(friendly,(x,y-1)) == 0) && push!(legal,(x,y-1))
    (x != 1 && haskey(friendly,(x-1,y)) == 0) && push!(legal,(x-1,y))
    (x != 16 && haskey(friendly,(x+1,y)) == 0) && push!(legal,(x+1,y))
    return legal
end

function horned_falcon_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2]
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS
    if set.color == "red"
        legal = rear_vertical_AI(set,enemy,legal,cords)
        # lion moves
        if y != 16 # step up
            haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end
        if y < 15 # jump up
            haskey(friendly,(x,y+2)) == 0 && push!(legal,(x,y+2))
        end
        if y < 15 # step up, step up
            (haskey(friendly,(x,y+1)) == 0 && haskey(friendly,(x,y+2)) == 0) && push!(legal,((x,y+1),(x,y+2)))
        end
        if y <= 15 # step up, step down
            haskey(friendly,(x,y+1)) == 0 && push!(legal,((x,y+1),(x,y)))
        end
    else
        legal = front_vertical_AI(set,enemy,legal,cords)
        # lion moves
        if y != 1 # step down
            haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        end
        if y > 2 # jump down
            haskey(friendly,(x,y-2)) == 0 && push!(legal,(x,y-2))
        end
        if y != 1 # step down, step down
            (haskey(friendly,(x,y-1)) == 0 && haskey(friendly,(x,y-2)) == 0) && push!(legal,((x,y-1),(x,y-2)))
        end
        if y > 2 # step down, step up
            haskey(friendly,(x,y-1)) == 0 && push!(legal,((x,y-1),(x,y)))
        end
    end
    legal = range_AI(set,enemy,legal,cords)
    legal = horizontal_AI(set,enemy,legal,cords)
    return legal
end

# lancer, l
function lancer_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    set.color == "black" ? 
        black_lancer_AI(set,enemy,legal,piece) :
        red_lancer_AI(set,enemy,legal,piece)
end

function black_lancer_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS
    if piece[1] == 'L' # check for promotion
        legal = white_horse_AI(set,enemy,legal,piece)
    else
        legal = rear_vertical_AI(set,enemy,legal,cords)   
    end
    return legal
end

function red_lancer_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS
    if piece[1] == 'L' # check for promotion
        legal = white_horse_AI(set,enemy,legal,piece)
    else
       legal = front_vertical_AI(set,enemy,legal,cords)
    end
    return legal
end

# white horse, promoted lancer
function white_horse_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates 
    # friendly units
    friendly = set.activeS
    legal = vertical_AI(set,enemy,legal,cords)
    if set.color == "red"
        legal = front_range_AI(set,enemy,legal,cords)
    elseif set.color == "black"
        legal = rear_range_AI(set,enemy,legal,cords)
    end
    return legal
end

# blind tiger, t
function blind_tiger_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates 
    # friendly units
    friendly = set.activeS

    # these moves allowable for promoted and unpromoted
    # step bottom left and bottom right
    if y != 1 && x != 1
        haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
    end
    if y != 1 && x != 16
        haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
    end
    # step top left and top right
    if y != 16 && x != 16
        haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
    end
    if y != 16 && x != 1
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
    end
    # step left
    if x != 1
        haskey(friendly,(x-1,y)) == 0 && push!(legal,(x-1,y))
    end
    # step right
    if x != 16
        haskey(friendly,(x+1,y)) == 0 && push!(legal,(x+1,y))
    end
    # check if promoted, becomes flying stag
    if piece[1] == 'B'
        legal = vertical_AI(set,enemy,legal,cords)
    # not promoted
    else
        # add step down
        if set.color == "red"
            if y != 1
                haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
            end
        elseif set.color == "black" && y != 16
            haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end
    end
    return legal
end

# copper general, c
function copper_general_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    # friendly units
    friendly = set.activeS

    # check if promoted, becomes side mover
    if piece[1] == 'C'
        legal = side_mover_AI(set,enemy,legal,piece)
    # not promoted
    else
        # step up
        if y != 16
            haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end
        # step down
        if y != 1
            haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        end
        if set.color == "black"
            # step bottom left and bottom right
            if y != 1 && x != 1
                haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
            end
            if y != 1 && x != 16
                haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
            end
        elseif set.color == "red"
            # step top left and top right
            if y != 16 && x != 16
                haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
            end
            if y != 16 && x != 1
                haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
            end
        end
    end
    return legal
end

# gold general, g
function gold_general_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    # friendly units
    friendly = set.activeS
    # check if promoted, becomes rook
    if piece[1] == 'G'
        legal = rook_AI(set,enemy,legal,piece)
    # not promoted
    else
        # step left
        if x != 1
            haskey(friendly,(x-1,y)) == 0 && push!(legal,(x-1,y))
        end
        # step right
        if x != 16
            haskey(friendly,(x+1,y)) == 0 && push!(legal,(x+1,y))
        end
        # step up
        if y != 16
            haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end
        # step down
        if y != 1
            haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        end
        # add diagonal steps depending on colour set
        if set.color == "red"
            # step top left and top right
            if y != 16 && x != 16
                haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
            end
            if y != 16 && x != 1
                haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
            end  
        elseif set.color == "black"
            # step bottom left and bottom right
            if y != 1 && x != 1
                haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
            end
            if y != 1 && x != 16
                haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
            end
        end
    end
    return legal
end

# kirin, n
function kirin_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    # friendly units
    friendly = set.activeS

    # check if promoted, becomes lion
    if piece == 'K'
        # lion moveset
        legal = lion_AI(set,enemy,legal,piece)
    # not promoted
    else
        # step top left and top right
        if y != 16 && x != 16
            haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
        end
        if y != 16 && x != 1
            haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
        end
        # step bottom left and bottom right
        if y != 1 && x != 1
            haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
        end
        if y != 1 && x != 16
            haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
        end
        # if original position is at bottom left corner
        if x <= 2 && y <= 2
            haskey(friendly,(x,y+2)) == 0 && push!(legal,(x,y+2))   # jump top
            haskey(friendly,(x+2,y)) == 0 && push!(legal,(x+2,y))   # jump right
        # if original position is at bottom right corner
        elseif x >= 15 && y <= 2
            haskey(friendly,(x,y+2)) == 0 && push!(legal,(x,y+2))   # jump top
            haskey(friendly,(x-2,y)) == 0 && push!(legal,(x-2,y))   # jump left
        # if original position is at top left corner
        elseif x <= 2 && y >= 15
            haskey(friendly,(x+2,y)) == 0 && push!(legal,(x+2,y))   # jump right
            haskey(friendly,(x,y-2)) == 0 && push!(legal,(x,y-2))   # jump bottom
        # if original position is at top right corner
        elseif x >= 15 && y >= 15
            haskey(friendly,(x-2,y)) == 0 && push!(legal,(x-2,y))   # jump left
            haskey(friendly,(x,y-2)) == 0 && push!(legal,(x,y-2))   # jump bottom
        # if original position is at bottom (but not corners)
        elseif x >= 3 && x <= 14 && y <= 2 && y >= 1
            haskey(friendly,(x-2,y)) == 0 && push!(legal,(x-2,y))   # jump left
            haskey(friendly,(x+2,y)) == 0 && push!(legal,(x+2,y))   # jump right
            haskey(friendly,(x,y+2)) == 0 && push!(legal,(x,y+2))   # jump top
        # original position at top (but not corners)
        elseif x >= 3 && x <= 14 && y <= 16 && y >= 15
            haskey(friendly,(x-2,y)) == 0 && push!(legal,(x-2,y))   # jump left
            haskey(friendly,(x+2,y)) == 0 && push!(legal,(x+2,y))   # jump right
            haskey(friendly,(x,y-2)) == 0 && push!(legal,(x,y-2))   # jump bottom
        # original position at left side (but not corners)
        elseif x >= 1 && x <= 2 && y >= 3 && y <= 14
            haskey(friendly,(x,y+2)) == 0 && push!(legal,(x,y+2))   # jump top
            haskey(friendly,(x,y-2)) == 0 && push!(legal,(x,y-2))   # jump bottom
            haskey(friendly,(x+2,y)) == 0 && push!(legal,(x+2,y))   # jump right
        # original position at right side (but not corners)
        elseif x >= 15 && x <= 16 && y >= 3 && y <= 14
            haskey(friendly,(x,y+2)) == 0 && push!(legal,(x,y+2))   # jump top
            haskey(friendly,(x,y-2)) == 0 && push!(legal,(x,y-2))   # jump bottom
            haskey(friendly,(x-2,y)) == 0 && push!(legal,(x-2,y))   # jump left
        # otherwise, original position within centre of board
        else
            haskey(friendly,(x-2,y)) == 0 && push!(legal,(x-2,y))   # jump left
            haskey(friendly,(x+2,y)) == 0 && push!(legal,(x+2,y))   # jump right
            haskey(friendly,(x,y+2)) == 0 && push!(legal,(x,y+2))   # jump top
            haskey(friendly,(x,y-2)) == 0 && push!(legal,(x,y-2))   # jump bottom
        end
    end
    return legal
end

# lion AI - liiiooon
function lion_steps(x::Int64, y::Int64)
    temp = Tuple{Int,Int}[]
    legal = Tuple{Int,Int}[]
    push!(temp,(x,y+1)); push!(temp,(x,y-1)); push!(temp,(x+1,y))
    push!(temp,(x-1,y)); push!(temp,(x+1,y+1)); push!(temp,(x-1,y-1))
    push!(temp,(x+1,y-1)); push!(temp,(x-1,y+1))
    for i = 1:length(temp)
        cords = temp[i]
        if (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
            push!(legal,cords)
        end
    end
    return legal
end

function lion_jumps(x::Int64, y::Int64)
    temp = Tuple{Int,Int}[]
    legal = Tuple{Int,Int}[]
    push!(temp,(x,y+2)); push!(temp,(x,y-2))
    push!(temp,(x+2,y)); push!(temp,(x-2,y))
    push!(temp,(x+2,y+2)); push!(temp,(x-2,y-2))
    push!(temp,(x+1,y+2)); push!(temp,(x+2,y+1))
    push!(temp,(x+2,y-2)); push!(temp,(x-2,y+2))
    push!(temp,(x+1,y-2)); push!(temp,(x+2,y-1))
    push!(temp,(x-1,y+2)); push!(temp,(x-2,y+1))
    push!(temp,(x-1,y-2)); push!(temp,(x-2,y+1))
    for i = 1:length(temp)
        cords = temp[i]
        if (cords[1] > 1 && cords[1] < 16) && (cords[2] > 1 && cords[2] < 16)
            push!(legal,cords)
        end
    end
    return legal 
end

function lion_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial cords
    source = set.active[piece]
    x = set.active[piece][1]; y = set.active[piece][2]
    # friendly and enemy units
    friendly = set.activeS; opps = enemy.activeS

    # check for promotion, becomes lion hawk
    if piece[1] == 'L'
        legal = lion_hawk_AI(set,enemy,legal,piece)
    else
        # generate all possible one-step moves then generate all possible
        # two-step moves and jump moves from the legal one-step moves.
        steps = lion_steps(x,y); legal_steps = []
        two_steps = Tuple{Tuple,Tuple}[]
        pop!(set.activeS,(x,y))
        for i = 1:length(steps)
            if haskey(set.activeS,steps[i]) != true
                push!(legal_steps,steps[i]) 
                xi = steps[i][1]; yi = steps[i][2]
                temp = lion_steps(xi,yi)
                for j = 1:length(temp) # generate all possible two-step moves
                    if haskey(set.activeS,temp[j]) != true
                        push!(two_steps,(steps[i],temp[j]))
                    end
                end
            end 
        end
        get!(set.activeS,(x,y),piece)
        # generate all possible jump moves
        jumps = lion_jumps(x,y); legal_jumps = []
        for i = 1:length(jumps)
            haskey(set.activeS,jumps[i]) != true && push!(legal_jumps,jumps[i])
        end
        # include all possible moves in legal
        legal = vcat(legal_steps,two_steps,legal_jumps)
    end
    return legal
end

# TENJIKU SHOGI NEW PIECES
#=****************************************************************************************************************=#
function >(op1::ASCIIString, op2::ASCIIString)
    rank = Dict("king"=>4,"prince"=>4,"greatgeneral"=>3,"vicegeneral"=>2,
                "bishopgeneral"=>1,"rookgeneral"=>1)
    haskey(rank,chop(op2)) != true && return true
    rank[chop(op1)] > rank[chop(op2)] ? (return true) : (return false)
end

# VICE GENERAL, promoted bishop general
function vice_general_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords = (x,y)
    # friendly units
    friendly = set.activeS
    legal = range_jump_AI(set,enemy,legal,cords)
    # AREA MOVE (can step in any direction up to 3 times)
    # generate all possible one-step moves 
    # then generate all possible two-step moves from the legal one-step moves
    # then generate all possible three-step moves from the legal two-step moves
    # must stop when it captures an enemy

    steps = lion_steps(x,y); legal_steps = []
    two_steps = []
    three_steps = []
    popped = pop!(set.activeS,cords)
    for i = 1:length(steps)
        if haskey(set.activeS,steps[i]) != true
            push!(legal_steps,steps[i])
        elseif haskey(enemy.activeS,steps[i]) || haskey(set.activeS,steps[i])
            continue
        end
        xi = steps[i][1]; yi = steps[i][2]
        temp = lion_steps(xi,yi)
        for j = 1:length(temp) # generate all possible two-step moves
            if haskey(set.activeS,temp[j]) != true
                push!(two_steps,(steps[i],temp[j]))
            elseif haskey(enemy.activeS,temp[j]) || haskey(set.activeS,temp[j])
                continue
            end
            xi2 = temp[j][1]; yi2 = temp[j][2]
            temp2 = lion_steps(xi2,yi2)
            for k = 1:length(temp2)
                if haskey(set.activeS,temp2[k]) != true
                    push!(three_steps,(steps[i],temp[j],temp2[k]))
                end
            end
        end
    end
    get!(set.activeS,cords,popped)
    # include all possible moves in legal
    legal = vcat(legal_steps,two_steps,three_steps)
    return legal
end

# BISHOP GENERAL, promotes to vice general
function bishop_general_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords = (x,y)
    # friendly units
    friendly = set.activeS

    # check for promotion
    if piece[1] == 'B'
        legal = vice_general_AI(set,enemy,legal,piece)
    else
        legal = range_jump_AI(set,enemy,legal,cords)
    end
    return legal
end

# GREAT GENERAL, promoted rook general
function great_general_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords = (x,y)
    # friendly units
    friendly = set.activeS
    legal = range_jump_AI(set,enemy,legal,cords)
    legal = cross_jump_AI(set,enemy,legal,cords)
    return legal
end

# ROOK GENERAL, promotes to great general
function rook_general_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords = (x,y)
    # friendly units
    friendly = set.activeS

    # check for promotion, becomes great general
    if piece[1] == 'R'
        legal = great_general_AI(set,enemy,legal,piece)
    else
       legal = cross_jump_AI(set,enemy,legal,cords)
   end
    return legal
end

# FIRE DEMON, promoted water buffalo
function fire_demon_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords = (x,y)
    # friendly units
    friendly = set.activeS
    # println(piece)
    # println(cords)
    # RANGE MOVES
    # ------------------------------------------
    legal = range_AI(set,enemy,legal,cords)
    legal = cross_AI(set,enemy,legal,cords)
    # ------------------------------------------
    # AREA MOVE (can step in any direction up to 3 times)
    # generate all possible one-step moves 
    # then generate all possible two-step moves from the legal one-step moves
    # then generate all possible three-step moves from the legal two-step moves
    # must stop when it captures an enemy
    # ------------------------------------------
    steps = lion_steps(x,y); legal_steps = []
    two_steps = []
    three_steps = []
    popped = pop!(set.activeS,cords)
    for i = 1:length(steps)
        if haskey(set.activeS,steps[i]) != true
            push!(legal_steps,steps[i])
        elseif haskey(enemy.activeS,steps[i]) || haskey(set.activeS,steps[i])
             continue
        end
        xi = steps[i][1]; yi = steps[i][2]
        temp = lion_steps(xi,yi)
        for j = 1:length(temp) # generate all possible two-step moves
            if haskey(set.activeS,temp[j]) != true
                push!(two_steps,(steps[i],temp[j]))
            elseif haskey(enemy.activeS,temp[j]) || haskey(set.activeS,temp[j])
                continue
            end
            xi2 = temp[j][1]; yi2 = temp[j][2]
            temp2 = lion_steps(xi2,yi2)
            for k = 1:length(temp2)
                if haskey(set.activeS,temp2[k]) != true
                    push!(three_steps,(steps[i],temp[j],temp2[k]))
                end
            end      
        end
       
    end
    get!(set.activeS,cords,popped)
    # include all possible moves in legal
    legal = vcat(legal_steps,two_steps,three_steps)
    # ------------------------------------------
    return legal
end

# HEAVENLY TETRARCH, promoted chariot soldier
function heavenly_tetrarch_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords = (x,y)
    # friendly units
    friendly = set.activeS

    # RANGE MOVES
    # ------------------------------------------
    legal = front_vertical_AI(set,enemy,legal,(x,y+1))
    legal = rear_vertical_AI(set,enemy,legal,(x,y-1))
    legal = top_right_diagonal_AI(set,enemy,legal,(x+1,y+1))
    legal = bottom_right_diagonal_AI(set,enemy,legal,(x+1,y-1))
    legal = bottom_left_diagonal_AI(set,enemy,legal,(x-1,y-1))
    legal = top_left_diagonal_AI(set,enemy,legal,(x-1,y+1))
    # ------------------------------------------------------------------------------------
    # IGUI MOVES, can capture a piece on any adjacent square without moving
    # ------------------------------------------
    # step up, and return to source (capture enemy only)
    if y < 15 && haskey(friendly,(x,y+1)) != true && haskey(enemy.activeS,(x,y+1)) == true
        push!(legal,((x,y+1),(x,y)))
    end
    # step right, and return to source (capture enemy only)
    if x < 15 && haskey(friendly,(x+1,y)) != true && haskey(enemy.activeS,(x+1,y)) == true
        push!(legal,((x+1,y),(x,y)))
    end
    # step left, and return to source (capture enemy only)
    if x > 2 && haskey(friendly,(x-1,y)) != true && haskey(enemy.activeS,(x-1,y)) == true
        push!(legal,((x-1,y),(x,y)))
    end
    # step down, and return to source (capture enemy only)
    if y > 2 && haskey(friendly,(x,y-1)) != true && haskey(enemy.activeS,(x,y-1)) == true
        push!(legal,((x,y-1),(x,y)))
    end
    # ------------------------------------------------------------------------------------

    # LIMITED RANGE
    # can move two or three squares orthogonally sideways
    # skips any intervening piece on the first square, it cannot jump a piece on the second square
    # if it captures on the second square, it must stop there
    # ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    # jump left (can only jump first square)
    if ( x > 2 && (haskey(friendly,(x-1,y)) == true || haskey(enemy.activeS,(x-1,y)) == true) && haskey(friendly,(x-2,y)) != true )
        push!(legal,(x-2,y))
    end
    # jump left, step left (can only jump first square)
    if ( x > 3 && (haskey(friendly,(x-1,y)) == true || haskey(enemy.activeS,(x-1,y)) == true) && haskey(friendly,(x-2,y)) != true && haskey(enemy.activeS,(x-2,y)) != true && haskey(friendly,(x-3,y)) != true )
        push!(legal,((x-2,y),(x-3,y)))
    end
    # jump right (can only jump first square)
    if ( x < 15 && (haskey(friendly,(x+1,y)) == true || haskey(enemy.activeS,(x+1,y)) == true) && haskey(friendly,(x+2,y)) != true )
        push!(legal,(x+2,y))
    end
    # jump right, step right (can only jump first square)
    if ( x < 15 && (haskey(friendly,(x+1,y)) == true || haskey(enemy.activeS,(x+1,y)) == true) && haskey(friendly,(x+2,y)) != true && haskey(enemy.activeS,(x+2,y)) != true && haskey(friendly,(x-3,y)) != true )
        push!(legal,(x+2,y),(x+3,y))
    end
    # step left twice
    if x > 2 && haskey(friendly,(x-1,y)) != true && haskey(enemy.activeS,(x-1,y)) != true && haskey(friendly,(x-2,y)) != true
        push!(legal,((x-1,y),(x-2,y)))
    end
    # step left three times
    if x > 3 && haskey(friendly,(x-1,y)) != true && haskey(enemy.activeS,(x-1,y)) != true haskey(friendly,(x-2,y)) != true && haskey(enemy.activeS,(x-2,y)) != true && haskey(friendly,(x-3,y)) != true
        push!(legal,((x-1,y),(x-2,y),(x-3,y)))
    end
    # step right twice
    if x < 15 && haskey(friendly,(x+1,y)) != true && haskey(enemy.activeS,(x+1,y)) != true && haskey(friendly,(x+2,y)) != true
        push!(legal,((x+1,y),(x+2,y)))
    end
    # step right three times
    if x < 14 && haskey(friendly,(x+1,y)) != true && haskey(enemy.activeS,(x+1,y)) != true && haskey(friendly,(x+2,y)) != true && haskey(enemy.activeS,(x+2,y)) != true && haskey(friendly,(x-3,y)) != true
        push!(legal,((x+1,y),(x+2,y),(x+3,y)))
    end
    # ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    return legal
end

# IRON GENERAL, promotes to vertical soldier
function iron_general_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    # friendly units
    friendly = set.activeS

    # check for promotion, becomes vertical soldier
    if piece[1] == 'I'
        legal = vertical_soldier_AI(set,enemy,legal,piece)
    else
        if set.color == "red"
            # step up
            if y != 16
                haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
            end
            if x != 16 && y != 16 # step top right
                haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
            end
            if x != 1 && y != 16 # step top left
                haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
            end
        else
            # step down
            if y != 1
                haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
            end
            if x != 16 && y != 1 # step bottom right
                haskey(friendly,(x+1,y-2)) == 0 && push!(legal,(x+1,y-2))
            end
            if x != 1 && y != 1 # step bottom left
                haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
            end
        end
    end
    return legal
end

# CHARIOT SOLDIER, promotes to heavenly tetrarch
function chariot_soldier_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS

    # check for promotion, becomes heavenly tetrarch
    if piece[1] == 'C'
        legal = heavenly_tetrarch_AI(set,enemy,legal,piece)
    # not promoted
    else
        # RANGE MOVES
        # ------------------------------------------
        legal = vertical_AI(set,enemy,legal,cords)
        legal = range_AI(set,enemy,legal,cords)
        # ------------------------------------------
        # LIMITED RANGE, step moves
        # ------------------------------------------
        # step right once
        cords = (x+1,y) # step right    
        if x != 16 && haskey(friendly,cords) != true
            push!(legal,cords)
        end
        # step right twice
        if x < 15 && haskey(friendly,(x+1,y)) != true && haskey(friendly,(x+2,y)) != true
            push!(legal,((x+1,y),(x+2,y)))
        end
        # step left once
        cords = (x-1,y) # step left
        if x != 0 && haskey(friendly,cords) != true
            push!(legal,cords)
        end
        # step left twice
        if x > 2 && haskey(friendly,(x-1,y)) != true && haskey(friendly,(x-2,y)) != true
            push!(legal,((x-1,y),(x-2,y)))
        end
        # ------------------------------------------
    end
    return legal
end

# FREE EAGLE, promoted queen
function free_eagle_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS

    # RANGE MOVES
    # ------------------------------------------
    legal = cross_AI(set,enemy,legal,cords)
    legal = range_AI(set,enemy,legal,cords)
    # ------------------------------------------

    # DOUBLE MOVES (cat-sword)
    # ------------------------------------------
    # generate all possible one-step moves then generate all possible
    # two-step moves from the legal one-step moves.
    steps = lion_steps(x,y); legal_steps = []
    two_steps = Tuple{Tuple,Tuple}[]
    for i = 1:length(steps) 
        pop!(set.activeS,(x,y))
        if haskey(set.activeS,steps[i]) != true
            if ( steps[i] != (x,y+1) && steps[i] != (x,y-1) && steps[i] != (x-1,y) && steps[i] != (x+1,y) )
                push!(legal_steps,steps[i])
                xi = steps[i][1]; yi = steps[i][2]
                temp = lion_steps(xi,yi)
                for j = 1:length(temp) # generate all possible two-step moves
                    if haskey(set.activeS,temp[j]) != true
                        if ( temp[j] != (x,y+2) && temp[j] != (x,y-2) && temp[j] != (x-2,y) && temp[j] != (x+2,y) )
                            push!(two_steps,(steps[i],temp[j]))
                        end
                    end
                end
            end
        end
        get!(set.activeS,(x,y),piece)
    end
    # include all possible moves in legal
    legal = vcat(legal_steps,two_steps)
    # ------------------------------------------
    return legal
end

# LION HAWK, promoted lion
function lion_hawk_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS

    # RANGE MOVES
    # ------------------------------------------
    legal = range_AI(set,enemy,legal,cords)
    # ------------------------------------------
    # LION MOVES
    # ------------------------------------------
    # generate all possible one-step moves then generate all possible
    # two-step moves and jump moves from the legal one-step moves.
    steps = lion_steps(x,y); legal_steps = []
    two_steps = Tuple{Tuple,Tuple}[]
    for i = 1:length(steps) 
        pop!(set.activeS,(x,y))
        if haskey(set.activeS,steps[i]) != true
            push!(legal_steps,steps[i]) 
            xi = steps[i][1]; yi = steps[i][2]
            temp = lion_steps(xi,yi)
            for j = 1:length(temp) # generate all possible two-step moves
                if haskey(set.activeS,temp[j]) != true
                    push!(two_steps,(steps[i],temp[j]))
                end
            end
        end
        get!(set.activeS,(x,y),piece)
    end
    # generate all possible jump moves
    jumps = lion_jumps(x,y); legal_jumps = []
    for i = 1:length(jumps)
        haskey(set.activeS,jumps[i]) != true && push!(legal_jumps,jumps[i])
    end
    # include all possible moves in legal
    legal = vcat(legal_steps,two_steps,legal_jumps)
    # ------------------------------------------
    return legal
end

# SIDE SOLDIER, promotes to water buffalo
function side_soldier_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS

    # check for promotion, becomes water buffalo
    if piece[1] == 'S'
        legal = water_buffalo_AI(set,enemy,legal,piece)
    else
        # RANGE MOVES
        # ------------------------------------------
       legal = horizontal_AI(set,enemy,legal,cords)
        # ------------------------------------------
        # LIMITED RANGE
        # ------------------------------------------
        if set.color == "red"
            # step up twice
            if y < 15 && haskey(friendly,(x,y+1)) != true && haskey(friendly,(x,y+2)) != true
                push!(legal,((x,y+1),(x,y+2)))
            end
        else
            # step down twice
            if y > 2 && haskey(friendly,(x,y-1)) != true && haskey(friendly,(x,y-2)) != true
                push!(legal,((x,y-1),(x,y-2)))
            end
        end
        # ------------------------------------------
        # STEP
        # ------------------------------------------
        # step up
        if y != 16
            haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end
        # step down
        if y != 1
            haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        end
        # ------------------------------------------
    end
    return legal
end

# VERTICAL SOLDIER, promotes to chariot soldier
function vertical_soldier_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS

    # check for promotion, becomes chariot soldier
    if piece[1] == 'V'
        legal = chariot_soldier_AI(set,enemy,legal,piece)
    else
        # RANGE MOVES
        # ------------------------------------------
        set.color == "red" ?
            legal = front_vertical_AI(set,enemy,legal,cords) :
            legal = rear_vertical_AI(set,enemy,legal,cords)
        # ------------------------------------------

        # LIMITED RANGE
        # ------------------------------------------
        # step right once
        cords = (x+1,y) # step right    
        if x != 16 && haskey(friendly,cords) != true
            push!(legal,cords)
        end
        # step right twice
        if x < 15 && haskey(friendly,(x+1,y)) != true && haskey(friendly,(x+2,y)) != true
            push!(legal,((x+1,y),(x+2,y)))
        end
        # step left once
        cords = (x-1,y) # step left
        if x != 0 && haskey(friendly,cords) != true
            push!(legal,cords)
        end
        # step left twice
        if x > 2 && haskey(friendly,(x-1,y)) != true && haskey(friendly,(x-2,y)) != true
            push!(legal,((x-1,y),(x-2,y)))
        end
        # ------------------------------------------

        # STEP
        # ------------------------------------------
        if set.color == "red"
            # step down
            if y != 1
                haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
            end
        else
            # step up
            if y != 16
                haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
            end
        end
        # ------------------------------------------
    end
    return legal
end

# DOG, promotes to multi general
function dog_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords = Tuple{Int64,Int64} # stores possible coordinates
    # friendly units
    friendly = set.activeS
    # check for promotion, becomes multi general
    if piece[1] == 'D'
        legal = multi_general_AI(set,enemy,legal,piece)
    else
        if set.color == "red"
            # step up
            if y != 16
                haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
            end
            # step bottom left and bottom right
            if y != 1
                haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
                haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
            end
        else
            # step down
            if y != 1
                haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
            end
            # step top left and top right
            if y != 16
                haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
                haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
            end 
        end
    end
    return legal
end

# MULTI GENERAL, promoted dog
function multi_general_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS
    if set.color == "red"
        legal = front_vertical_AI(set,enemy,legal,cords)
        legal = bottom_right_diagonal_AI(set,enemy,legal,cords)
        legal = bottom_left_diagonal_AI(set,enemy,legal,cords)
    else
        legal = rear_vertical_AI(set,enemy,legal,cords)
        legal = top_right_diagonal_AI(set,enemy,legal,cords)
        legal = top_left_diagonal_AI(set,enemy,legal,cords)
    end
    return legal
end

# WATER BUFFALO, promotes to fire demon
function water_buffalo_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} = (x,y) # stores possible coordinates
    # friendly units
    friendly = set.activeS
    # check for promotion, becomes fire demon
    if piece[1] == 'W'
        legal = fire_demon_AI(set,enemy,legal,piece)
    else
        # RANGE MOVES
        # ------------------------------------------
        legal = range_AI(set,enemy,legal,cords)
        legal = horizontal_AI(set,enemy,legal,cords)
        # ------------------------------------------
        # LIMITED RANGE
        # ------------------------------------------
        # step up twice
        if y < 15 && haskey(friendly,(x,y+1)) != true && haskey(friendly,(x,y+2)) != true
            push!(legal,((x,y+1),(x,y+2)))
        end
        # step down twice
        if y > 2 && haskey(friendly,(x,y-1)) != true && haskey(friendly,(x,y-2)) != true
            push!(legal,((x,y-1),(x,y-2)))
        end
        # ------------------------------------------
    end
    return legal
end

# generates all possible moves, stores into entire legal array
function generate_moves(set::Pieces, enemy::Pieces, piece::ASCIIString)
    legal = []
    if contains(piece, "king")
        legal = king_AI(set,legal,piece)
    elseif contains(piece, "queen") || contains(piece, "queen")
        legal = queen_AI(set,enemy,legal,piece)
    elseif ( contains(piece, "lion") || contains(piece, "Lion") ) && !contains(piece,"hawk")
        legal = lion_AI(set,enemy,legal,piece)
    elseif contains(piece, "dragonking") || contains(piece, "Dragonking")
        legal = dragon_king_AI(set,enemy,legal,piece)
    elseif contains(piece, "dragonhorse") || contains(piece, "Dragonhorse")
        legal = dragon_horse_AI(set,enemy,legal,piece)
    elseif contains(piece, "rook1") || contains(piece, "Rook1") || contains(piece, "rook2") || contains(piece, "Rook2")
        legal = rook_AI(set,enemy,legal,piece)
    elseif contains(piece, "bishop1") || contains(piece, "Bishop1") || contains(piece, "bishop2") || contains(piece, "Bishop2")
        legal = bishop_AI(set,enemy,legal,piece)
    elseif contains(piece, "ferocious") || contains(piece, "Ferocious")
        legal = ferocious_leopard_AI(set,enemy,legal,piece)
    elseif contains(piece, "blind") || contains(piece, "Blind")
        legal = blind_tiger_AI(set,enemy,legal,piece)
    elseif contains(piece, "drunk") || contains(piece, "Drunk")
        legal = drunk_elephant_AI(set,enemy,legal,piece)
    elseif contains(piece, "sidemover") || contains(piece, "Sidemover")
        legal = side_mover_AI(set,enemy,legal,piece)
    elseif contains(piece, "verticalmover") || contains(piece, "Verticalmover")
        legal = vertical_mover_AI(set,enemy,legal,piece)
    elseif contains(piece, "reverse") || contains(piece, "Reverse")
        legal = reverse_chariot_AI(set,enemy,legal,piece)
    elseif contains(piece, "kirin") || contains(piece, "Kirin")
        legal = kirin_AI(set,enemy,legal,piece)
    elseif contains(piece, "phoenix") || contains(piece, "Phoenix")
        legal = phoenix_AI(set,enemy,legal,piece)
    elseif contains(piece, "gold") || contains(piece, "Gold")
        legal = gold_general_AI(set,enemy,legal,piece)
    elseif contains(piece, "silver") || contains(piece, "Silver")
        legal = silver_general_AI(set,enemy,legal,piece)
    elseif contains(piece, "copper") || contains(piece, "Copper")
        legal = copper_general_AI(set,enemy,legal,piece)
    elseif contains(piece, "pawn") || contains(piece, "Pawn")
        legal = pawn_AI(set,enemy,legal,piece)
    elseif contains(piece, "lance") || contains(piece, "Lance")
        legal = lancer_AI(set,enemy,legal,piece)
    elseif contains(piece, "vicegeneral")
        legal = vice_general_AI(set,enemy,legal,piece)
    elseif contains(piece, "bishopgeneral") || contains(piece, "Bishopgeneral")
        legal = bishop_general_AI(set,enemy,legal,piece)
    elseif contains(piece, "greatgeneral") || contains(piece, "Greatgeneral")
        legal = great_general_AI(set,enemy,legal,piece)
    elseif contains(piece, "rookgeneral") || contains(piece, "Rookgeneral")
        legal = rook_general_AI(set,enemy,legal,piece)
    elseif contains(piece, "firedemon")
        legal = fire_demon_AI(set,enemy,legal,piece)
    elseif contains(piece, "irongeneral") || contains(piece, "Irongeneral")
        legal = iron_general_AI(set,enemy,legal,piece)
    elseif contains(piece, "chariotsoldier") || contains(piece, "Chariotsoldier")
        legal = chariot_soldier_AI(set,enemy,legal,piece)
    elseif contains(piece, "freeagle")
        legal = free_eagle_AI(set,enemy,legal,piece)
    elseif contains(piece, "lionhawk")
        legal = lion_hawk_AI(set,enemy,legal,piece)
    elseif contains(piece, "sidesoldier") || contains(piece, "Sidesoldier")
        legal = side_soldier_AI(set,enemy,legal,piece)
    elseif contains(piece, "verticalsoldier") || contains(piece, "Verticalsoldier")
        legal = vertical_soldier_AI(set,enemy,legal,piece)
    elseif contains(piece, "dog") || contains(piece, "Dog")
        legal = dog_AI(set,enemy,legal,piece)
    elseif contains(piece, "hornedfalcon")
        legal = horned_falcon_AI(set,enemy,legal,piece)
    elseif contains(piece, "soaringeagle")
        legal = soaring_eagle_AI(set,enemy,legal,piece)
    elseif contains(piece, "waterbuffalo") || contains(piece, "Waterbuffalo")
        legal = water_buffalo_AI(set,enemy,legal,piece)
    end
    return legal
end

# AI ALGORITHM IMPLEMENTATIONS
#--------------------------------------------------------------------------------

# returns the score
function score(active::Pieces, inactive::Pieces)
    # black pieces left on board +1
    # red pieces left on board -1
    if active.color == "black"
        pos = length(active.active)
        neg = -length(inactive.active)
        # return the score
        return pos+neg
    else    # active.color == "red"
        pos = length(inactive.active)
        neg = -length(active.active)
        # return the score
        return pos+neg
    end
end

# Minimax w/ alpha-beta pruning algorithm for AI
function minimax_AB(active::Pieces, inactive::Pieces, alpha, beta, depth, limit)
    # maximizer
    if active.color == "black"
        return max_AB(active,inactive,alpha,beta,depth,limit)
    # minimizer
    else 
        return min_AB(active,inactive,alpha,beta,depth,limit)
    end
end

function max_AB(active::Pieces, inactive::Pieces, alpha, beta, depth, limit)
    best_move = (("NULL",(0,0)),score(active,inactive))
    # if depth is reached, recurse back
    if depth == limit 
        return best_move
    else
        A = collect(keys(active.active)) 
        # generate all possible moves for each piece on black
        for j = 1:length(A) 
            piece = ASCIIString(A[j]);
            legal = generate_moves(active,inactive,piece) 
            # analyse each possible move
            for i = 1:length(legal)
                numMoves = 0; deadList = []; deadCords = []
                old_alpha::Float64 = alpha
                old_cords = active.active[piece] # save old coordinates
                # simulate move
                for item in legal[i]
                    length(item) == 2 && (numMoves += 1)
                end
                if numMoves == 3
                    for k = 1:3
                        dead = check_kill(inactive,legal[i][k])
                        push!(deadList,dead); push!(deadCords,legal[i][k])
                    end
                    update_piece(active,piece,legal[i][3])
                elseif numMoves == 2
                    for k = 1:2
                        dead = check_kill(inactive,legal[i][k])
                        push!(deadList,dead); push!(deadCords,legal[i][k])
                    end
                    update_piece(active,piece,legal[i][2])
                else
                    update_piece(active,piece,legal[i])
                    dead = check_kill(inactive,legal[i])
                    push!(deadList,dead)
                    push!(deadCords,legal[i])
                end 
                # recursive call to minimizer
                AB = min_AB(inactive,active,alpha,beta,depth+1,limit)
                alpha = max(alpha,AB[2])
                # update best_move
                if old_alpha < alpha
                    if numMoves == 0
                        best_move = ((piece,legal[i]),alpha)
                    elseif numMoves == 2
                        best_move_move = ((piece,legal[i][1],legal[i][2]),alpha)
                    else
                        best_move_move = ((piece,legal[i][1],legal[i][2],legal[i][3]),alpha)
                    end       
                end  
                # reverse simulation
                update_piece(active,piece,old_cords)
                for k = 1:length(deadList)
                    if deadList[k] != "NULL"
                        raise_dead(inactive,deadList[k],deadCords[k])
                    end
                end
                # check for alpha-beta pruning
                if alpha >= beta 
                    return best_move
                end     
            end
        end
    end
    return best_move
end

function min_AB(active::Pieces, inactive::Pieces, alpha, beta, depth, limit)
    best_move = (("NULL",(0,0)),score(active,inactive))
    # if depth is reached, recurse back
    if depth == limit 
        return best_move
    else
        # generate all possible moves for each piece on black
        A = collect(keys(active.active)) 
        for j = 1:length(A) 
            piece = ASCIIString(A[j]); legal = Tuple{Int,Int}[] 
            legal = generate_moves(active,inactive,piece) 
            # analyse each possible move
            for i = 1:length(legal)
                numMoves = 0; deadList = []; deadCords = []
                old_beta::Float64 = beta
                old_cords = active.active[piece] # save old coordinates
                # simulate move
                for item in legal[i]
                    length(item) == 2 && (numMoves += 1)
                end
                if numMoves == 3
                    for k = 1:3
                        dead = check_kill(inactive,legal[i][k])
                        push!(deadList,dead); push!(deadCords,legal[i][k])
                    end
                    update_piece(active,piece,legal[i][3])
                elseif numMoves == 2
                    for k = 1:2
                        dead = check_kill(inactive,legal[i][k])
                        push!(deadList,dead); push!(deadCords,legal[i][k])
                    end
                    update_piece(active,piece,legal[i][2])
                else
                    update_piece(active,piece,legal[i])
                    dead = check_kill(inactive,legal[i])
                    push!(deadList,dead)
                    push!(deadCords,legal[i])
                end 
                # recursive call to minimizer
                AB = max_AB(inactive,active,alpha,beta,depth+1,limit)
                beta = min(beta,AB[2])
                # update best_move
                if old_beta > beta
                    if numMoves == 0
                        best_move = ((piece,legal[i]),beta)
                    elseif numMoves == 2
                        best_move_move = ((piece,legal[i][1],legal[i][2]),beta)
                    else
                        best_move_move = ((piece,legal[i][1],legal[i][2],legal[i][3]),beta)
                    end       
                end  
                # reverse simulation
                update_piece(active,piece,old_cords)
                for k = 1:length(deadList)
                     if deadList[k] != "NULL"
                        raise_dead(inactive,deadList[k],deadCords[k])
                    end
                end

            end
        end
    end
    return best_move
end

type MonteCarlo
    black::Pieces
    red::Pieces
    C::Float64 # exploration parameter
    total::Int64
    history::Dict # records moves and their respective scores
    path::Array # used to update tree after playout 
    MonteCarlo(black::Pieces, red::Pieces) = new(black,red,sqrt(2),0,Dict(),Array{Any}(0))
end

# returns the highest value play if statistics are available, otherwise, randomly
# selects a legal move
function getPlay(AI::MonteCarlo, set::Pieces, enemy::Pieces)
    plays = []; # store states of board
    flag = 1 # 1 if there are statistics available for each play, 0 otherwise
    A = collect(keys(set.active))
    for i = 1:length(A)
        legal = generate_moves(set,enemy,ASCIIString(A[i]))
        for j = 1:length(legal)
            push!(plays,((set.color,A[i]),legal[j]))
        end
        deleteat!(legal,1:length(legal))
    end
    for i = 1:length(plays)
        if haskey(AI.history,plays[i]) == false 
            flag = 0; break
        end
    end
    if flag == 0 # randomly choose move
        play = rand(plays)
        return play
    else
        score = 0; best_play = ()
        for i = 1:length(plays)
            wins = AI.history[plays[i]][1]
            total = AI.history[plays[i]][2]   
            new_score = (wins/total) + AI.C*sqrt(log(AI.total)/total)
            if new_score > score 
                score = new_score; best_play = plays[i]
            end
        end
        return best_play
    end
end

# runs simulation of MCTS - populates the tree
function simulate(AI::MonteCarlo)
    black = deepcopy(AI.black); red = deepcopy(AI.red)
    while haskey(red.active,"king_r") == true && haskey(black.active,"king_b") == true
        numMoves = 0
        if AI.total % 2 == 0 
            play = getPlay(AI,black,red) 
            active = black; inactive = red
        else
            play = getPlay(AI,red,black)
            active = red; inactive = black
        end
        piece = play[1][2]; move = play[2]
        for i in play[2]
            length(i) == 2 && (numMoves += 1)
        end
        if numMoves == 3
            for i = 1:3
                check_kill(inactive,move[i]); piece = promote_AI(active,piece,move[i])
            end
            # println(piece)
            # println(active.active[piece])
            # println(move)
            # println("numMoves = $numMoves")
            update_piece(active,piece,move[3])
        elseif numMoves == 2
            for i = 1:2
                check_kill(inactive,move[i]); piece = promote_AI(active,piece,move[i])
            end
            # println(piece)
            # println(active.active[piece])
            # println(move)
            # println("numMoves = $numMoves")
            update_piece(active,piece,move[2])
        else
            # println(piece)
            # println(active.active[piece])
            # println(move)
            # println("numMoves = $numMoves")
            # update_piece(active,piece,move)
            check_kill(inactive,move); piece = promote_AI(active,piece,move)
            update_piece(active,piece,move)
        end 
        if haskey(AI.history,play) == true # node exists
            wins = AI.history[play][1]; total = AI.history[play][2]
            AI.history[play] = (wins,total+1)
        else # new node
            get!(AI.history,play,(0,1))
        end
        push!(AI.path,play); AI.total += 1
    end
    #haskey(red.active,"king_r") == true ? winner = "red" : winner = "black"
    #println(winner)
    backPropogate(AI) # update with play out
end

# updates winning nodes of MCTS - call after a play out
function backPropogate(AI::MonteCarlo)
    for i = length(AI.path):-2:1 # propagate back up the tree
        node = AI.path[i]
        #node[1][1] == "red" && println("yes")
        old = AI.history[node]
        AI.history[node] = (old[1]+1,old[2])
    end
    deleteat!(AI.path,1:length(AI.path)) # clear path for next simulation
end

# used in competition
function black_MCTS(AI::MonteCarlo)
    return getPlay(AI,AI.black,AI.red) 
end

function red_MCTS(AI::MonteCarlo)
    return getPlay(AI,AI.red,AI.black) 
end
    
# testing

# red = Pieces("red")
# fill_red(red)
# black = Pieces("black")
# fill_black(black)

# julia = MonteCarlo(black,red) # instantiate MCTS

#julia.C = 2.0 # toggle expoloration factor

# read in prior history
# file = readdlm("MCTS_tenjiku.txt"); len = size(file)[1]
# for i = 1:len
#     get!(julia.history,file[i],file[i,2])
# end

# AI_move_piece(black,red,"greatgeneral1",(9,13))
# AI_move_piece(black,red,"bishopgeneral1",(9,12))


# AI_move_piece(red,black,"firedemon1",(8,8))
# #println(red.activeS[(10,2)])
# legal = generate_moves(black,red,"bishopgeneral1")
# println(legal)

### TEST SOARING EAGLE

# for i = 1:1000 # run simulations to fill MCTS
#     simulate(julia)
# end

# # add in new history
# writedlm("MCTS_tenjiku.txt",julia.history)





