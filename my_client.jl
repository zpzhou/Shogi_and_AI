port=2002
try
	global clientside = connect(port)
catch err
	println("No connection, error is $err")
end

function input()
	return chomp(readline())
end

#global msg_from_server
#global client_msg = ""
if isopen(clientside)
	@async while isopen(clientside)

		global msg_from_server = readline(clientside)
		println("In the async loop: ",nb_available(clientside))
		if msg_from_server == ""
			println("Server is not responding")
			close(clientside)
		else
			println("Server says back ",msg_from_server)
		end

		# catch err
		# 	println("connection ended with error $err")

	end

	#while nb_available(clientside) == 0
	#if nb_available(clientside) == 0
			#sleep(5) # give the server time to execute
			#println("Am I pretty yes or yes?")
			#client_msg = input()
			#println(clientside,client_msg)
			println("In the sending loop: ",nb_available(clientside))
			println(clientside,"0")
			#sleep(5)
			#println("Client receives from server: ",msg_from_server)
		#end
#else
end



# function process_message(server_msg)
# 	con = connect(2002)
# 	println(con, "hi")
# end
#=
global msg_from_server = ""

@async while isopen(clientside)

		println("Data from server : ",msg_from_server)
	  global msg_from_server = chomp(readline(clientside))
		if length(msg_from_server) != 0
			#process_message(msg_from_server)
			#msg_send_to_server = "asdf"
			#println(clientside,msg_send_to_server,"\n")
		end
		#readline(clientside)
end
=#
