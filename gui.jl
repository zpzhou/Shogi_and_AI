using Tk
using Graphics
using Cairo

include("general_functions.jl")
include("database.jl")
include("set_database.jl")
# include("shogi.jl")
# include("move_functions.jl")

if variant == "Standard Shogi"
  include("shogi.jl")
  include("move_functions.jl")
elseif variant == "Mini Shogi"
  include("minishogi.jl")
  include("move_functions_minishogi.jl")
elseif variant == "Chu Shogi"
  include("chu_shogi.jl")
  include("move_functions_chushogi.jl")
elseif variant == "Tenjiku Shogi"
  include("tenjiku_shogi.jl")
  include("move_functions_tenjikushogi.jl")
end

const UNIXEPOCH = DateTime(1970)
# takes current date time and returns number of seconds since unix epoch
datetime2unix(dt::DateTime) = (dt - UNIXEPOCH)/1000

type GUI
    dim::Int64
    mode::ASCIIString
    turn::Int64
    first::ASCIIString
    time::Int64
    clicks::Int64 # used to keep track of user clicks
    piece::ASCIIString
    source::Tuple # source coordinates of piece being moved
    updated::Int64
    GUI(dim::Int64,mode::ASCIIString,turn::Int64,first::ASCIIString,time::Int64) = new(dim,mode,turn,first,time,0,"",(0,0),0)
end

function nextMove(file::ASCIIString, black::Pieces, red::Pieces)
    turn = get_totalMoves(file)
    source = get_sourceCords(file,turn)
    target = get_targetCords(file,turn)
    if turn % 2 == 0
        piece = red.activeS[source]
        move_piece(red,black,piece,target)
    else
        piece = black.activeS[source]
        move_piece(black,red,piece,target)
    end
end

function singleStep(B::GUI, x::Int64, y::Int64)
    B.clicks = 0; promote = 0
    target = (x,abs(y-B.dim-1))
    turn = get_totalMoves(file)
    turn  % 2 == 0  ?
        flag  = validate_black(black,red,B.piece,B.source,target,0,0) :
        flag  = validate_red(red,black,B.piece,B.source,target,0,0)
    if flag == 1
        time = Int(datetime2unix(now())) - B.time
        add = get_timeAdd(file)
        if B.time != -1
            if turn % 2 == 0
                total = get_senteTime(file)
                set_senteTime(file,total-time+add)
            else
                total = get_goteTime(file)
                set_goteTime(file,total-time+add)
            end
        end
        set_move(file,"move",B.source,target,(0,0),(0,0),promote,0,"")
        B.turn = (B.turn+1)%2
        println("turn: $(B.turn)")
        setBoard(B,black,red)
    else
        println("illegal move")
    end
end

function doubleStep(B::GUI, x::Int64, y::Int64)
    B.clicks = 0
    target = (x,abs(y-B.dim-1))
    B.turn == 0 ?
        flag  = validate_black(black,red,B.piece,B.source[1],B.source[2],target,0) :
        flag = validate_red(red,black,B.piece,B.source[1],B.source[2],target,0)
    if flag == 1
        add = get_timeAdd(file)
        time = Int(datetime2unix(now())) - B.time
        if B.time != -1
            if turn % 2 == 0
                total = get_senteTime(file)
                set_senteTime(file,total-time+add)
            else
                total = get_goteTime(file)
                set_goteTime(file,total-time+add)
            end
        end
        set_move(file,"move",B.source[1],B.source[2],target,(0,0),0,0,"")
        B.turn = (B.turn+1)%2
        println("turn: $(B.turn)")
        setBoard(B,black,red)
    else
        println("illegal move")
    end
end

function tripleStep(B::GUI, x::Int64, y::Int64)
    B.clicks = 0
    target = (x,abs(y-B.dim-1))
    B.turn == 0 ?
        flag  = validate_black(black,red,B.piece,B.source[1],B.source[2],B.source[3],target) :
        flag = validate_red(red,black,B.piece,B.source[1],B.source[2].B.source[2],target)
    if flag == 1
        time = Int(datetime2unix(now())) - B.time
        add = get_timeAdd(file)
        if B.time != -1
            if turn % 2 == 0
                total = get_senteTime(file)
                set_senteTime(file,total-time+add)
            else
                total = get_goteTime(file)
                set_goteTime(file,total-time+add)
            end
        end
        set_move(file,"move",B.source[1],B.source[2],B.source[3],target,0,0,"")
        B.turn = (B.turn+1)%2
        println("turn: $(B.turn)")
        setBoard(B,black,red)
    else
        println("illegal move")
    end
