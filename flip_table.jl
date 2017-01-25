include("database.jl")


# Use function set_move() from database.jl
# set_move(f::String,mType::AbstractString,
#					sx::Int,sy::Int,tx::Int,ty::Int,
#					promo::Int,cheat::Int, # insert int 1 if the piece is promoted or cheated
#					droppedPiece::AbstractString)
if length(ARGS) < 1
	println("\nInput is not valid. Please run the file again! 凸(｀ﾛ´)凸")
end
filename = ASCIIString(ARGS[1])
set_move(filename,"resign",0,0,0,0,0,0,"")
println("IM DELETING YOU, SHOGI!")
println("██]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]] 10% complete.....")
println("████]]]]]]]]]]]]]]]]]]]]]]]]]]] 35% complete....")
println("███████]]]]]]]]]]]]]]]] 60% complete....")
println("███████████] 99% complete.....")
println("\n\n(╯°□°)╯  ┻━┻")
println(
"....................../´¯/)
....................,/¯.../
..................../..../
.................../..../
................../..../
............./´¯'/...'/´¯¯`·¸
.........../..../..../.......
........../'/.../..../......./¨¯\
........././.../..../....../.....\
........('(...´...´.... ¯~/'.....')
........'' .......................|
.........'' .................'.../
..........'' ...................
...........'' ...\......... _.·´
..........................
............''.............(
.............''.............
..............''.............\...")

# table = get_table(filename,"moves")
# println(table)
