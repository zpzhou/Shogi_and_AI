#include("networking.jl")
port=2002

# global player1 = serverPlayer(1)
# global player2 = serverPlayer(2)

#server = listen(port)
try
  server = listen(port)

  # red = Pieces()
  # black = Pieces()
  # julia = MonteCarlo(black,red)
  while true
    let
      sock = accept(server)
      @async begin
        try
          i = 0
          while isopen(sock)
            i = i + 1
            println(i,".Received a connection.Waiting for message:")
            line = chomp(readline(sock))
            println(i,".Client says: ",line)
            if line == "0"
              include("AI.jl")
              #serverPlayer1.code = gen_authString()
              println(sock,"You request a game.")
            elseif line == "3"
              println(sock,"you accuse opponent of cheating")
            else
              println(sock,"Not a valid command. Try again.")
            end
          end #while
        catch err
          println("connection ended with error $err")
        end #try
    end #@async begin
      end #let
end #while
catch err1 # my fix
  println("connection ended with error $err")
end #try
