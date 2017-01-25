# Orange Julias
# Functions related to SQLite database
# Create, insert values, extract table values

using DataArrays, DataFrames
using SQLite

#init database. for start.jl only
function init_database(f::ASCIIString)
	#Check if gamefile already exists
	list_of_files = readdir()
	if findfirst(list_of_files,f) == 0
		db=SQLite.DB(f)
	else
		#if gamefile already exists we delete it first
		file_to_delete = AbstractString(f)
		rm(file_to_delete)
		db=SQLite.DB(f)
	end
# create meta data table
	SQLite.query(db,"create table meta (key text primary key, value)")
	SQLite.query(db,"insert into meta values('type',NULL)")
	SQLite.query(db,"insert into meta values('legality',NULL)")
	SQLite.query(db,"insert into meta values('timed',NULL)")
	SQLite.query(db,"insert into meta values('time_add',NULL)")
	SQLite.query(db,"insert into meta values('sente_time',NULL)")
	SQLite.query(db,"insert into meta values('gote_time',NULL)")
	SQLite.query(db,"insert into meta values('seed',NULL)")
	println("\nmeta table set.")

# create moves data table
	SQLite.query(db,"create table moves (move_number integer primary key,
																			move_type text,
																			sourcex integer,
																			sourcey integer,
																			targetx integer,
																			targety integer,
																			option text,
																			i_am_cheating integer,
																			targetx2 integer,
																			targety2 integer,
																			targetx3 integer,
																			targety3 integer )")
	println("\nmoves table set.\n")
end

###################################################################################################
## SET META TABLE

function set_gameType(f::ASCIIString,gt::ASCIIString)
	db=SQLite.DB(f)
	query = "update meta set value = '$(gt)' where key = 'type'"
	#println(query)
	SQLite.query(db,query)
end

function set_legality(f::ASCIIString,l::ASCIIString)
	db=SQLite.DB(f)
	query = "update meta set value = '$(l)' where key = 'legality'"
	#println(query)
	SQLite.query(db,query)
end

function set_isTimed(f::ASCIIString,str::ASCIIString)
	db=SQLite.DB(f)
	query = "update meta set value = '$(str)' where key = 'timed'"
	#println(query)
	SQLite.query(db,query)
end

function set_timeAdd(f::ASCIIString,t::Int)
	db=SQLite.DB(f)
	query = "update meta set value = '$(t)' where key = 'time_add'"
	#println(query)
	SQLite.query(db,query)
end

function set_senteTime(f::ASCIIString,t::Int)
	db=SQLite.DB(f)
	query = "update meta set value = '$(t)' where key = 'sente_time'"
	#println(query)
	SQLite.query(db,query)
end

function set_goteTime(f::ASCIIString,t::Int)
	db=SQLite.DB(f)
	query = "update meta set value = '$(t)' where key = 'gote_time'"
	#println(query)
	SQLite.query(db,query)
end


function set_seed(f::ASCIIString,s::Int)
	db=SQLite.DB(f)
	query = "update meta set value = '$(s)' where key = 'seed'"
	df = SQLite.query(db,query)
end