end

function double_list(piece::ASCIIString)
    contains(piece,"ion") && return 1
    contains(piece,"eagle") && return 1
    contains(piece,"tet") && return 1
    contains(piece,"fire") && return 1
    return 0
end

function triple_list(piece::ASCIIString)
    contains(piece,"fire") && return 1
    contains(piece,"vice") && return 1
    contains(piece,"Bishopgeneral") && return 1
    return 0
end

function placeImage_shogi(i,f)
    if i == ""
        img = Tk.Image("empty.gif")
    elseif i[end] == 'b'
        if i[1:(end-3)] == "pawn"
          img = Tk.Image("black_pawn.gif")
        elseif i[1:(end-3)] == "lance"
          img = Tk.Image("black_lance.gif")
        elseif i[1:(end-3)] == "knight"
          img = Tk.Image("black_knight.gif")
        elseif i[1:(end-3)] == "silvergeneral"
          img = Tk.Image("black_silver_general.gif")
        elseif i[1:(end-3)] == "goldgeneral" || i[1:(end-3)] == "Silver" || i[1:(end-3)] == "Knight" || i[1:(end-3)] == "Lance" || i[1:(end-3)] == "Pawn"
          img = Tk.Image("black_gold_general.gif")
        elseif i[1:(end-2)] == "king"
          img = Tk.Image("black_jeweled_general.gif")
        elseif i[1:(end-2)] == "rook"
          img = Tk.Image("black_rook.gif")
        elseif i[1:(end-2)] == "Rook"
          img = Tk.Image("black_rook_general.gif")
        elseif i[1:(end-2)] == "bishop"
          img = Tk.Image("black_bishop.gif")
        elseif i[1:(end-2)] == "Bishop"
          img = Tk.Image("black_bishop_general.gif")
        end
  elseif i[end] == 'r'
    if i[1:(end-3)] == "pawn"
      img = Tk.Image("white_pawn.gif")
    elseif i[1:(end-3)] == "lance"
      img = Tk.Image("white_lance.gif")
    elseif i[1:(end-3)] == "knight"
      img = Tk.Image("white_knight.gif")
    elseif i[1:(end-3)] == "silvergeneral"
      img = Tk.Image("white_silver_general.gif")
    elseif i[1:(end-3)] == "goldgeneral" || i[1:(end-3)] == "Silver" || i[1:(end-3)] == "Knight" || i[1:(end-3)] == "Lance" || i[1:(end-3)] == "Pawn"
      img = Tk.Image("white_gold_general.gif")
    elseif i[1:(end-2)] == "king"
      img = Tk.Image("white_king_general.gif")
    elseif i[1:(end-2)] == "rook"
      img = Tk.Image("white_rook.gif")
    elseif i[1:(end-2)] == "Rook"
      img = Tk.Image("white_rook_general.gif")
    elseif i[1:(end-2)] == "bishop"
      img = Tk.Image("white_bishop.gif")
    elseif i[1:(end-2)] == "Bishop"
      img = Tk.Image("white_bishop_general.gif")
    end
  end
  return img
end

