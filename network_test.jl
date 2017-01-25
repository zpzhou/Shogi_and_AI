include("start_game.jl")
include("networking.jl")
include("database.jl")
include("general_functions.jl")
include("shogi.jl")
include("move_functions.jl")

window = Toplevel("shogi")
B = GUI(9,"normal",0)
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