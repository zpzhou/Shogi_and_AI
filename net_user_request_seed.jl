include("networking.jl")


# <"0"=request game>:<filename>:<standard shogi>: <no cheating>: <time_limit>: <time_add>
function request_seed_from_server(ip::ASCIIString,port::Int,filename::ASCIIString)
	# Check connection error
	try
		global clientside = connect(ip,port)
	catch err
		println("No connection, error is $err")
	end
	# Send request to server

	msg_to_server = string("0",":",filename,":","I'm requesting seed.")
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
		# Gets result, process the message and return authString if exists

		process_msg_from_server(msg_from_server,filename)
	end #if
	close(clientside)
end


#TEST
# set_database("game","S",0,200,3)
# ipaddr= "127.0.0.1"
# port = 2002
# request_seed_from_server(ipaddr,port,"game")
