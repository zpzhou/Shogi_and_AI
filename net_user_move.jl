include("networking.jl")
include("database.jl")
#wincode = 2 = user is making a move
function move_user_server_game(ip::ASCIIString,port::Int,filename::ASCIIString)

# Check connection error
	try
		global clientside = connect(ip,port)
	catch err
		println("No connection, error is $err")
	end

	println("Filename is: ",filename)

	msg_to_server = extract_gamefile_form_moveMsg(filename)
	println("I'm sending to server this message: ",msg_to_server)
	println(clientside,msg_to_server)

	# Wait for server to respond
	msg_from_server = ""
	if isopen(clientside)
		while isopen(clientside)
			msg_from_server = readline(clientside)
			if msg_from_server == ""
				println("Server is not responding")
				close(clientside)
				break
			else
				println("Server says back: ",msg_from_server)
				break
			end #if
		end # while

		process_msg_from_server(msg_from_server,filename)
	end #if
	close(clientside)

end

# TEST
# ip = "127.0.0.1"
# port = 2002
# filename = "game"
# set_move(filename,"move",(1,2),(2,3),(3,4),(0,0),0,0,"")
# # move_user_server_game(ip,port,authCode,"move",(1,2),(2,3),(3,4),(0,0),0,0,"")
# move_user_server_game(ip,port,filename)
#
# println(get_table(filename,"moves"))
