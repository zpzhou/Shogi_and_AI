# include("general_functions.jl")
# include("chu_shogi.jl")

# UTILITY FUNCTIONS
#--------------------------------------------------------------------------------
function range_AI(set::Pieces, enemy::Pieces, legal, source)
    friends = set.activeS; enemy = enemy.activeS
    x = source[1]; y = source[2]
    i = 1; cords = (x,y)
    while (cords[1] > 1 && cords[1] < 9) && (cords[2] > 1 && cords[2] < 9)
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
    while (cords[1] > 1 && cords[1] < 9) && (cords[2] > 1 && cords[2] < 9)
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
    while (cords[1] > 1 && cords[1] < 9) && (cords[2] > 1 && cords[2] < 9)
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
    while (cords[1] > 1 && cords[1] < 9) && (cords[2] > 1 && cords[2] < 9)
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
    while (cords[1] > 1 && cords[1] < 9) && (cords[2] > 1 && cords[2] < 9)
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
            enemy[cords] == "king" && (jumpFlag = 0)
            enemy[cords] == "prince" && (jumpFlag = 0)
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
    while (cords[1] > 1 && cords[1] < 9) && (cords[2] > 1 && cords[2] < 9)
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
            enemy[cords] == "king" && (jumpFlag = 0)
            enemy[cords] == "prince" && (jumpFlag = 0)
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
    while (cords[1] > 1 && cords[1] < 9) && (cords[2] > 1 && cords[2] < 9)
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
            enemy[cords] == "king" && (jumpFlag = 0)
            enemy[cords] == "prince" && (jumpFlag = 0)
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
    while (cords[1] > 1 && cords[1] < 9) && (cords[2] > 1 && cords[2] < 9)
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
            enemy[cords] == "king" && (jumpFlag = 0)
            enemy[cords] == "prince" && (jumpFlag = 0)
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
    while (cords[1] > 1 && cords[1] < 9) && (cords[2] > 1 && cords[2] < 9)
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
    while (cords[1] > 1 && cords[1] < 9) && (cords[2] > 1 && cords[2] < 9)
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
    while (cords[1] > 1 && cords[1] < 9) && (cords[2] > 1 && cords[2] < 9)
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
    while (cords[1] > 1 && cords[1] < 9) && (cords[2] > 1 && cords[2] < 9)
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
    while (cords[1] > 1 && cords[1] < 9) && (cords[2] > 1 && cords[2] < 9)
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
    while (cords[1] > 1 && cords[1] < 9) && (cords[2] > 1 && cords[2] < 9)
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
    while (cords[1] > 1 && cords[1] < 9) && (cords[2] > 1 && cords[2] < 9)
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
    while (cords[1] > 1 && cords[1] < 9) && (cords[2] > 1 && cords[2] < 9)
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
    for i = y+1:9 # move upwards
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
    for i = x+1:9 # move rightwards
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
    for i = y+1:9 # move upwards
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
            enemy[cords] == "king" && (jumpFlag = 0)
            enemy[cords] == "prince" && (jumpFlag = 0)
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
            enemy[cords] == "king" && (jumpFlag = 0)
            enemy[cords] == "prince" && (jumpFlag = 0)
            enemy[cords] > temp_piece && (jumpFlag = 0)
            push!(legal,cords)
        elseif friend == 1 
            friends[cords] > temp_piece && (jumpFlag = 0)
        else
            push!(legal,cords)
        end
    end
    jumpFlag = 1
    for i = x+1:9 # move upwards
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
            enemy[cords] == "king" && (jumpFlag = 0)
            enemy[cords] == "prince" && (jumpFlag = 0)
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
            enemy[cords] == "king" && (jumpFlag = 0)
            enemy[cords] == "prince" && (jumpFlag = 0)
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
    for i = y+1:9 # move upwards
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
    for i = y+1:9 # move upwards
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
    for i = x+1:9 # move rightwards
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
        if y != 12
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