#---------------------------------------------------------------------------------------------------
## SET MOVES TABLE
#insert new row
#input: str filename, str movetype,(sx,sy),(tx,ty),(tx2,ty2),int promo,int cheat,str dropped piece
function set_move(f::ASCIIString,
									mType::ASCIIString, # insert "move", "drop" or "resign"
									source::Tuple{Int64,Int64},
									target::Tuple{Int64,Int64},
									target2::Tuple{Int64,Int64}, # insert (0,0) for this coord if game is not chu,ten shogi
									target3::Tuple{Int64,Int64}, # insert (0,0) for this coord if game is not ten shogi
									promo::Int, # insert int 1 if the piece is promoted
									cheat::Int, # insert int 1 if move cheat move
									droppedPiece::ASCIIString) # insert "" if the move is not a drop move
	db=SQLite.DB(f)
	mNum = get_totalMoves(f) + 1
	query_mNum = "insert into moves (move_number) values($(mNum))"
	SQLite.query(db,query_mNum) #update number of moves

	query_mType = "update moves set move_type = '$(mType)' where move_number = $(mNum)"
	SQLite.query(db,query_mType) #update move_type

	sx = source[1]
	query_sx = "update moves set sourcex = $(sx) where move_number = $(mNum)"
	SQLite.query(db,query_sx) #update source x cord

	sy = source[2]
	query_sy = "update moves set sourcey = $(sy) where move_number = $(mNum)"
	SQLite.query(db,query_sy) #update source y cord

	tx = target[1]
	query_tx = "update moves set targetx = $(tx) where move_number = $(mNum)"
	SQLite.query(db,query_tx) #update target x cord

	ty = target[2]
	query_ty = "update moves set targety = $(ty) where move_number = $(mNum)"
	SQLite.query(db,query_ty) #update target y cord

	tx2 = target2[1]
	query_tx2 = "update moves set targetx2 = $(tx2) where move_number = $(mNum)"
	SQLite.query(db,query_tx2) #update target2 x cord

	ty2 = target2[2]
	query_ty2 = "update moves set targety2 = $(ty2) where move_number = $(mNum)"
	SQLite.query(db,query_ty2) #update target2 y cord

	tx3 = target3[1]
	query_tx3 = "update moves set targetx3 = $(tx3) where move_number = $(mNum)"
	SQLite.query(db,query_tx3) #update target3 x cord

	ty3 = target3[2]
	query_ty3 = "update moves set targety3 = $(ty3) where move_number = $(mNum)"
	SQLite.query(db,query_ty3) #update target3 y cord

	# update option column
	# option <- "!"  when there's a promotion
	# option <- piece name when moveType is 'drop'
	# a dropped piece is unpromoted
	if promo == 1
		query_opt = "update moves set option = '!' where move_number = $(mNum)"
	elseif mType == "drop"
	  query_opt = "update moves set option = '$(droppedPiece)' where move_number = $(mNum)"
	else
		query_opt = "update moves set option = NULL where move_number = $(mNum)"
	end
	SQLite.query(db,query_opt)

	# update cheat
	if cheat == 1
		query_cheat = "update moves set i_am_cheating = 'yes' where move_number = $(mNum)"
	else
		query_cheat = "update moves set i_am_cheating = NULL where move_number = $(mNum)"
	end
	SQLite.query(db,query_cheat)
end


###################################################################################################
####EXTRACT VALUES FROM TABLES

#input:filename, table name. return the whole table, type dataframe
function get_table(f::ASCIIString,t::AbstractString) # the return type is DataFrame, treat it like a multi-dim array
	db=SQLite.DB(f)
	if t == "meta"									# https://dataframesjl.readthedocs.io/en/latest/
		df = SQLite.query(db,"select * from meta")
	else
		df = SQLite.query(db,"select * from moves")
	end
	return df
end

#---------------------------------------------------------------------------------------------------
## GET VALUES FROM META TABLE
#input: filename. return string game type
function get_gameType(f::ASCIIString)
	db=SQLite.DB(f)
	query = "SELECT value FROM meta where key = 'type'"
	df = SQLite.query(db,query)
	isnull(df[1,1]) == true ? (return "empty") : (return get(df[1,1]))
end

#input: filename. return bool
function ischeatGame(f::ASCIIString)
	db=SQLite.DB(f)
	query = "SELECT value FROM meta where key = 'legality'"
	df = SQLite.query(db,query)
	isnull(df[1,1]) == true ? (return "empty") : (l = get(df[1,1]))
	l == "cheating" ? (return true) : (return false)
end

#input: filename. return string legality
function get_legality(f::ASCIIString)
	db=SQLite.DB(f)
	query = "SELECT value FROM meta where key = 'legality'"
	df = SQLite.query(db,query)
	isnull(df[1,1]) == true ? (return "empty") : (return get(df[1,1]))
