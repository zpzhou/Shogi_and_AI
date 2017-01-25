include("set_database.jl")

################################
#Helping functions
################################
function parse_moveMsg_update_gamefile(msg::ASCIIString,filename::ASCIIString)
	#"<wincode = 2>:<filename>:<movenum:<movetype>:<sourcex>:<sourcey>:<targetx>:<targety>:<option>:<cheating>:<
	#targetx2>:<targety2><targetx3:targety3><time_lim>"
	arr_str = split(msg,":")
	mType = ASCIIString(arr_str[4])
	cheat = parse(arr_str[10])
	sx = parse(arr_str[5])
	sy = parse(arr_str[6])
	tx = parse(arr_str[7])
	ty = parse(arr_str[8])
	tx2 = parse(arr_str[11])
	ty2 = parse(arr_str[12])
	tx3 = parse(arr_str[13])
	ty3 = parse(arr_str[14])
	droppedPiece = ""
	promo = 0
	option = arr_str[9]
	if option == '!'
		promo == 1
	elseif mType == "drop"
		droppedPiece = ASCIIString(option)
	elseif option == 0
		droppedPiece = ""
	end

	# function set_move(f::ASCIIString,
	# 									mType::ASCIIString, # insert "move", "drop" or "resign"
	# 									source::Tuple{Int64,Int64},
	# 									target::Tuple{Int64,Int64},
	# 									target2::Tuple{Int64,Int64}, # insert (0,0) for this coord if game is not chu,ten shogi
	# 									target3::Tuple{Int64,Int64}, # insert (0,0) for this coord if game is not ten shogi
	# 									promo::Int, # insert int 1 if the piece is promoted
	# 									cheat::Int, # insert int 1 if move cheat move
	# 									droppedPiece::ASCIIString) # insert "" if the move is not a drop move
	set_move(filename,mType,(sx,sy),(tx,ty),(tx2,ty2),(tx3,ty3),promo,cheat,droppedPiece)
	time_lim = parse(arr_str[15])
	totalMoves = get_totalMoves(filename)
	if totalMoves%2 != 0
		set_senteTime(filename,time_lim)
	else
		set_goteTime(filename,time_lim)
	end
	println("Gamefile updated based on move msg.")
end

function extract_gamefile_form_moveMsg(filename::ASCIIString)
	totalMoves = get_totalMoves(filename)
	mType = get_moveType(filename,totalMoves)
	ischeatMove(filename,totalMoves)? (cheat = 1) : (cheat = 0)
	source = get_sourceCords(filename,totalMoves)
	target = get_targetCords(filename,totalMoves)
	target2 = get_target2Cords(filename,totalMoves)
	target3 = get_target3Cords(filename,totalMoves)
	sx = source[1]
	sy = source[2]
	tx = target[1]
	ty = target[2]
	tx2 = target2[1]
	ty2 = target2[2]
	tx3 = target3[1]
	ty3 = target3[2]

	droppedPiece = ""
	promo = 0
	option = ""
	if ispromoted(filename,totalMoves)
		option == '!'
	elseif isdropped(filename,totalMoves)
		option == get_droppedPiece(filename,totalMoves)
	else
		option = "0"
	end
	if totalMoves%2 != 0
		time_lim = get_senteTime(filename)
	else
		time_lim = get_goteTime(filename)
	end
	#"<wincode = 2>:<filename>:<movenum:<movetype>:<sourcex>:<sourcey>:<targetx>:<targety>:<option>:<cheating>:<
	#targetx2>:<targety2><targetx3:targety3><time_lim>"

	msg = string("2:",filename,":",totalMoves,":",mType,":",sx,":",sy,":",
							tx,":",ty,":",option,":",cheat,":",tx2,":",ty2,":",tx3,":",ty3,":",time_lim)
	return msg
end
################################
# Server functions
################################
function gen_authString()
  return randstring(8)
end