# go-between, o
function go_between_AI(set::Pieces, enemy::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    # friendly units
    friendly = set.activeS

    # check if promoted, becomes drunk elephant
    if piece[1] == 'O'
        legal = drunk_elephant_AI(set,enemy,legal,piece)
    # not promoted
    else
        # step up
        if y != 12
            haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end
        # step down
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
        (x != 12 && haskey(friendly,(x+1,y)) != true) && push!(legal,(x+1,y))
        (x != 1 && haskey(friendly,(x-1,y)) != true) && push!(legal,(x-1,y))
        return legal
    else
        legal = vertical_AI(set,enemy,legal,cords)
        cords = (x+1,y) # move right
        if x != 12 && haskey(friendly,cords) != true
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
    if y != 1 && x != 12
        haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
    end
    # step top left and top right
    if y != 12 && x != 12
        haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
    end
    if y != 12 && x != 1
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
        if x != 1 && y != 12 # step top left
            haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
        end
        if x > 2 && y < 11 # jump top left
            haskey(friendly,(x-2,y+2)) == 0 && push!(legal,(x-2,y+2))
        end
        if x > 2 && y < 11 # step top left, step top left
            (haskey(friendly,(x-1,y+1)) == 0 && haskey(friendly,(x-2,y+2)) == 0) && push!(legal,((x-1,y+1),(x-2,y+2)))
        end
        if x != 1 && y != 12 # step top left, step bottom right
            haskey(friendly,(x-1,y+1)) == 0 && push!(legal,((x-1,y+1),(x,y)))
        end

        if x != 12 && y != 12 # step top right
            haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
        end
        if x < 11 && y < 11 # jump top right
            haskey(friendly,(x+2,y+2)) == 0 && push!(legal,(x+2,y+2))
        end
        if x < 11 && y < 11 # step top right, step top right
            (haskey(friendly,(x+1,y+1)) == 0 && haskey(friendly,(x+2,y+2)) == 0) && push!(legal,((x+1,y+1),(x+2,y+2)))
        end
        if x != 12 && y != 12 # step top right, step bottom left
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

        if x != 12 && y > 2  # step bottom right
            haskey(friendly,(x+1,y-2)) == 0 && push!(legal,(x+1,y-2))
        end
        if x < 11 && y > 2 # jump bottom right
            haskey(friendly,(x+2,y-2)) == 0 && push!(legal,(x+2,y-2))
        end
        if x < 11 && y > 2 # step bottom right, step bottom right
            (haskey(friendly,(x+1,y-1)) && haskey(friendly,(x+2,y-2)) == 0) && push!(legal,((x+1,y-1),(x+2,y-2)))
        end
        if x != 12 && y != 1 # step bottom right, step top left
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
    if piece[1] == 'A' && set.color == "red" 
        legal = rear_range_AI(set,enemy,legal,cords)
    elseif piece[1] == 'A' && set.color == "black"    
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
        if y != 1 && x != 12
            haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
        end
        # step top left and top right
        if y != 12 && x != 12
            haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
        end
        if y != 12 && x != 1
             haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
         end
        # step up
        if y != 12
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
    elseif y != 1 && x != 1 && x != 12 # if piece is not on a boundary
        haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
        haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
    elseif y != 1 && x == 12 # if piece is on right side of board, and y != 1
        haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
        haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
    elseif y != 1 && x == 1 # if piece is on left side of board, and y != 1
        haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
        haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
    end
    if y != 12 && x != 1
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
    end
    if y != 12 && x != 12
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
    elseif y != 12 && x != 12 && x != 1 
        haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
    elseif y != 12 && x == 12 # if piece is on left side of board, and y != 12
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
        haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
    elseif y != 12 && x == 1 # if piece is on right side of board, and y != 12
        haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
        haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
    end
   if y != 12 && x != 1
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
    end
    if y != 12 && x != 12
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
    if y != 12 && haskey(friends,cords) != true
        push!(legal,cords) 
    end
    cords = (x,y-1) # step down
    if y != 1 && haskey(friends,cords) != true
        push!(legal,cords)
    end
    cords = (x+1,y) # step right    
    if x != 12 && haskey(friends,cords) != true
        push!(legal,cords)
    end
    cords = (x-1,y) # step left
    if x != 1 && haskey(friends,cords) != true
        push!(legal,cords)
    end
    if x != 12 && y != 12 # step top right
        haskey(friends,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
    end
    if x != 1 && y != 12 # step top left
        haskey(friends,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
    end
    if x != 12 && y != 1 # step bottom right
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
    if y != 1 && x != 12
        haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
    end
    # step top left and top right
    if y != 12 && x != 12
        haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
    end
    if y != 12 && x != 1
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
    end
    # step left
    if x != 1
        haskey(friendly,(x-1,y)) == 0 && push!(legal,(x-1,y))
    end
    # step right
    if x != 12
        haskey(friendly,(x+1,y)) == 0 && push!(legal,(x+1,y))
    end

    # check if promoted, becomes prince (same moveset as king)
    if piece == 'E'
        # step down
        if y != 1
            haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        end
        # step up
        if y != 12
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
            if y != 12
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
        if x != 12
            haskey(friendly,(x+1,y)) == 0 && push!(legal,(x+1,y))
        end
        # step down
        if y != 1
            haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        end
        # step up
        if y != 12
            haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end

        # original position at bottom left corner
        if x <= 2 && y <= 2
            haskey(friendly,(x+2,y+2)) == 0 && push!(legal,(x+2,y+2))   # top right
        # original position at bottom right corner
        elseif x >= 11 && y <= 2
            haskey(friendly,(x-2,y+2)) == 0 && push!(legal,(x-2,y+2))   # top left
        # original position at top left coner
        elseif x <= 2 && y >= 11
            haskey(friendly,(x+2,y-2)) == 0 && push!(legal,(x+2,y-2))   # bottom right
        # original position at top right corner
        elseif x >= 11 && y >= 11
            haskey(friendly,(x-2,y-2)) == 0 && push!(legal,(x-2,y-2))   # bottom left
        # original position at bottom (but not corners)
        elseif x >= 3 && x <= 10 && y <= 2 && y >= 1
            haskey(friendly,(x-2,y+2)) == 0 && push!(legal,(x-2,y+2))   # top left
            haskey(friendly,(x+2,y+2)) == 0 && push!(legal,(x+2,y+2))   # top right
        # original position at top (but not corners)
        elseif x >= 3 && x <= 10 && y <= 12 && y >= 11
            haskey(friendly,(x-2,y-2)) == 0 && push!(legal,(x-2,y-2))   # bottom left
            haskey(friendly,(x+2,y-2)) == 0 && push!(legal,(x+2,y-2))   # bottom right
        # original position at left side (but not corners)
        elseif x >= 1 && x <= 2 && y >= 3 && y <= 10
            haskey(friendly,(x+2,y+2)) == 0 && push!(legal,(x+2,y+2))   # top right
            haskey(friendly,(x+2,y-2)) == 0 && push!(legal,(x+2,y-2))   # bottom right
        # original position at right side (but not corners)
        elseif x >= 11 && x <= 12 && y >= 3 && y <= 10
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
    if piece[1] == 'O'
        legal = drunk_elephant_AI(set,enemy,legal,piece)
    # not promoted
    else
        # step up
        if y != 12
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
    if piece[1] == 'M' 
        legal = range_AI(set,enemy,legal,cords); return legal
    else # not promoted
    # move leftwards and rightwards allowable for promoted and unpromoted
        legal = horizontal_AI(set,enemy,legal,cords)
        if y != 12
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
    if piece[1] == 'H'
        legal = horned_falcon_AI(set,enemy,legal,piece); return legal
    end
    legal = range_AI(set,enemy,legal,cords)   
    (y != 12 && haskey(friendly,(x,y+1)) == 0) && push!(legal,(x,y+1))
    (y != 1 && haskey(friendly,(x,y-1)) == 0) && push!(legal,(x,y-1))
    (x != 1 && haskey(friendly,(x-1,y)) == 0) && push!(legal,(x-1,y))
    (x != 12 && haskey(friendly,(x+1,y)) == 0) && push!(legal,(x+1,y))
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
        if y != 12 # step up
            haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end
        if y < 11 # jump up
            haskey(friendly,(x,y+2)) == 0 && push!(legal,(x,y+2))
        end
        if y < 11 # step up, step up
            (haskey(friendly,(x,y+1)) == 0 && haskey(friendly,(x,y+2)) == 0) && push!(legal,((x,y+1),(x,y+2)))
        end
        if y <= 11 # step up, step down
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
    if y != 1 && x != 12
        haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
    end
    # step top left and top right
    if y != 12 && x != 12
        haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
    end
    if y != 12 && x != 1
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
    end
    # step left
    if x != 1
        haskey(friendly,(x-1,y)) == 0 && push!(legal,(x-1,y))
    end
    # step right
    if x != 12
        haskey(friendly,(x+1,y)) == 0 && push!(legal,(x+1,y))
    end
    # check if promoted, becomes flying stag
    if piece[1] == 'T'
        legal = vertical_AI(set,enemy,legal,cords)
    # not promoted
    else
        # add step down
        if set.color == "red"
            if y != 1
                haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
            end
        elseif set.color == "black" && y != 12
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
        if y != 12
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
            if y != 1 && x != 12
                haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
            end
        elseif set.color == "red"
            # step top left and top right
            if y != 12 && x != 12
                haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
            end
            if y != 12 && x != 1
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
        if x != 12
            haskey(friendly,(x+1,y)) == 0 && push!(legal,(x+1,y))
        end
        # step up
        if y != 12
            haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end
        # step down
        if y != 1
            haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        end
        # add diagonal steps depending on colour set
        if set.color == "red"
            # step top left and top right
            if y != 12 && x != 12
                haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
            end
            if y != 12 && x != 1
                haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
            end  
        elseif set.color == "black"
            # step bottom left and bottom right
            if y != 1 && x != 1
                haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
            end
            if y != 1 && x != 12
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
    if piece == 'N'
        # lion moveset
        legal = lion_AI(set,enemy,legal,piece)
    # not promoted
    else
        # step top left and top right
        if y != 12 && x != 12
            haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
        end
        if y != 12 && x != 1
            haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
        end
        # step bottom left and bottom right
        if y != 1 && x != 1
            haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
        end
        if y != 1 && x != 12
            haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
        end
        # if original position is at bottom left corner
        if x <= 2 && y <= 2
            haskey(friendly,(x,y+2)) == 0 && push!(legal,(x,y+2))   # jump top
            haskey(friendly,(x+2,y)) == 0 && push!(legal,(x+2,y))   # jump right
        # if original position is at bottom right corner
        elseif x >= 11 && y <= 2
            haskey(friendly,(x,y+2)) == 0 && push!(legal,(x,y+2))   # jump top
            haskey(friendly,(x-2,y)) == 0 && push!(legal,(x-2,y))   # jump left
        # if original position is at top left corner
        elseif x <= 2 && y >= 11
            haskey(friendly,(x+2,y)) == 0 && push!(legal,(x+2,y))   # jump right
            haskey(friendly,(x,y-2)) == 0 && push!(legal,(x,y-2))   # jump bottom
        # if original position is at top right corner
        elseif x >= 11 && y >= 11
            haskey(friendly,(x-2,y)) == 0 && push!(legal,(x-2,y))   # jump left
            haskey(friendly,(x,y-2)) == 0 && push!(legal,(x,y-2))   # jump bottom
        # if original position is at bottom (but not corners)
        elseif x >= 3 && x <= 10 && y <= 2 && y >= 1
            haskey(friendly,(x-2,y)) == 0 && push!(legal,(x-2,y))   # jump left
            haskey(friendly,(x+2,y)) == 0 && push!(legal,(x+2,y))   # jump right
            haskey(friendly,(x,y+2)) == 0 && push!(legal,(x,y+2))   # jump top
        # original position at top (but not corners)
        elseif x >= 3 && x <= 10 && y <= 12 && y >= 11
            haskey(friendly,(x-2,y)) == 0 && push!(legal,(x-2,y))   # jump left
            haskey(friendly,(x+2,y)) == 0 && push!(legal,(x+2,y))   # jump right
            haskey(friendly,(x,y-2)) == 0 && push!(legal,(x,y-2))   # jump bottom
        # original position at left side (but not corners)
        elseif x >= 1 && x <= 2 && y >= 3 && y <= 10
            haskey(friendly,(x,y+2)) == 0 && push!(legal,(x,y+2))   # jump top
            haskey(friendly,(x,y-2)) == 0 && push!(legal,(x,y-2))   # jump bottom
            haskey(friendly,(x+2,y)) == 0 && push!(legal,(x+2,y))   # jump right
        # original position at right side (but not corners)
        elseif x >= 11 && x <= 12 && y >= 3 && y <= 10
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
        if (cords[1] > 1 && cords[1] < 12) && (cords[2] > 1 && cords[2] < 12)
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
        if (cords[1] > 1 && cords[1] < 12) && (cords[2] > 1 && cords[2] < 12)
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
    # generate all possible one-step moves then generate all possible
    # two-step moves and jump moves from the legal one-step moves.
    steps = lion_steps(x,y); legal_steps = []
    two_steps = Tuple{Tuple,Tuple}[]
    get!(set.activeS,(x,y),piece); pop!(set.activeS,(x,y))
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
    return legal
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


# generates all possible moves, stores into entire legal array
function generate_moves(set::Pieces, enemy::Pieces, piece)
    legal = []; legal2 = []
    if contains(piece,"king")
        legal = king_AI(set,legal,piece)
    elseif contains(piece,"queen")
        legal = queen_AI(set,enemy,legal,piece)
    elseif contains(piece,"lion")
        legal = lion_AI(set,enemy,legal,piece)
    elseif contains(piece,"dragonking")
        legal = dragon_king_AI(set,enemy,legal,piece)
    elseif contains(piece,"dragonhorse")
        legal = dragon_horse_AI(set,enemy,legal,piece)
    elseif contains(piece,"rook") || contains(piece,"Rook")
        legal = rook_AI(set,enemy,legal,piece)
    elseif contains(piece,"bishop") || contains(piece,"Bishop")
        legal = bishop_AI(set,enemy,legal,piece)
    elseif contains(piece,"ferocious") || contains(piece,"Ferocious")
        legal = ferocious_leopard_AI(set,enemy,legal,piece)
    elseif contains(piece,"blind") || contains(piece,"Blind")
        legal = blind_tiger_AI(set,enemy,legal,piece)
    elseif contains(piece,"drunk") || contains(piece,"Drunk")
        legal = drunk_elephant_AI(set,enemy,legal,piece)
    elseif contains(piece,"side") || contains(piece,"Side")
        legal = side_mover_AI(set,enemy,legal,piece)
    elseif contains(piece,"vert") || contains(piece,"Vert")
        legal = vertical_mover_AI(set,enemy,legal,piece)
    elseif contains(piece,"rev") || contains(piece,"Rev")
        legal = reverse_chariot_AI(set,enemy,legal,piece)
    elseif contains(piece,"kirin") || contains(piece,"Kirin")
        legal = kirin_AI(set,enemy,legal,piece)
    elseif contains(piece,"pho") || contains(piece,"Pho")
        legal = phoenix_AI(set,enemy,legal,piece)
    elseif contains(piece,"gold") || contains(piece,"Gold")
        legal = gold_general_AI(set,enemy,legal,piece)
    elseif contains(piece,"silver") || contains(piece,"Silver")
        legal = silver_general_AI(set,enemy,legal,piece)
    elseif contains(piece,"copper") || contains(piece,"Copper")
        legal = copper_general_AI(set,enemy,legal,piece)
    elseif contains(piece,"pawn") || contains(piece,"Pawn")
        legal = pawn_AI(set,enemy,legal,piece)
    elseif contains(piece,"go") || contains(piece,"Go")
        legal = go_between_AI(set,enemy,legal,piece)
    elseif contains(piece,"lance") || contains(piece,"Lance")
        legal = lancer_AI(set,enemy,legal,piece)
    end
    for i = 1:length(legal) # lion killing rules
        cords = legal[i]
        if haskey(enemy.activeS,cords) == true  && contains(enemy.activeS[cords],"lion")
            if contains(piece,"lion")
                if length(cords[2]) > 1 
                    haskey(enemy.activeS,cords[1]) == true ? 
                        dead = enemy.activeS[cords] : 
                        dead = "NULL"
                    flag = lion_kill(set,enemy,piece,cords,dead)
                else
                    flag = lion_kill(set,enemy,piece,cords,"NULL")
                end
                flag == 1 && push!(legal2,cords)
            elseif length(cords[2]) > 1
                if lion_kill(set,enemy,piece,cords[1],"NULL") == 1 && 
                    lion_kill(set,enemy,piece,cords[2],"NULL") == 1 && 
                    push!(legal2,cords)
                end
            else
                lion_kill(set,enemy,piece,cords,"NULL") == 1 && push!(legal2,cords)
            end
        else push!(legal2,cords)
        end
    end
    return legal2
end

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
                if numMoves == 2
                    for k = 1:2
                        dead = check_kill(inactive,legal[i][k])
                        push!(deadList,dead)
                        push!(deadCords,legal[i][k])
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
                    else
                        best_move_move = ((piece,legal[i][1],legal[i][2]),alpha)
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
            piece = ASCIIString(A[j]) 
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
                if numMoves == 2
                    for k = 1:2
                        dead = check_kill(inactive,legal[i][k])
                        push!(deadList,dead)
                        push!(deadCords,legal[i][k])
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
                   else
                        best_move_move = ((piece,legal[i][1],legal[i][2]),beta)
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

function bad_getPlay( AI::MonteCarlo, set::Pieces, enemy::Pieces)
    legal = Tuple{Int,Int}[]; # legal moves
    plays = []; # store states of board
    flag = 1 # 1 if there are statistics available for each play, 0 otherwise
    A = collect(keys(set.active))
    for i = 1:length(A)
        legal::Array = generate_moves(set,enemy,A[i])
        for j = 1:length(legal)
            push!(plays,(set.color,(A[i],legal[j])))
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
        score = Inf; best_play = ()
        for i = 1:length(plays)
            wins = AI.history[plays[i]][1]
            total = AI.history[plays[i]][2]   
            new_score = (wins/total) + AI.C*sqrt(log(AI.total)/total)
            if new_score < score 
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
        if numMoves == 2
            # println(piece)
            # println(active.active[piece])
            # println(move)
            # println("numMoves = $numMoves")
            for i = 1:2
                check_kill(inactive,move[i]); piece = promote_AI(active,piece,move[i])
            end
            update_piece(active,piece,move[2])
        else
            # println(piece)
            # println(active.active[piece])
            # println(move)
            # println("numMoves = $numMoves")
            update_piece(active,piece,move)
            check_kill(inactive,move); piece = promote_AI(active,piece,move)
        end 
        if haskey(AI.history,play) == true # node exists
            wins = AI.history[play][1]; total = AI.history[play][2]
            AI.history[play] = (wins,total+1)
        else # new node
            get!(AI.history,play,(0,1))
        end
        push!(AI.path,play); AI.total += 1
    end
    # haskey(red.active,"k") == true ? winner = "red" : winner = "black"
    # println(winner)
    backPropogate(AI) # update with play out
end


# updates winning nodes of MCTS - call after a play out
function backPropogate(AI::MonteCarlo)
    for i = length(AI.path):-2:1 # propagate back up the tree
        node = AI.path[i]
        old = AI.history[node]
        AI.history[node] = (old[1]+1,old[2])
    end
    deleteat!(AI.path,1:length(AI.path)) # clear path for next simulation
end

# used in competition
function black_MCTS(AI::MonteCarlo)
    return getPlay(AI,AI.black,AI.red) 
end

function bad_black_MCTS(AI::MonteCarlo)
    return bad_getPlay(AI,AI.black,AI.red) 
end

function red_MCTS(AI::MonteCarlo)
    return getPlay(AI,AI.red,AI.black) 
end

function bad_red_MCTS(AI::MonteCarlo)
    return bad_getPlay(AI,AI.red,AI.black) 
end

####

# red = Pieces("red")
# fill_red(red)
# black = Pieces("black")
# fill_black(black)

# julia = MonteCarlo(black,red) # instantiate MCTS

# # #simulate(julia)
# for i = 1:1000 # run simulations to fill MCTS
#     simulate(julia)
# end

# # add in new history
# writedlm("chu_MCTS.txt",julia.history)

# AI_move_piece(black,red,"v1",(1,1))
# #println(black.active["v1"])
# legal = generate_moves(black,red,"V1")
# println(legal)