function placeImage_chu(i,f)
    if i == ""
    img = Tk.Image("empty.gif")
  elseif i[end] == 'b'
    if i[1:(end-3)] == "pawn" || i[1:(end-4)] == "pawn"
      img = Tk.Image("black_pawn.gif")
    elseif i[1:(end-3)] == "lance"
      img = Tk.Image("black_lance.gif")
    elseif i[1:(end-3)] == "knight"
      img = Tk.Image("black_knight.gif")
    elseif i[1:(end-3)] == "silvergeneral"
      img = Tk.Image("black_silver_general.gif")
    elseif i[1:(end-3)] == "goldgeneral"
      img = Tk.Image("black_gold_general.gif")
    elseif i[1:(end-2)] == "king"
      img = Tk.Image("black_jeweled_general.gif")
    elseif i[1:(end-3)] == "rook"
      img = Tk.Image("black_rook.gif")
    elseif i[1:(end-3)] == "bishop"
      img = Tk.Image("black_bishop.gif")
    elseif i[1:(end-3)] == "coppergeneral"
      img = Tk.Image("black_copper_general.gif")
    elseif i[1:(end-3)] == "ferociousleopard"
      img = Tk.Image("black_ferocious_leopard.gif")
    elseif i[1:(end-2)] == "drunkelephant"
      img = Tk.Image("black_drunk_elephant.gif")
    elseif i[1:(end-3)] == "reversechariot"
      img = Tk.Image("black_reverse_chariot.gif")
    elseif i[1:(end-3)] == "blindtiger"
      img = Tk.Image("black_blind_tiger.gif")
    elseif i[1:(end-2)] == "phoenix"
      img = Tk.Image("black_phoenix.gif")
    elseif i[1:(end-2)] == "kirin"
      img = Tk.Image("black_kirin.gif")
    elseif i[1:(end-3)] == "sidemover"
      img = Tk.Image("black_side_mover.gif")
    elseif i[1:(end-3)] == "verticalmover"
      img = Tk.Image("black_vertical_mover.gif")
    elseif i[1:(end-3)] == "dragonhorse"
      img = Tk.Image("black_dragon_horse.gif")
    elseif i[1:(end-3)] == "dragonking"
      img = Tk.Image("black_dragon_king.gif")
    elseif i[1:(end-2)] == "queen"
      img = Tk.Image("black_queen.gif")
    elseif i[1:(end-2)] == "lion"
      img = Tk.Image("black_lion.gif")
    elseif i[1:(end-3)] == "gobetween"
      img = Tk.Image("black_gobetween.gif")
    end
  elseif i[end] == 'r'
    if i[1:(end-3)] == "pawn" || i[1:(end-4)] == "pawn"
      img = Tk.Image("white_pawn.gif")
    elseif i[1:(end-3)] == "lance"
      img = Tk.Image("white_lance.gif")
    elseif i[1:(end-3)] == "knight"
      img = Tk.Image("white_knight.gif")
    elseif i[1:(end-3)] == "silvergeneral"
      img = Tk.Image("white_silver_general.gif")
    elseif i[1:(end-3)] == "goldgeneral"
      img = Tk.Image("white_gold_general.gif")
    elseif i[1:(end-2)] == "king"
      img = Tk.Image("white_king_general.gif")
    elseif i[1:(end-3)] == "rook"
      img = Tk.Image("white_rook.gif")
    elseif i[1:(end-3)] == "bishop"
      img = Tk.Image("white_bishop.gif")
    elseif i[1:(end-3)] == "coppergeneral"
      img = Tk.Image("white_copper_general.gif")
    elseif i[1:(end-3)] == "ferociousleopard"
      img = Tk.Image("white_ferocious_leopard.gif")
    elseif i[1:(end-2)] == "drunkelephant"
      img = Tk.Image("white_drunk_elephant.gif")
    elseif i[1:(end-3)] == "reversechariot"
      img = Tk.Image("white_reverse_chariot.gif")
    elseif i[1:(end-3)] == "blindtiger"
      img = Tk.Image("white_blind_tiger.gif")
    elseif i[1:(end-2)] == "phoenix"
      img = Tk.Image("white_phoenix.gif")
    elseif i[1:(end-2)] == "kirin"
      img = Tk.Image("white_kirin.gif")
    elseif i[1:(end-3)] == "sidemover"
      img = Tk.Image("white_side_mover.gif")
    elseif i[1:(end-3)] == "verticalmover"
      img = Tk.Image("white_vertical_mover.gif")
    elseif i[1:(end-3)] == "dragonhorse"
      img = Tk.Image("white_dragon_horse.gif")
    elseif i[1:(end-3)] == "dragonking"
      img = Tk.Image("white_dragon_king.gif")
    elseif i[1:(end-2)] == "queen"
      img = Tk.Image("white_queen.gif")
    elseif i[1:(end-2)] == "lion"
      img = Tk.Image("white_lion.gif")
    elseif i[1:(end-3)] == "gobetween"
      img = Tk.Image("white_gobetween.gif")
    end
  end
  return img
