include("networking.jl")


# <"0"=request game>:<filename>:<standard shogi>: <no cheating>: <time_limit>: <time_add>
function request_game_AIplayer_AIserver(ip::ASCIIString,port::Int,filename::ASCIIString,gametype::ASCIIString,cheat::Int,time_limit::Int,time_add::Int)
	# Check connection error
	try
		global clientside = connect(ip,port)
	catch err
		println("No connection, error is $err")
	end
	# Send request to server
	println("i got here")
	msg_to_server = string("0",":",filename,":",gametype,":",cheat,":",time_limit,":",time_add)
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
		# If not returns is string: "e:2 players are already in the game."
		result = process_msg_from_server(msg_from_server,filename) #empty string bc we don't have a gamefile yet
	end #if
	close(clientside)
	return result
end


#TEST
# ipaddr= "127.0.0.1"
# port = 2002
# code =	request_game_AIplayer_AIserver(ipaddr,port,"game","T",1,300,20)
# # println("Authcode for net user is: ",code)
