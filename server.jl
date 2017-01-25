include("networking.jl")
include("database.jl")

function start_server(port::Int,filename::ASCIIString)

  try
    server = listen(port)
    while true
      let
        sock = accept(server)

        i = 0
          try

            while isopen(sock)
              i = i + 1
              println(i,".Received a connection.Waiting for message:")
              msg_from_user = chomp(readline(sock))

              println(i,".Client says: ", msg_from_user)

              msg_to_send_back = process_msg_from_user(msg_from_user,filename)
              println("Sending back to user: ",msg_to_send_back)

              println(sock,msg_to_send_back)

            end #while
          catch err1 #
            println("connection ended with error $err1")
          end #try

      end #let
    end #while
  catch err2
    println("connection ended with error $err2")
  end #try
end

# file = "test"
# start_server(port,file)
#TEST
# #set_database(filename::ASCIIString,gametype::ASCIIString,cheating::Int,limit::Int,limit_add::Int)
# set_database("game","S",0,200,3)
# port=2002
# start_server(port,"game")
