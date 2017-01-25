# AI for for the Japanese chess game Shogi.
# game logic provided by shogi.jl and move_functions.jl
# include("general_functions.jl")
# include("minishogi.jl")

# generate current unix time for seed
UT = DateTime(1970)
function datetime2unix()
    return Int64((DateTime(now())-UT)/1000)
end
seed = datetime2unix()
#println(seed)
# reseed RNG w/ seed
#srand(seed)

function range_AI(set::Pieces, enemy::Pieces, legal, source)
    friends = set.activeS; enemy = enemy.activeS
    x = source[1]; y = source[2]
    i = 1; cords = (x,y)
    while (cords[1] > 1 && cords[1] < 5) && (cords[2] > 1 && cords[2] < 5)
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
    while (cords[1] > 1 && cords[1] < 5) && (cords[2] > 1 && cords[2] < 5)
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
    while (cords[1] > 1 && cords[1] < 5) && (cords[2] > 1 && cords[2] < 5)
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
    while (cords[1] > 1 && cords[1] < 5) && (cords[2] > 1 && cords[2] < 5)
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

function cross_AI(set::Pieces, enemy::Pieces, legal, source)
    x = source[1]; y = source[2]
    friends = set.activeS; enemy = enemy.activeS
    for i = y+1:5 # move upwards
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
    for i = x+1:5 # move rightwards
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

function clear_array(A::Array)
    len = length(A)
    deleteat!(julia.legal,1:len)
end