end

function placeImage_ten(i,f)
    if i == ""
    img = Tk.Image("empty.gif")
  elseif i[end] == 'b'
    if i[1:(end-3)] == "pawn" || i[1:(end-4)] == "pawn"
      img = Tk.Image("black_pawn.gif")
    elseif i[1:(end-3)] == "lance"
      img = Tk.Image("black_lance.gif")
    elseif i[1:(end-3)] == "knight"
      img = Tk.Image("black_knight.gif")
    elseif i[1:(end-3)] == "silvergeneral"
      img = Tk.Image("black_silver_general.gif")
    elseif i[1:(end-3)] == "goldgeneral"
      img = Tk.Image("black_gold_general.gif")
    elseif i[1:(end-2)] == "king"
      img = Tk.Image("black_jeweled_general.gif")
    elseif i[1:(end-3)] == "rook"
      img = Tk.Image("black_rook.gif")
    elseif i[1:(end-3)] == "bishop"
      img = Tk.Image("black_bishop.gif")
    elseif i[1:(end-3)] == "coppergeneral"
      img = Tk.Image("black_copper_general.gif")
    elseif i[1:(end-3)] == "ferociousleopard"
      img = Tk.Image("black_ferocious_leopard.gif")
    elseif i[1:(end-2)] == "drunkelephant"
      img = Tk.Image("black_drunk_elephant.gif")
    elseif i[1:(end-3)] == "reversechariot"
      img = Tk.Image("black_reverse_chariot.gif")
    elseif i[1:(end-3)] == "blindtiger"
      img = Tk.Image("black_blind_tiger.gif")
    elseif i[1:(end-2)] == "phoenix"
      img = Tk.Image("black_phoenix.gif")
    elseif i[1:(end-2)] == "kirin"
      img = Tk.Image("black_kirin.gif")
    elseif i[1:(end-3)] == "sidemover"
      img = Tk.Image("black_side_mover.gif")
    elseif i[1:(end-3)] == "verticalmover"
      img = Tk.Image("black_vertical_mover.gif")
    elseif i[1:(end-3)] == "dragonhorse"
      img = Tk.Image("black_dragon_horse.gif")
    elseif i[1:(end-3)] == "dragonking"
      img = Tk.Image("black_dragon_king.gif")
    elseif i[1:(end-2)] == "queen"
      img = Tk.Image("black_queen.gif")
    elseif i[1:(end-2)] == "lion"
      img = Tk.Image("black_lion.gif")
    elseif i[1:(end-3)] == "gobetween"
      img = Tk.Image("black_gobetween.gif")
    elseif i[1:(end-3)] == "irongeneral"
      img = Tk.Image("black_iron_general.gif")
    elseif i[1:(end-3)] == "chariotsoldier"
      img = Tk.Image("black_chariot_soldier.gif")
    elseif i[1:(end-3)] == "sidesoldier"
      img = Tk.Image("black_side_soldier.gif")
    elseif i[1:(end-3)] == "verticalsoldier"
      img = Tk.Image("black_vertical_soldier.gif")
    elseif i[1:(end-3)] == "verticalmover"
      img = Tk.Image("black_vertical_mover.gif")
    elseif i[1:(end-3)] == "waterbuffalo"
      img = Tk.Image("black_water_buffalo.gif")
    elseif i[1:(end-3)] == "firedemon"
      img = Tk.Image("black_fire_demon.gif")
    elseif i[1:(end-2)] == "freeeagle"
      img = Tk.Image("black_free_eagle.gif")
    elseif i[1:(end-2)] == "lionhawk"
      img = Tk.Image("black_lion_hawk.gif")
    elseif i[1:(end-3)] == "hornedfalcon"
      img = Tk.Image("black_horned_falcon.gif")
    elseif i[1:(end-3)] == "soaringeagle"
      img = Tk.Image("black_soaring_eagle.gif")
    elseif i[1:(end-3)] == "bishopgeneral"
      img = Tk.Image("black_bishop_general.gif")
    elseif i[1:(end-3)] == "rookgeneral"
      img = Tk.Image("black_rook_general.gif")
    elseif i[1:(end-2)] == "vicegeneral"
      img = Tk.Image("black_vice_general.gif")
    elseif i[1:(end-2)] == "greatgeneral"
      img = Tk.Image("black_great_general.gif")
    elseif i[1:(end-3)] == "dog"
      img = Tk.Image("black_dog.gif")
    end
  elseif i[end] == 'r'
    if i[1:(end-3)] == "pawn" || i[1:(end-4)] == "pawn"
      img = Tk.Image("white_pawn.gif")
    elseif i[1:(end-3)] == "lance"
      img = Tk.Image("white_lance.gif")
    elseif i[1:(end-3)] == "knight"
      img = Tk.Image("white_knight.gif")
    elseif i[1:(end-3)] == "silvergeneral"
      img = Tk.Image("white_silver_general.gif")
    elseif i[1:(end-3)] == "goldgeneral"
      img = Tk.Image("white_gold_general.gif")
    elseif i[1:(end-2)] == "king"
      img = Tk.Image("white_king_general.gif")
    elseif i[1:(end-3)] == "rook"
      img = Tk.Image("white_rook.gif")
    elseif i[1:(end-3)] == "bishop"
      img = Tk.Image("white_bishop.gif")
    elseif i[1:(end-3)] == "coppergeneral"
      img = Tk.Image("white_copper_general.gif")
    elseif i[1:(end-3)] == "ferociousleopard"
      img = Tk.Image("white_ferocious_leopard.gif")
    elseif i[1:(end-2)] == "drunkelephant"
      img = Tk.Image("white_drunk_elephant.gif")
    elseif i[1:(end-3)] == "reversechariot"
      img = Tk.Image("white_reverse_chariot.gif")
    elseif i[1:(end-3)] == "blindtiger"
      img = Tk.Image("white_blind_tiger.gif")
    elseif i[1:(end-2)] == "phoenix"
      img = Tk.Image("white_phoenix.gif")
    elseif i[1:(end-2)] == "kirin"
      img = Tk.Image("white_kirin.gif")
    elseif i[1:(end-3)] == "sidemover"
      img = Tk.Image("white_side_mover.gif")
    elseif i[1:(end-3)] == "verticalmover"
      img = Tk.Image("white_vertical_mover.gif")
    elseif i[1:(end-3)] == "dragonhorse"
      img = Tk.Image("white_dragon_horse.gif")
    elseif i[1:(end-3)] == "dragonking"
      img = Tk.Image("white_dragon_king.gif")
    elseif i[1:(end-2)] == "queen"
      img = Tk.Image("white_queen.gif")
    elseif i[1:(end-2)] == "lion"
      img = Tk.Image("white_lion.gif")
    elseif i[1:(end-3)] == "gobetween"
      img = Tk.Image("white_gobetween.gif")
    elseif i[1:(end-3)] == "irongeneral"
      img = Tk.Image("white_iron_general.gif")
    elseif i[1:(end-3)] == "chariotsoldier"
      img = Tk.Image("white_chariot_soldier.gif")
    elseif i[1:(end-3)] == "sidesoldier"
      img = Tk.Image("white_side_soldier.gif")
    elseif i[1:(end-3)] == "verticalsoldier"
      img = Tk.Image("white_vertical_soldier.gif")
    elseif i[1:(end-3)] == "waterbuffalo"
      img = Tk.Image("white_water_buffalo.gif")
    elseif i[1:(end-3)] == "firedemon"
      img = Tk.Image("white_fire_demon.gif")
    elseif i[1:(end-2)] == "freeeagle"
      img = Tk.Image("white_free_eagle.gif")
    elseif i[1:(end-2)] == "lionhawk"
      img = Tk.Image("white_lion_hawk.gif")
    elseif i[1:(end-3)] == "hornedfalcon"
      img = Tk.Image("white_horned_falcon.gif")
    elseif i[1:(end-3)] == "soaringeagle"
      img = Tk.Image("white_soaring_eagle.gif")
    elseif i[1:(end-3)] == "bishopgeneral"
      img = Tk.Image("white_bishop_general.gif")
    elseif i[1:(end-3)] == "rookgeneral"
      img = Tk.Image("white_rook_general.gif")
    elseif i[1:(end-2)] == "vicegeneral"
      img = Tk.Image("white_vice_general.gif")
    elseif i[1:(end-2)] == "greatgeneral"
      img = Tk.Image("white_great_general.gif")
    elseif i[1:(end-3)] == "dog"
      img = Tk.Image("white_dog.gif")
    end
  end
  return img