end

#input: filename. return bool
function isTimed(f::ASCIIString)
	db=SQLite.DB(f)
	query = "SELECT value FROM meta where key = 'timed'"
	df = SQLite.query(db,query)
	isnull(df[1,1]) == true ? (return false) : (t = get(df[1,1]))
	t == "yes" ? (return true) : (return false)
end

#input: filename. return int time to add
function get_timeAdd(f::ASCIIString)
	db=SQLite.DB(f)
	query = "SELECT value FROM meta where key = 'time_add'"
	df = SQLite.query(db,query)
	isnull(df[1,1]) == true ? (return 0) : (return parse(get(df[1,1])))
end


#input: filename. return int time left for sente. -1 means there's no time limit
function get_senteTime(f::ASCIIString)
	db=SQLite.DB(f)
	query = "SELECT value FROM meta where key = 'sente_time'"
	df = SQLite.query(db,query)
	isnull(df[1,1]) == true || parse(get(df[1,1])) < 0? (return -1) : (return parse(get(df[1,1])))
end

#input: filename. return int time left for gote. -1 means there's no time limit
function get_goteTime(f::ASCIIString)
	db=SQLite.DB(f)
	query = "SELECT value FROM meta where key = 'gote_time'"
	df = SQLite.query(db,query)
	isnull(df[1,1]) == true || parse(get(df[1,1])) < 0 ? (return -1) : (return parse(get(df[1,1])))
end

#input: filename. return int seed
function get_seed(f::ASCIIString)
	db=SQLite.DB(f)
	query = "SELECT value FROM meta where key = 'seed'"
	df = SQLite.query(db,query)
	isnull(df[1,1]) == true ? (return 0) : (return parse(get(df[1,1])))
end

#---------------------------------------------------------------------------------------------------
## GET VALUES FROM MOVES TABLE

#input:filename, move number. return details of a row in a DataArray type. moveDetail(4)
#DEPRECATED, DON'T USE
function get_row(f::ASCIIString,mNum::Int)
	df = get_table(f,"moves")
	dv = @data([NA,NA,NA,NA,NA,NA,NA,NA])
	for i in 1:8
			dv[i] = df[mNum,i]
	end
	return dv
end
#input: filename. return an int total rows/moves in the moves
function get_totalMoves(f::ASCIIString)
	db=SQLite.DB(f)
	query = "SELECT Count(*) FROM moves"
	df = SQLite.query(db, query)
	return get(df[1,1])
end
#input:filename, move number. return a string move type at a specific move_num
function get_moveType(f::ASCIIString,mNum::Int)
	db=SQLite.DB(f)
	query = "SELECT move_type FROM moves where move_number = $(mNum)"
	df = SQLite.query(db, query)
	isnull(df[1,1]) == true? (return "NULL") : (return get(df[1,1]) )
end

#input:filename, move number. return a tuple source coord at a specific move_num
function get_sourceCords(f::ASCIIString,mNum::Int)
	db=SQLite.DB(f)
	query_getSourcex = "SELECT sourcex FROM moves where move_number = $(mNum)"
	query_getSourcey = "SELECT sourcey FROM moves where move_number = $(mNum)"
	dfx = SQLite.query(db, query_getSourcex)
	dfy = SQLite.query(db, query_getSourcey)
	size_dfx = size(dfx)[1]
	size_dfy = size(dfy)[1]
	if size_dfx == 0 || size_dfy == 0 || isnull(dfx[1,1]) == true || isnull(dfy[1,1]) == true
		cords = (0,0)
	else
		x = get(dfx[1,1])
		y = get(dfy[1,1])
		cords =(x,y)
	end
	return cords
end