# finds all the possible moves for king given its position
function king_AI(set::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    cords::Tuple{Int64,Int64} # stores possible coordinates 
    # friendly units
    friends = set.activeS
    cords = (x,y+1)  # step up
    if y != 5 && haskey(friends,cords) != true
        push!(legal,cords) 
    end
    cords = (x,y-1) # step down
    if y != 1 && haskey(friends,cords) != true
        push!(legal,cords)
    end
    cords = (x+1,y) # step right    
    if x != 5 && haskey(friends,cords) != true
        push!(legal,cords)
    end
    cords = (x-1,y) # step left
    if x != 1 && haskey(friends,cords) != true
        push!(legal,cords)
    end
    if x != 5 && y != 5 # step top right
        haskey(friends,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
    end
    if x != 1 && y != 5 # step top left
        haskey(friends,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
    end
    if x != 5 && y != 1 # step bottom right
        haskey(friends,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
    end
    if x != 1 && y != 1 # step bottom left
        haskey(friends,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
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


# finds all possible moves for black gold general given its current coordinates
function black_gold_general_AI(set::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    # friendly units
    friendly = set.activeS
    if y != 1 && x != 1 && x != 5 
        haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
        haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
        # add left and right movement
        haskey(friendly,(x+1,y)) == 0 && push!(legal,(x+1,y))
        haskey(friendly,(x-1,y)) == 0 && push!(legal,(x-1,y))
    elseif y == 1 && x != 1 && x != 5
        haskey(friendly,(x-1,y)) == 0 && push!(legal,(x-1,y))
        haskey(friendly,(x+1,y)) == 0 && push!(legal,(x+1,y))
    elseif y != 1 && x == 5 # if piece is on right side of board, and y != 1
        haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
        haskey(friendly,(x-1,y)) == 0 && push!(legal,(x-1,y))
    elseif y != 1 && x == 1 # if piece is on left side of board, and y != 1
        haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
        haskey(friendly,(x+1,y)) == 0 && push!(legal,(x+1,y))
    elseif x == 5 # if x == 5 and y == 1
        haskey(friendly,(x-1,y)) == 0 && push!(legal,(x-1,y))
    elseif x == 1 # if x == 1 and y = 1
        haskey(friendly,(x+1,y)) == 0 && push!(legal,(x+1,y))
    end
    # adds the backstep allowable coordinates
    if y != 5
        haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
    end
    return legal
end

# finds all possible moves for red gold general given its current coordinates
function red_gold_general_AI(set::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    # friendly units
    friendly = set.activeS
    if y != 5 && x != 5 && x != 1 
        haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
        # add left and right movement
        haskey(friendly,(x+1,y)) == 0 && push!(legal,(x+1,y))
        haskey(friendly,(x-1,y)) == 0 && push!(legal,(x-1,y))
    elseif y == 5 && x != 5 && x != 1
        haskey(friendly,(x-1,y)) == 0 && push!(legal,(x-1,y))
        haskey(friendly,(x+1,y)) == 0 && push!(legal,(x+1,y))
    elseif y != 5 && x == 5 # if piece is on left side of board, and y != 5
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
        haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        haskey(friendly,(x-1,y)) == 0 && push!(legal,(x-1,y))
    elseif y != 5 && x == 1 # if piece is on right side of board, and y != 5
        haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
        haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        haskey(friendly,(x+1,y)) == 0 && push!(legal,(x+1,y))
    elseif x == 5 # if y == 5 and x == 5
        haskey(friendly,(x-1,y)) == 0 && push!(legal,(x-1,y))
    elseif x == 1 # if x == 1 and y = 5
        haskey(friendly,(x+1,y)) == 0 && push!(legal,(x+1,y))
    end
    if y != 1
        haskey(set.activeS,(x,y-1)) == 0 && push!(legal,(x,y-1))
    end
    return legal
end

# this function will be called in the main, and calls correct gold general function 
function gold_general_AI(set::Pieces, legal::Array, piece::ASCIIString)
    set.color == "black" ? 
        black_gold_general_AI(set,legal,piece) : 
        red_gold_general_AI(set,legal,piece)
end

# finds all possible moves for black silver general given its current coordinates
function black_silver_general_AI(set::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    # friendly units
    friendly = set.activeS
    if piece[1] == 'S'
        legal = black_gold_general_AI(set,legal,piece)
        return legal
    elseif y != 1 && x != 1 && x != 5 # if piece is not on a boundary
        haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
        haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
        haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
    elseif y != 1 && x == 5 # if piece is on right side of board, and y != 1
        haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
        haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
    elseif y != 1 && x == 1 # if piece is on left side of board, and y != 1
        haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
        haskey(friendly,(x,y-1)) == 0 && push!(legal,(x,y-1))
    end
    if y != 5 && x != 1
        haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
    end
    if y != 5 && x != 5
        haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
    end
    return legal
end

# finds all possible moves for red silver general given its current coordinates
function red_silver_general_AI(set::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords 
    x = set.active[piece][1]; y = set.active[piece][2] 
    # friendly units
    friendly = set.activeS
    if piece[1] == 'S' # if silver general is promoted
        legal = red_gold_general_AI(set,legal,piece)
        return legal
    elseif y != 5 && x != 5 && x != 1 
        haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
        haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
    elseif y != 5 && x == 5 # if piece is on left side of board, and y != 5
        haskey(friendly,(x-1,y+1)) == 0 && push!(legal,(x-1,y+1))
        haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
    elseif y != 5 && x == 1 # if piece is on right side of board, and y != 5
        haskey(friendly,(x+1,y+1)) == 0 && push!(legal,(x+1,y+1))
        haskey(friendly,(x,y+1)) == 0 && push!(legal,(x,y+1))
    end
    # check if steps back are allowable coordinates
    if y != 1 && x != 1
        haskey(friendly,(x-1,y-1)) == 0 && push!(legal,(x-1,y-1))
    end
    if y != 1 && x != 5
        haskey(friendly,(x+1,y-1)) == 0 && push!(legal,(x+1,y-1))
    end
    return legal
end

# general silver general function calls correct colored silver general function
function silver_general_AI(set::Pieces, legal::Array, piece::ASCIIString)
    set.color == "black" ?
        black_silver_general_AI(set,legal,piece) :
        red_silver_general_AI(set,legal,piece)
end

# pawn
function black_pawn_AI(set::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords
    x = set.active[piece][1]; y = set.active[piece][2]
    # friends units
    friends = set.activeS
    if piece[1] == 'P' # check for promotion
        legal = black_gold_general_AI(set,legal,piece)
        return legal
    else
        if y != 1
            haskey(friends,(x,y-1)) == 0 && push!(legal,(x,y-1))
        end
    end
    return legal
end

function red_pawn_AI(set::Pieces, legal::Array, piece::ASCIIString)
    # initial x and y cords
    x = set.active[piece][1]; y = set.active[piece][2]
    # friends units
    friends = set.activeS
    if piece[1] == 'P' # check for promotion
        legal = red_gold_general_AI(set,legal,piece)
        return legal
    else
        if y != 5
            haskey(friends,(x,y+1)) == 0 && push!(legal,(x,y+1))
        end
    end
    return legal
end

# this function will be called in the main, and calls correct pawn function 
function pawn_AI(set::Pieces, legal::Array, piece::ASCIIString)
    set.color == "black" ? 
        black_pawn_AI(set,legal,piece) : 
        red_pawn_AI(set,legal,piece)
end


function choose_piece(set::Pieces) 
    A = collect(keys(AI.set.active))
    piece = rand(A)
    return piece
end

function choose_move(set::Pieces, legal::Array, enemy::Pieces)
    kills = Dict() 
    for i = 1:length(legal)
        piece = enemy.activeS[legal[i]]
        if haskey(enemy.activeS,legal[i]) == true
            AI.kill = 1
            if piece[1] == 'p'
                get!(kills,1,legal[i])
            elseif piece[1] == 'n'
                get!(kills,2,legal[i])
            elseif piece[1] == 's'
                get!(kills,1,legal[i])
            elseif piece[1] == 'l'
                get!(kills,4,legal[i])
            elseif piece[1] == 'r' 
                get!(kills,6,legal[i])
            elseif piece[1] == 'b' 
                get!(kills,7,legal[i])
            elseif piece[1] == 'R'
                get!(kills,8,legal[i])
            elseif piece[1] == 'B'
                get!(kills,5,legal[i])
            elseif piece[1] == 'k'
                get!(kills,10,legal[i])
            else
                get!(kills,5,legal[i])
            end
        end
    end
    if length(kills) != 0
        max = 0
        for pair in kills
            pair[1] > max && (max = pair[1])
        end
        return Pair(max,kills[max])
    else
        cords = rand(legal)
        return Pair(0,cords)
    end  
end

# generates all possible moves, stores into entire legal array
function generate_moves(set::Pieces, enemy::Pieces, legal::Array, piece)
    if piece[1] == 'k'
        legal = king_AI(set,legal,piece)
    elseif piece[1] == 'r' || piece[1] == 'R'
        legal = rook_AI(set,enemy,legal,piece)
    elseif piece[1] == 'b' || piece[1] == 'B'
        legal = bishop_AI(set,enemy,legal,piece)
    elseif piece[1] == 'g'
        legal = gold_general_AI(set,legal,piece)
    elseif piece[1] == 's' || piece[1] == 'S'
        legal = silver_general_AI(set,legal,piece)
    elseif piece[1] == 'p' || piece[1] == 'P'
        legal = pawn_AI(set,legal,piece)
    end
    return legal
end

function drop_AI(set::Pieces, inactive::Pieces, piece)
    cords::Tuple
    if piece[1] == 'p'
        A = Int64[]
        for pair in set.active
            pair[1][1] == 'p' && push!(A,pair[2][1])
        end
        sum(A) == 45 && return (0,0)
        cords = (rand(1:4),rand(1:4))
        while haskey(set.activeS,cords) == true || haskey(inactive.activeS,cords) == true || findfirst(A,cords[1]) != 0
            cords = (rand(1:4),rand(1:4))
        end
    elseif piece[1] == 'n' || piece[1] == 'l'
        cords = (rand(1:4),rand(1:4))
        while haskey(set.activeS,cords) == true || haskey(inactive.activeS,cords) == true 
            cords = (rand(1:4),rand(1:4))
        end
    else
        cords = (rand(1:5),rand(1:5))
        while haskey(set.activeS,cords) == true || haskey(inactive.activeS,cords) == true 
            cords = (rand(1:5),rand(1:5))
        end
    end
    return cords
end

# function promote_AI(set::Pieces, piece,cords)
#     if piece[1]=='p' || piece[1]=='l' || piece[1]=='n' || piece[1]=='s'
#         if set.color == "black" && cords[2] < 2
#             old = set.active[piece]
#             pop!(set.active,piece) 
#             pop!(set.activeS,old)
#             piece = ucfirst(piece) # promotion
#             # add promoted piece
#             get!(set.active,piece,cords) 
#             get!(set.activeS,cords,piece)
#         elseif active.color == "red" && cords[2] > 4
#             old = set.active[piece]
#             pop!(set.active,piece) 
#             pop!(set.activeS,old)
#             piece = ucfirst(piece) # promotion
#             # add promoted piece
#             get!(set.active,piece,cords) 
#             get!(set.activeS,cords,piece)
#         end
#     end
#     return piece
# end

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
    #println("maximizer turn")
    best_move::Tuple{Tuple{ASCIIString,Tuple{Int64,Int64}},Int64} 
    best_move = (("NULL",(0,0)),score(active,inactive))
    # if depth is reached, recurse back
    if depth == limit 
        return best_move
    else
        A = collect(keys(active.active)) 
        #println(A)
        # generate all possible moves for each piece on black
        for j = 1:length(A) 
            piece = A[j]; legal = Tuple{Int,Int}[] 
            generate_moves(active,inactive,legal,piece) 
            cords = active.active[piece]
            # analyse each possible move
            for i = 1:length(legal) 
                old_alpha::Float64 = alpha
                old_cords = active.active[piece] # save old coordinates
                # simulate move
                update_piece(active,piece,legal[i])
                dead::ASCIIString = check_kill(inactive,legal[i])
                # recursive call to minimizer
                AB = min_AB(inactive,active,alpha,beta,depth+1,limit)
                alpha = max(alpha,AB[2])
                # update best_move
                old_alpha < alpha && (best_move = ((piece,legal[i]),alpha))  
                # reverse simulation
                update_piece(active,piece,old_cords)
                dead != "NULL" && raise_dead(inactive,dead,legal[i])
                # check for alpha-beta pruning
                if alpha >= beta 
                    #println("pruned")
                    return best_move
                end     
            end
        end
    end
    return best_move
end

function min_AB(active::Pieces, inactive::Pieces, alpha, beta, depth, limit)
    #println("minimizer turn")
    best_move::Tuple{Tuple{ASCIIString,Tuple{Int64,Int64}},Int64} 
    best_move = (("NULL",(0,0)),score(active,inactive))
    # if depth is reached, recurse back
    if depth == limit 
        return best_move
    else
        # generate all possible moves for each piece on black
        A = collect(keys(active.active)) 
        for j = 1:length(A) 
            piece = A[j]; legal = Tuple{Int,Int}[] 
            generate_moves(active,inactive,legal,piece) 
            # println(piece)
            # println(legal)
            # analyse each possible move
            for i = 1:length(legal)
                old_beta::Float64 = beta
                old_cords = active.active[piece] # save old coordinates
                # simulate move
                update_piece(active,piece,legal[i])
                dead::ASCIIString = check_kill(inactive,legal[i])
                #println("$piece killed $dead")
                # recursive call to minimizer
                AB = max_AB(inactive,active,alpha,beta,depth+1,limit)
                beta = min(beta,AB[2])
                # update best_move
                old_beta > beta && (best_move = ((piece,legal[i]),beta))
                # reverse simulation
                update_piece(active,piece,old_cords)
                dead != "NULL" && raise_dead(inactive,dead,legal[i])
                # check for alpha-beta pruning
                if alpha >= beta
                    #println("pruned")
                    return best_move
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
    legal = Tuple{Int,Int}[]; # legal moves
    plays = []; # store states of board
    flag = 1 # 1 if there are statistics available for each play, 0 otherwise
    A = collect(keys(set.active))
    for i = 1:length(A)
        legal::Array = generate_moves(set,enemy,legal,A[i])
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
        # play = minimax_AB(set,enemy,-Inf,Inf,0,3)
        # set.color == "black" ?
        #     play = (("black",play[1][1]),play[1][2]) :
        #     play = (("red",play[1][1]),play[1][2])
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
        legal::Array = generate_moves(set,enemy,legal,A[i])
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
        if AI.total % 2 == 0 
            play = getPlay(AI,black,red) 
            AI_move_piece(black,red,play[2][1],play[2][2])
            
            # play = minimax_AB(black,red,-Inf,Inf,0,3)
            # play = (("black",play[1][1]),play[1][2])
            # AI_move_piece(black,red,play[1][2],play[2])
        else
            play = getPlay(AI,red,black) 
            AI_move_piece(red,black,play[2][1],play[2][2])

            # play = minimax_AB(red,black,-Inf,Inf,0,3)
            # play = (("red",play[1][1]),play[1][2])
            # AI_move_piece(red,black,play[1][2],play[2])      
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

# used in competition
function bad_black_MCTS(AI::MonteCarlo)
    return bad_getPlay(AI,AI.black,AI.red) 
end

function red_MCTS(AI::MonteCarlo)
    return getPlay(AI,AI.red,AI.black) 
end

### TESTING

# # initialize sides and AI - with its side
# red = Pieces("red")
# fill_red(red)
# black = Pieces("black")
# fill_black(black)

# julia = MonteCarlo(black,red)

# # # read in prior history
# # file = readdlm("mini_MCTS.txt"); len = size(file)[1]
# # for i = 1:len
# #     get!(julia.history,file[i],file[i,2])
# # end

# run simulations to fill MCTS
# for i = 1:100000 
#     simulate(julia)
# end

# add in new history
# writedlm("MCTS_mini.txt",julia.history)


# # legal = Tuple{Int,Int}[] 
# # legal = generate_moves(black,legal,"s2")
# # println(legal)
# #julia = AI(black)

# # update_piece(red,"p1",(1,6))
# # update_piece(red,"p2",(2,6))
# # update_piece(red,"p3",(3,6))
# # update_piece(red,"p4",(4,6))
# # update_piece(red,"p5",(5,6))
# # update_piece(red,"p6",(6,6))
# # update_piece(red,"p7",(7,6))
# # update_piece(red,"p8",(8,6))
# # update_piece(red,"p9",(9,6))

# minimax_AB(black,red,-Inf,Inf,0,3)
# # for Pair in black.active
# #     println(Pair)
# # end

# # cords = black.active["n1"]
# # println(black.active["n1"])
# # println(black.activeS[cords])

# # fill the AI pieces 
# # fill_black(julia.set)