end

function placeImage_mini(i,f)
  if i == ""
    img = Tk.Image("empty.gif")
  elseif i[end] == 'b'
    if i[1:(end-2)] == "pawn"
      img = Tk.Image("black_pawn.gif")
    elseif i[1:(end-2)] == "silvergeneral"
      img = Tk.Image("black_silver_general.gif")
    elseif i[1:(end-2)] == "goldgeneral"
      img = Tk.Image("black_gold_general.gif")
    elseif i[1:(end-2)] == "king"
      img = Tk.Image("black_jeweled_general.gif")
    elseif i[1:(end-2)] == "rook"
      img = Tk.Image("black_rook.gif")
    elseif i[1:(end-2)] == "bishop"
      img = Tk.Image("black_bishop.gif")
    end
  elseif i[end] == 'r'
    if i[1:(end-2)] == "pawn"
      img = Tk.Image("white_pawn.gif")
    elseif i[1:(end-2)] == "silvergeneral"
      img = Tk.Image("white_silver_general.gif")
    elseif i[1:(end-2)] == "goldgeneral"
      img = Tk.Image("white_gold_general.gif")
    elseif i[1:(end-2)] == "king"
      img = Tk.Image("white_king_general.gif")
    elseif i[1:(end-2)] == "rook"
      img = Tk.Image("white_rook.gif")
    elseif i[1:(end-2)] == "bishop"
      img = Tk.Image("white_bishop.gif")
    end
  end
  return img
