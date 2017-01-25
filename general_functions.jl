# general functions needed to run chu/mini/reg shogi

# Board class encapsulates the game board and keeps a Dict of all
# the current pieces on the board along with their coordinates.
type Board
    # game board
    board::Array

    # current turn
    turn::Int # black = even, red = odd

    # game status
    status::Bool # in play = 1, game over = 0

    # constructor
    Board(board::Array) = new(board,0,1)
end

# collection of all the active pieces and their coordinates
# promoted pieces are uppercase
type Pieces
    turn::Int64 # only relevant for chu shogi
    color::ASCIIString
    active::Dict # pieces currently on board, piece => cords
    activeS::Dict # cords => pieces
    promoted::Dict # promoted pieces
    captured::Array # pieces in hand
    # constructor
    Pieces(color::ASCIIString) = new(1,color,Dict(),Dict(),Dict(),Array{ASCIIString}(0))
end

### GENERAL FUNCTIONS

function promptPromote(set::Pieces,piece,cords)
  w = Toplevel()
    f = Frame(w)
    pack(f, expand=true, fill="both")

    l  = Label(f, "do you want to promote")
    rb = Radio(f, ["yes", "no"])
   okButton  = Button(f, "ok")
map(u -> pack(u, anchor="w"), (l, rb, okButton))     ## pack in left to right
  # flag = 0
  function isClicked(path)
    if (get_value(rb) == "yes")
      promote_piece(set,piece,cords)
      destroy(w)
    else
      destroy(w)
    end
  end
  bind(okButton, "command", isClicked)
  # return flag
end

# input function
function input()
    return chomp(readline(STDIN))
end

# sets a piece onto the board
function set_board(B::Board, pair::Pair)
    piece = pair[1]
    if length(piece) == 1 && piece!= "#"
        piece = "$piece "
    end
    c = pair[2][1]; r = shift_cord(pair[2][2])
    B.board[r,c] = piece
end


function init_board(B::Board, red::Pieces, black::Pieces)
    # place red pieces onto board
    for pair in red.active
        set_board(B,pair)
    end
    # place black pieces onto board
    for pair in black.active
        set_board(B,pair)
    end
end

# function update_board(B::Gtk.GtkGridLeaf, red::Pieces, black::Pieces)
#     # place red pieces onto board
#     for pair in red.active
#         set_board_gfx(B,pair)
#     end
#     # place black pieces onto board
#     for pair in black.active
#         set_board_gfx(B,pair)
#     end
# end

# updates the coordinates of a piece
function update_piece(set::Pieces, piece, cords)
    old = set.active[piece]
    # update cords dict
    pop!(set.activeS,old)
    get!(set.activeS,cords,piece)
    # update piece dict
    set.active[piece] = cords
end

# updates the coordinates of a piece
function update_piece(B::Board, set::Pieces, piece, cords)
    old = set.active[piece]
    # update cords dict
    pop!(set.activeS,old)
    get!(set.activeS,cords,piece)
    # update piece dict
    set.active[piece] = cords
    set_board(B,Pair(piece,cords)) # update gameboard
end

# add captured piece to hand
function update_hand(set::Pieces, piece)
    push!(set.captured,lcfirst(piece))

end

function check_kill(enemy::Pieces, cords)
    if haskey(enemy.activeS,cords) == true
        dead = enemy.activeS[cords]
        #println(dead)
        # remove piece from both collections
        pop!(enemy.activeS,cords)
        pop!(enemy.active,dead)
        #dead = "$(dead[1])"
        return dead
    end
    return "NULL"
end


# check for kill
function check_kill_drops(enemy::Pieces, cords)
    if haskey(enemy.activeS,cords) == true
        dead = enemy.activeS[cords]
        #println(dead)
        # remove piece from both collections
        pop!(enemy.activeS,cords)
        pop!(enemy.active,dead)
        for i = 1:2
            dead = chop(dead)
        end
        return lcfirst(dead)
    end
    return "NULL"
end

# check for kill
function check_kill(B::Board, set::Pieces, cords)
    if haskey(set.activeS,cords) == true
        dead = set.activeS[cords]
        # remove piece from both collections
        pop!(set.activeS,cords)
        pop!(set.active,dead)
        #dead = "$(dead[1])"
        dead == "king" && (B.status = 0) # check if king was slain
        return dead
    end
    return "NULL"
end

# function check_kill(B::Gtk.GtkGridLeaf, set::Pieces, cords)
#     if haskey(set.activeS,cords) == true
#         dead = set.activeS[cords]
#         # remove piece from both collections
#         pop!(set.activeS,cords)
#         pop!(set.active,dead)
#         #dead = "$(dead[1])"
#         dead == "k" && (B.status = 0) # check if king was slain
#         return dead
#     end
#     return "NULL"
# end

function raise_dead(dead::Pieces,piece,cords)
    get!(dead.active,piece,cords)
    get!(dead.activeS,cords,piece)
end

# used to auto promote AI piece when possible
function promote_AI(set::Pieces, piece, cords)
    if promote_validate(set::Pieces,piece,cords) == 1
        piece = promote_piece(set,piece,cords)
    end
    return piece
end

# unconditional promote
function promote_piece(set::Pieces,piece,cords)
    # remove unpromoted piece
    old = set.active[piece]
    pop!(set.active,piece)
    pop!(set.activeS,old)
    piece = ucfirst(piece) # promotion
    # add promoted piece
    get!(set.active,piece,cords)
    get!(set.activeS,cords,piece)
    return piece
end