# return a string to send back to user
function process_msg_from_user(msg_from_user::ASCIIString,file_server::ASCIIString)
	arr_str = split(msg_from_user,":")
	if arr_str[1] == "0" # means request seed
		msg_to_send_back = user_wincode_is_zero(msg_from_user,file_server)
	elseif arr_str[1] == "2" # means user make a move
		msg_to_send_back = user_wincode_is_two(msg_from_user,file_server)
	else
		msg_to_send_back = "e:Not a valid Connect request"
	end
	return msg_to_send_back
end

#wincode = 0 =  request seed
function user_wincode_is_zero(msg_from_user::ASCIIString,file_server::ASCIIString)
	arr_str = split(msg_from_user,":")
	assert(length(arr_str) == 3) #makes sure the msg is valid
	#<"0"=request seed>:<filename>
	file_user = ASCIIString(arr_str[2])
	msg = ""
	if file_user == file_server
		seed = get_seed(file_server)
		println("Accept request.")
		#<0>:<filename>:<seed>:<Request accepted. Here's your seed.>
		msg=string("0",":",file_server,":",seed,":","Request accepted. Here's your seed.")
	elseif file_user != file_server
		msg = "e:no such gamefile."
	else
		println("Message from user is not valid.")
		msg = ""
	end
	return msg
end

#wincode = 2 = user make a move
function user_wincode_is_two(msg_from_user::ASCIIString,file_server::ASCIIString)
	arr_str = split(msg_from_user,":")
	assert(length(arr_str) == 15)
#"<wincode = 2>:<filename>:<movenum:<movetype>:<sourcex>:<sourcey>:<targetx>:<targety>:<option>:<cheating>:<
#targetx2>:<targety2><targetx3:targety3><time_lim>"
	file_user = ASCIIString(arr_str[2])
	msg = ""

	if file_user == file_server
		#Parse string to insert into database
		parse_moveMsg_update_gamefile(msg_from_user,file_server)

		total_moves = get_totalMoves(file_server) + 1
		while (get_totalMoves(file_server) < total_moves )
			sleep(5) # wait for the db to update
		end

		# Moves has been made from the server side. Form string to send back
		msg = extract_gamefile_form_moveMsg(file_server)
	elseif file_user != file_server
		msg = "e:no such gamefile."
	else
		msg = ""
	end
	return msg
end


################################
# Client functions
################################

function process_msg_from_server(msg_from_server::ASCIIString,file_user::ASCIIString)
	arr_str = split(msg_from_server,":")
	if arr_str[1] == "0" # receive seed
		server_wincode_is_zero(msg_from_server,file_user)
	elseif arr_str[1] == "2" # means server sends back move, update db
		server_wincode_is_two(msg_from_server,file_user)
	elseif arr_str[1] == "e"
		println(msg_from_server)
	else
		println("Message from server is not valid.")
	end
end

function server_wincode_is_zero(msg_from_server,file_user)
#<0>:<filename>:<seed>:<Request accepted. Here's your seed.>
	#Convert string to an array of strings
	println(msg_from_server)
	arr_str = split(msg_from_server,":")
	assert(length(arr_str) == 4)
	println(arr_str)
	file_server = ASCIIString(arr_str[2])

	if file_server == file_user
		seed = parse(arr_str[3])
		println("seed from server is: ",seed)
		set_seed(file_user,seed)
		println("I finshed setting seed.")
		println("Finish game request.")
	elseif file_server != file_user
		println("Server sent seed from the wrong file.")
	else
		println("Invalid seed accept form server.")
	end
end

function server_wincode_is_two(msg_from_server,file_user) # means server sends back move, update db
	arr_str = split(msg_from_server,":")
	assert(length(arr_str) == 15)
#"<wincode = 2>:<filename>:<movenum:<movetype>:<sourcex>:<sourcey>:<targetx>:<targety>:<option>:<cheating>:<
#targetx2>:<targety2><targetx3:targety3>"
	file_server = ASCIIString(arr_str[2])
	if file_server == file_user
		#Parse string to insert into database
		parse_moveMsg_update_gamefile(msg_from_server,file_user)
		println("User gamefile update complete after making and getting a move from server.")
	elseif file_server != file_user
		println("Server sent move from the wrong file.")
	else
		println("Invalid move message from server.")
	end
end