end

function place_piece(B::GUI, i::ASCIIString, x::Int, y::Int)
    function isSecondClick(path)
        B.clicks += 1
        if B.clicks == 1
            B.source = (x,abs(y-B.dim-1)) # save source cords
            B.piece = i # save piece name
        elseif B.clicks == 2 && double_list(B.piece) == 0
            singleStep(B,x,y)
        elseif B.clicks == 2
            midSource = (x,abs(y-B.dim-1))
            B.source = (B.source,midSource)
        elseif B.clicks == 3 && triple_list(B.piece) == 0
            doubleStep(B,x,y)
        elseif B.clicks == 3
            midSource = (x,abs(y-B.dim-1))
            B.source = (B.source[1],B.source[2],midSource)
        else
            tripleStep(B,x,y)
        end
    end
    y = B.dim - y + 1
    if variant == "Tenjiku Shogi"
      f = Frame(window, padding = 0, width = 40, height = 40)
    else
      f = Frame(window, padding = 0, width = 60, height = 60)
    end
    pack_stop_propagate(f)
    grid(f,y,x)
   
    B.dim == 5 && (image = placeImage_mini(i,f))
    B.dim == 9 && (image = placeImage_shogi(i,f))
    B.dim == 12 && (image = placeImage_chu(i,f))
    B.dim == 16 && (image = placeImage_ten(i,f))
    a = Button(f, image)
    pack(a, expand=true, fill="both")
    bind(a, "command",isSecondClick)
end

function checkWinMessage(B::GUI, black::Pieces, red::Pieces)
    if haskey(red.active,"king_r") == 0
        message = "Black Wins"
        Messagebox(window,message)
    elseif haskey(black.active,"king_b") == 0
        message = "Red Wins"
        Messagebox(window,message)
    elseif B.time != -1
        if get_senteTime(file) <= 0
            message = "Red Wins"
            Messagebox(window,message)
        elseif get_goteTime(file) <= 0
            message = "Black Wins"
            Messagebox(window,message)
        end
    end