#input:filename, move number. return a tuple target coord at a specific move_num
function get_targetCords(f::ASCIIString,mNum::Int)
	db=SQLite.DB(f)
	query_getTargetx = "SELECT targetx FROM moves where move_number = $(mNum)"
	query_getTargety = "SELECT targety FROM moves where move_number = $(mNum)"
	dfx = SQLite.query(db, query_getTargetx)
	dfy = SQLite.query(db, query_getTargety)
	size_dfx = size(dfx)[1]
	size_dfy = size(dfy)[1]
	if size_dfx == 0 || size_dfy == 0 || isnull(dfx[1,1]) == true || isnull(dfy[1,1]) == true
		cords = (0,0)
	else
		x = get(dfx[1,1])
		y = get(dfy[1,1])
		cords =(x,y)
	end
	return cords
end

function get_target2Cords(f::ASCIIString,mNum::Int)
	db=SQLite.DB(f)
	query_getTargetx2 = "SELECT targetx2 FROM moves where move_number = $(mNum)"
	query_getTargety2 = "SELECT targety2 FROM moves where move_number = $(mNum)"
	dfx = SQLite.query(db, query_getTargetx2)
	dfy = SQLite.query(db, query_getTargety2)
	size_dfx = size(dfx)[1]
	size_dfy = size(dfy)[1]
	if size_dfx == 0 || size_dfy == 0 || isnull(dfx[1,1]) == true || isnull(dfy[1,1]) == true
		cords = (0,0)
	else
		x = get(dfx[1,1])
		y = get(dfy[1,1])
		cords =(x,y)
	end
	return cords
end
function get_target3Cords(f::ASCIIString,mNum::Int)
	db=SQLite.DB(f)
	query_getTargetx3 = "SELECT targetx3 FROM moves where move_number = $(mNum)"
	query_getTargety3 = "SELECT targety3 FROM moves where move_number = $(mNum)"
	dfx = SQLite.query(db, query_getTargetx3)
	dfy = SQLite.query(db, query_getTargety3)
	size_dfx = size(dfx)[1]
	size_dfy = size(dfy)[1]
	if size_dfx == 0 || size_dfy == 0 || isnull(dfx[1,1]) == true || isnull(dfy[1,1]) == true
		cords = (0,0)
	else
		x = get(dfx[1,1])
		y = get(dfy[1,1])
		cords =(x,y)
	end
	return cords
end
#input:filename, move number. return bool if cheating at a specific move_num
function ischeatMove(f::ASCIIString,mNum::Int)
	db=SQLite.DB(f)
	query = "SELECT i_am_cheating FROM moves where move_number = $(mNum)"
	df = SQLite.query(db, query)
	isnull(df[1,1]) == true ? (return false) : (return true)
end

#input:filename, move number. return bool if a piece is promoted at a specific move_num
function ispromoted(f::ASCIIString,mNum::Int)
	db=SQLite.DB(f)
	query = "SELECT option FROM moves where move_number = $(mNum)"
	df = SQLite.query(db, query)
	size_df = size(df)[1]
	size_df == 0 || isnull(df[1,1]) == true || get(df[1,1]) != "!"? (return false) : (return true)
end

#input:filename, move number. return bool if a piece is dropped at a specific move_num
function isdropped(f::ASCIIString,mNum::Int)
	db=SQLite.DB(f)
	query = "SELECT option FROM moves where move_number = $(mNum)"
	df = SQLite.query(db, query)
	size_df = size(df)[1]
	size_df == 0 || isnull(df[1,1]) == true || get(df[1,1]) == "!" ? (return false) : (return true)
end
#input:filename, move number. return string piece name of the dropped piece at a specific move_num
function get_droppedPiece(f::ASCIIString,mNum::Int)
	db=SQLite.DB(f)
	query = "SELECT option FROM moves where move_number = $(mNum)"
	df = SQLite.query(db, query)
	isdropped(f,mNum) == true? ( return get( df[1,1] ) ) : (return "")
end

function flipTable(file::ASCIIString)
    set_move(file,"resign",(0,0),(0,0),(0,0),(0,0),0,0,"")
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
end