end

# function promptUserForDrop(PossiblePiecesToDrop,red,black,turn)

#     promoteBox = Toplevel("current player turn do you want to drop any pieces?",275,300)
#     tcl("pack", "propagate", promoteBox, false)
#     f = Frame(promoteBox)
#     pack(f, expand=true, fill="both")
#     PieceToDropMenu = Treeview(f, PossiblePiecesToDrop)
#     scrollbars_add(f, PieceToDropMenu)
#     UserCordsEntry = Entry(f)
#     okButton = Button(f, "Ok")
#     formlayout(UserCordsEntry, "enter (x,y) cordinates to drop")
#     formlayout(okButton, nothing)
#     focus(UserCordsEntry)
#     map(u -> pack(u, anchor="w"), (PieceToDropMenu, UserCordsEntry, okButton))
#     function allowBoardReset(path)
#         cords = get_value(UserCordsEntry)
#         cords = (parse(Int,cords[2]),parse(Int,cords[4]))
#         piece = get_value(PieceToDropMenu)
#         msg = "dropping $(cords, $(piece[1]), black contains the cords, $(haskey(black.activeS,cords) ,red contains the dropped cords $(haskey(red.activeS,cords)"
#         Messagebox(promoteBox, msg)

# end
function setBoard(B::GUI, black::Pieces, red::Pieces)
    len = B.dim
    for y in 1:len
        for x in 1:len
            place_piece(B,"", x,y)
        end
    end
    Bkeys = collect(keys(black.active))
    for i = 1:length(Bkeys)
        key = Bkeys[i]
        cords = black.active[key]
        place_piece(B,key,cords[1],cords[2])
    end
    Rkeys = collect(keys(red.active))
    for i = 1:length(Rkeys)
        key = Rkeys[i]
        cords = red.active[key]
        place_piece(B,key,cords[1],cords[2])
    end
    checkWinMessage(B,black,red) # check for winner
    B.time != -1 && (B.time = Int(datetime2unix(now())))
end

function replay(B::GUI, file::ASCIIString, black::Pieces, red::Pieces)
    total = get_totalMoves(file)
    for i = 1:total
        sleep(1)
        source = get_sourceCords(file,i)
        target = get_targetCords(file,i)
        if i % 2 == 0
            println("red turn")
            piece = red.activeS[source]
            replay_piece(red,black,piece,target,ispromoted(file,i))
        else
            println("black turn")
            piece = black.activeS[source]
            replay_piece(black,red,piece,target,ispromoted(file,i))
        end
        setBoard(B,black,red)
    end
end

function continueGame(file::ASCIIString, black::Pieces, red::Pieces)
    total = get_totalMoves(file)
    for i = 1:total
        source = get_sourceCords(file,i)
        target = get_targetCords(file,i)
        if i % 2 == 0
            piece = red.activeS[source]
            replay_piece(red,black,piece,target,ispromoted(file,i))
        else
            piece = black.activeS[source]
            replay_piece(black,red,piece,target,ispromoted(file,i))
        end
        setBoard(B,black,red)
    end
end

function userInput(piece)
    x = 0; y = 0
    input_window = Toplevel("Enter coordinates", 200, 100)
    pack_stop_propagate(input_window)
    input_frame = Frame(input_window, width = 200, height = 100)
    pack_stop_propagate(input_frame)
    pack(input_frame, expand = true, fill = "both")
    x_input = Entry(input_frame)
    y_input = Entry(input_frame)
    formlayout(x_input, "X")
    formlayout(y_input, "Y")
    focus(x_input)
    b = Button(input_frame, "Ok")
    formlayout(b, nothing)
    bind(b, "command") do path
      x = parse(Int64,get_value(x_input))
      y = parse(Int64,get_value(y_input)) 
      cords = (x,y)
      while( x == 0 && y == 0)
        Messagebox(input_window, "Please input a value for X and Y")
      end
      destroy(input_window) 
    if B.turn == 1 
      if drop_check(red,black,piece,cords) == 1 
        drop_piece(red,piece,cords)
        setBoard(B,black,red)
        B.turn += 1
      else
        println("illegal drop")
      end
    else
      if drop_check(black,red,piece,cords) == 1 
        drop_piece(black,piece,cords)
        setBoard(B,black,red)
        B.turn += 1
      else
        println("illegal drop")
      end
    end
  end
end

function drop_piece_window()
  #piece_list = []
  piece_list_window = Toplevel("List of available pieces", 300, 600)
  tcl("pack", "propagate", piece_list_window, false)
  piece_list_frame = Frame(piece_list_window, padding = 15)
  pack(piece_list_frame, expand=true, fill="both")

  f1 = Frame(piece_list_frame)
  if B.turn == 1
    lb = Treeview(f1, red.captured)
  elseif B.turn == 0
    lb = Treeview(f1, black.captured)
  end
  scrollbars_add(f1, lb)
  pack(f1,  expand=true, fill="both")

  b = Button(piece_list_frame, "Drop Piece")
  pack(b, side = "bottom")
  bind(b, "command") do path  ## do style
    choice = get_value(lb)
    userInput(choice[1])
    destroy(piece_list_window)
  end
end

#---------------------------------------------------------------------------------------------------

### MAIN
#----------------------------------------------------------------------------------------------
file = gamename
time_limit != -1 && (time_limit = parse(time_limit))
time_increment != 0 && (time_increment = parse(time_increment))

if variant == "Standard Shogi"
  window = Toplevel("Standard Shogi")
  B = GUI(9,"",0,"",time_limit)
  initial_option == "Start a new game" && set_database(file,"S",0,time_limit,time_increment)
elseif variant == "Mini Shogi"
  window = Toplevel("Mini Shogi")
  B = GUI(5,"",0,"",time_limit)
  initial_option == "Start a new game" && set_database(file,"M",0,time_limit,time_increment)
elseif variant == "Chu Shogi"
  window = Toplevel("Chu Shogi")
  B = GUI(12,"",0,"",time_limit)
  initial_option == "Start a new game" && set_database(file,"C",0,time_limit,time_increment)
elseif variant == "Tenjiku Shogi"
  window = Toplevel("Tenjiku Shogi")
  f = Frame(window, padding = 0, width = 40, height = 40)
  B = GUI(16,"",0,"",time_limit)
  initial_option == "Start a new game" && set_database(file,"T",0,time_limit,time_increment)
end

mb = Menu(window)            ## makes menu, adds to top-level window
fmenu = menu_add(mb, "File")
omenu = menu_add(mb, "Options")

menu_add(fmenu, "Start a new game", (path) -> new_game_options())
menu_add(fmenu, "Continue an old game", (path) -> continue_game_options())
menu_add(fmenu, "Replay a finished game", (path) -> replay_game())
if flip_table == "Yes"
  menu_add(fmenu, "Quit", (path) -> flipTable(file))
else
  menu_add(fmenu, "Quit", (path) -> destroy(window))
end


cb = Checkbutton(window, "Something visible")
set_value(cb, true)     ## initialize
menu_add(omenu, cb)     ## second argument is Tk_Checkbutton instance
if variant == "Standard Shogi" || variant == "Mini Shogi"
  menu_add(omenu, "Dropped Pieces List", (path) -> drop_piece_window())
end
menu_add(omenu, Separator(window))   ## put in a separator
rb = Radio(window, ["option 1", "option 2"])
set_value(rb, "option 1")   ## initialize
menu_add(omenu, rb)     ## second argument is Tk_Radio instance

pack_stop_propagate(window)
tcl("ttk::style", "configure", "TButton", background = "black", foreground = "blue")

# create red pieces
red = Pieces("red")
 # set starting coordinates of red pieces
fill_red(red)
# create black pieces
black = Pieces("black")
# set starting coordinates of black pieces
fill_black(black)

if initial_option == "Replay a finished game"
  replay(B,gamename,black,red)
  return
elseif initial_option == "Continue an old game"
  continueGame(B,gamename,black,red)
end

setBoard(B,black,red)
println("turn: $(B.turn)")


# IP = "207.23.189.170"
# port = 2003
