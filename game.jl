Pkg.add("Images")
Pkg.add("ImageView")
Pkg.add("Tk")
Pkg.add("Cairo")
Pkg.add("Graphics")
Pkg.add("SQLite")
Pkg.add("DataFrames")

using Tk
using Graphics
using Cairo
using Images
using ImageView


start_window = Toplevel("Shogi", 650, 650)
pack_stop_propagate(start_window)
# pepe = Tk.Image("evilkermit.gif")
pepe = Tk.Image("shogi_game_start.gif")
f = Frame(start_window, width = 650, height = 650); pack(f, expand = true, fill = "both")
l = Label(f, pepe)
pack(l, side="left")

initial_option = "blank"
gamename = "newgame"
variant = "Standard Shogi"
difficulty = "Normal"
ai_cheat = false
first_player = "Player 1"
time_limit = -1
time_increment = 0
flip_table = "No"
port = 0
ip = ""


mb = Menu(start_window)            ## makes menu, adds to top-level window
fmenu = menu_add(mb, "File")

menu_add(fmenu, "Start a new game", (path) -> new_game_options())
menu_add(fmenu, "Continue an old game", (path) -> continue_game_options())
menu_add(fmenu, "Replay a finished game", (path) -> replay_game())
menu_add(fmenu, "Quit", (path) -> destroy(w))

cb = Checkbutton(start_window, "Something visible")
set_value(cb, true)     ## initialize
pack_stop_propagate(start_window)
tcl("ttk::style", "configure", "TButton", activebackground = "red", background = "black", foreground = "blue")


#-----------------------------------------------------------------------------------



function new_gamename_input()
	global initial_option = "Start a new game"
	input_window = Toplevel("Please name your new game file", 300, 100)
	pack_stop_propagate(input_window)
	input_frame = Frame(input_window, width = 300, height = 100)
	pack_stop_propagate(input_frame)
	pack(input_frame, expand = true, fill = "both")
	gamename_input = Entry(input_frame)
	formlayout(gamename_input, "Name of the gamefile")
	focus(gamename_input)
	b = Button(input_frame, "Ok")
	formlayout(b, nothing)
	bind(b, "command") do path
		global gamename = get_value(gamename_input)
		if length(gamename) > 0
			#msg = "Name of gamefile is $(gamename)"
			#Messagebox(input_window, msg)
			destroy(input_window)
		else
			global gamename = "newgame"
			msg = "Please enter a name for the gamefile"
			Messagebox(input_window, msg)
		end
	end
end


function new_game_options()
	newgame_choices = ["Start a game against the AI",
	                  "Start a game against a human on the same computer",
	                  "Join a game against a remote program",
	                  "Host a game, using your AI as the player",
	                  "Host a game with a human as the player",
	                  "Start a new game over email"]
	start_new_game_window = Toplevel("Start a new game: Options", 400, 300)
	tcl("pack", "propagate", start_new_game_window, false)
	start_new_game_frame = Frame(start_new_game_window, padding = 15)
	pack(start_new_game_frame, expand=true, fill="both")

	f1 = Frame(start_new_game_frame)          ## need internal frame for use with scrollbars
	lb = Treeview(f1, newgame_choices)
	scrollbars_add(f1, lb)
	pack(f1,  expand=true, fill="both")

	b = Button(start_new_game_frame, "Ok")
	pack(b, side = "left")
  b2 = Button(start_new_game_frame, "Cancel")
  pack(b2, side = "right")

  bind(b2, "command") do path
    destroy(start_new_game_window)
  end

	bind(b, "command") do path  ## do style
	     choice = get_value(lb)

       setting_input = "none"
       if choice[1] == "Start a game against the AI"
         setting_input = "User vs AI"
       elseif choice[1] == "Start a game against a human on the same computer"
         setting_input = "User vs Human"
       elseif choice[1] == "Join a game against a remote program"
         setting_input = "User vs Remote"
       elseif choice[1] == "Host a game, using your AI as the player"
         setting_input = "Host AI"
       elseif choice[1] == "Host a game with a human as the player"
         setting_input = "Host Human"
       elseif choice[1] == "Start a new game over email"
         setting_input = "Email"
       end
	     #msg = (fruit_choice == nothing) ? "What, no choice?" : "$(choice[1])"
	     #Messagebox(start_new_game_window,  msg)
			 if length(setting_input) > 0
				 destroy(start_new_game_window)
				 game_settings(setting_input)
			 else
				 msg = "Please select a choice"
				 Messagebox(start_new_game_window, msg)
			 end
	end
end

function game_settings(si::ASCIIString)

  game_setting_window = Toplevel("Game Settings", 400, 300)
  pack_stop_propagate(game_setting_window)


  if si == "User vs AI" || si == "Host AI"

		global first_player = "AI"
		new_gamename_input()

		if si == "Host AI"
			global initial_option = "Start a new game"
			input_window = Toplevel("Please enter the port number", 250, 100)
			pack_stop_propagate(input_window)
			input_frame = Frame(input_window, width = 250, height = 100)
			pack_stop_propagate(input_frame)
			pack(input_frame, expand = true, fill = "both")
			port_input = Entry(input_frame)
			formlayout(port_input, "Port Number")
			focus(port_input)
			b = Button(input_frame, "Ok")
			formlayout(b, nothing)
			bind(b, "command") do path
				global port = get_value(port_input)
				if length(port) > 0
					#msg = "Port number is $(port)"
					#Messagebox(input_window, msg)
					destroy(input_window)
				else
					msg = "Please enter value for Port Number"
					Messagebox(input_window, msg)
				end
			end
		end

    game_setting_frame1 = Frame(game_setting_window, padding = 2, width = 100, height = 75)
    pack_stop_propagate(game_setting_frame1); grid(game_setting_frame1, 1, 1)
    game_setting_frame2 = Frame(game_setting_window, padding = 2, width = 100, height = 75)
    pack_stop_propagate(game_setting_frame2); grid(game_setting_frame2, 1, 2)
    game_setting_frame3 = Frame(game_setting_window, padding = 2, width = 100, height = 75)
    pack_stop_propagate(game_setting_frame3); grid(game_setting_frame3, 1, 3)
    game_setting_frame4 = Frame(game_setting_window, padding = 2, width = 100, height = 75)
    pack_stop_propagate(game_setting_frame4); grid(game_setting_frame4, 1, 4)
    game_setting_frame5 = Frame(game_setting_window, padding = 2, width =  100, height = 75)
    pack_stop_propagate(game_setting_frame5); grid(game_setting_frame5, 1, 5)
    option_frame = Frame(game_setting_window, padding = 4, width = 500, height = 300)
    pack_stop_propagate(option_frame); grid(option_frame, 2, 1:5)
    confirm_frame = Frame(game_setting_window, padding = 4, width = 500, height = 50)
    pack_stop_propagate(confirm_frame); grid(confirm_frame, 3, 1:5)


    confirmb = Button(confirm_frame, "Start Game")
    bind(confirmb, "command") do path
			destroy(game_setting_window)
			destroy(start_window)
			if si == "User vs AI"
      	     include("gui_ai.jl")
			elseif si == "Host AI"
				include("set_database.jl")
				settings = "$(variant),$(gamename),$(difficulty),$(port)"
				set_database("options", settings, 0, time_limit, time_increment)

				demo = Toplevel("Do this", 560, 500)
				pack_stop_propagate(demo)
				demoframe = Frame(demo, width = 560, height = 500)
				pack_stop_propagate(demoframe)
				pack(demoframe, expand = true, fill = "both")
				guiserver = Tk.Image("guiserverai.gif")
				guiserverinstructions = Tk.Image("guiserveraiinstructions.gif")
				l1 = Label(demoframe, guiserver)
				pack(l1)
				l2 = Label(demoframe, guiserverinstructions)
				pack(l2, side = "bottom")
			end
    end
    pack(confirmb, expand = true, fill = "both")


    variantb = Button(game_setting_frame1, "Variant")
    bind(variantb, "command") do path
      option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
      pack_stop_propagate(option_frame); grid(option_frame, 2, 1:5)
      variant_choices = ["Standard Shogi", "Mini Shogi", "Chu Shogi", "Tenjiku Shogi"]
      variant_options = Treeview(option_frame, variant_choices)
      scrollbars_add(option_frame, variant_options)
      b = Button(option_frame, "Ok")
      pack(b, side = "bottom")
      bind(b, "command") do path  ## do style
        variant_choice2 = get_value(variant_options)
        global variant = variant_choice2[1]
				if length(variant) > 0
					option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
					pack_stop_propagate(option_frame); grid(option_frame, 2, 1:5)
				else
					global variant = "Standard Shogi"
					Messagebox(game_setting_window, "Nothing selected")
				end
      end
    end
    pack(variantb, expand = true, fill = "both")


    time_settingsb = Button(game_setting_frame2, "Time Settings")
    bind(time_settingsb, "command") do path
      option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
      pack_stop_propagate(option_frame); grid(option_frame, 2, 1:5)
      time_choices = ["Use Time Settings", "Don't Use Time Settings"]
      time_options = Treeview(option_frame, time_choices)
      scrollbars_add(option_frame, time_options)
      b = Button(option_frame, "Ok")
      pack(b, side = "bottom")
      bind(b, "command") do path
        option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
        pack_stop_propagate(option_frame); grid(option_frame, 2, 1:5)
        use_time_limit = get_value(time_options)

        if use_time_limit[1] == "Use Time Settings"
          time_entry = ["Time Limit", "Time Increment"]
          time_entry_options = Treeview(option_frame, time_entry)
          scrollbars_add(option_frame, time_entry_options)
          b = Button(option_frame, "Ok")
          pack(b, side = "bottom")
          bind(b, "command") do path
            time_entry_options2 = get_value(time_entry_options)

            if time_entry_options2[1] == "Time Limit"
              input_window = Toplevel("Time Limit", 400, 300)
              pack_stop_propagate(input_window)
              input_frame = Frame(input_window, width = 400, height = 300)
              pack_stop_propagate(input_frame)
              pack(input_frame, expand = true, fill = "both")
              time_limit_input = Entry(input_frame)
              formlayout(time_limit_input, "Time Limit")
              focus(time_limit_input)
              b = Button(input_frame, "Ok")
              formlayout(b, nothing)
              bind(b, "command") do path
                global time_limit = get_value(time_limit_input)
								if length(time_limit) > 0
									destroy(input_window)
								else
									global time_limit = -1
									msg = "Please enter value for Time Limit"
									Messagebox(input_window, msg)
								end
              end

            elseif time_entry_options2[1] == "Time Increment"
              input_window = Toplevel("Time Increment", 400, 300)
              pack_stop_propagate(input_window)
              input_frame = Frame(input_window, width = 400, height = 300)
              pack_stop_propagate(input_frame)
              pack(input_frame, expand = true, fill = "both")
              time_increment_input = Entry(input_frame)
              formlayout(time_increment_input, "Time Increment")
              focus(time_increment_input)
              b = Button(input_frame, "Ok")
              formlayout(b, nothing)
              bind(b, "command") do path
                global time_increment = get_value(time_increment_input)
								if length(time_increment) > 0
									destroy(input_window)
								else
									global time_increment = 0
									msg = "Please enter value for Time Increment"
									Messagebox(input_window, msg)
								end
              end
            end
          end
        end
      end
    end
    pack(time_settingsb, expand = true, fill = "both")


    difficultyb = Button(game_setting_frame3, "Difficulty")
    bind(difficultyb, "command") do path
      option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
      pack_stop_propagate(option_frame); grid(option_frame, 2, 1:5)
      difficulty_choices = ["Normal", "Hard", "Suicidal", "Protracted Death", "Random AI", "Hardcore"]
      difficulty_options = Treeview(option_frame, difficulty_choices)
      scrollbars_add(option_frame, difficulty_options)
      b = Button(option_frame, "Ok")
      pack(b, side = "bottom")
      bind(b, "command") do path  ## do style
        difficulty_choice2 = get_value(difficulty_options)
				global difficulty = difficulty_choice2[1]
				if length(difficulty) > 0
					option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
					pack_stop_propagate(option_frame); grid(option_frame, 2, 1:5)
				else
					global difficulty = "Normal"
					msg = "Please select a difficulty"
					Messagebox(input_window, msg)
				end
      end
    end
    pack(difficultyb, expand = true, fill = "both")


    go_firstb = Button(game_setting_frame4, "Who Starts?")
    bind(go_firstb, "command") do path
      option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
      pack_stop_propagate(option_frame); grid(option_frame, 2, 1:5)
      start_choices = ["AI", "Player"]
      start_options = Treeview(option_frame, start_choices)
      scrollbars_add(option_frame, start_options)
      b = Button(option_frame, "Ok")
      pack(b, side = "bottom")
      bind(b, "command") do path  ## do style
        start_choice2 = get_value(start_options)
        global first_player = start_choice2[1]
				if length(start_choice2[1]) > 0
					option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
					pack_stop_propagate(option_frame); grid(option_frame, 2, 1:5)
				else
					global first_player = "AI"
					Messagebox(input_window, "Please select who goes first")
				end
        option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
        pack_stop_propagate(option_frame); grid(option_frame, 2, 1:5)
      end
    end
    pack(go_firstb, expand = true, fill = "both")

    flip_tableb = Button(game_setting_frame5, "Roullete")
    bind(flip_tableb, "command") do path
      option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
      pack_stop_propagate(option_frame); grid(option_frame, 2, 1:5)
      choices = ["Yes", "No"]
      options = Treeview(option_frame, choices)
      scrollbars_add(option_frame, options)
      b = Button(option_frame, "Ok")
      pack(b, side = "bottom")
      bind(b, "command") do path  ## do style
        choice = get_value(options)
        global flip_table = choice[1]
                if length(choice[1]) > 0
                    option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
                    pack_stop_propagate(option_frame); grid(option_frame, 2, 1:5)
                else
                    global flip_table = "No"
                    Messagebox(input_window, "Please select an option")
                end
        option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
        pack_stop_propagate(option_frame); grid(option_frame, 2, 1:5)
      end
    end
    pack(flip_tableb, expand = true, fill = "both")


  elseif si == "User vs Human" || si == "Email" || si == "Host Human" || si == "User vs Remote"

		new_gamename_input()

		if si == "Host Human"
			global initial_option = "Start a new game"
			input_window = Toplevel("Please enter the port number", 250, 100)
			pack_stop_propagate(input_window)
			input_frame = Frame(input_window, width = 250, height = 100)
			pack_stop_propagate(input_frame)
			pack(input_frame, expand = true, fill = "both")
			port_input = Entry(input_frame)
			formlayout(port_input, "Port Number")
			focus(port_input)
			b = Button(input_frame, "Ok")
			formlayout(b, nothing)
			bind(b, "command") do path
				global port = get_value(port_input)
				if length(port) > 0
					#msg = "Port number is $(port)"
					#Messagebox(input_window, msg)
					destroy(input_window)
				else
					msg = "Please enter value for Port Number"
					Messagebox(input_window, msg)
				end
			end

		elseif si == "User vs Remote"
			input_window = Toplevel("Please enter the IP address and port number", 250, 100)
			pack_stop_propagate(input_window)
			input_frame = Frame(input_window, width = 250, height = 100)
			pack_stop_propagate(input_frame)
			pack(input_frame, expand = true, fill = "both")
			ip_input = Entry(input_frame)
			formlayout(ip_input, "IP Address")
			port_input = Entry(input_frame)
			formlayout(port_input, "Port Number")
			focus(ip_input)
			b = Button(input_frame, "Ok")
			formlayout(b, nothing)
			bind(b, "command") do path
				global port = get_value(port_input)
				global ip = get_value(ip_input)
				if length(port) > 0 && length(ip) > 0 && length(ip) < 16
					#msg = "IP address is $(ip) and Port number is $(port)"
					#Messagebox(input_window, msg)
					destroy(input_window)
				else
					global port = 0
					global ip = ""
					msg = "Please enter value for IP Address and Port Number"
					Messagebox(input_window, msg)
				end
			end
		end


    game_setting_frame1 = Frame(game_setting_window, padding = 2, width = 100, height = 100)
    pack_stop_propagate(game_setting_frame1); grid(game_setting_frame1, 1, 1)
    game_setting_frame2 = Frame(game_setting_window, padding = 2, width = 100, height = 100)
    pack_stop_propagate(game_setting_frame2); grid(game_setting_frame2, 1, 2)
    game_setting_frame3 = Frame(game_setting_window, padding = 2, width = 100, height = 100)
    pack_stop_propagate(game_setting_frame3); grid(game_setting_frame3, 1, 3)
    game_setting_frame4 = Frame(game_setting_window, padding = 2, width =  100, height = 100)
    pack_stop_propagate(game_setting_frame4); grid(game_setting_frame4, 1, 4)
    option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
    pack_stop_propagate(option_frame); grid(option_frame, 2, 1:4)
    confirm_frame = Frame(game_setting_window, padding = 4, width = 400, height = 50)
    pack_stop_propagate(confirm_frame); grid(confirm_frame, 3, 1:4)

    confirmb = Button(confirm_frame, "Start Game")
    bind(confirmb, "command") do path
			destroy(game_setting_window)
			destroy(start_window)
			if si == "User vs Human" || si == "Email"
				include("gui.jl")
			elseif si == "Host Human"
				include("set_database.jl")
				settings = "$(variant),$(gamename),$(port)"
				set_database("options", setting, 0, time_limit, time_increment)

				demo = Toplevel("Do this", 560, 500)
				pack_stop_propagate(demo)
				demoframe = Frame(demo, width = 560, height = 500)
				pack_stop_propagate(demoframe)
				pack(demoframe, expand = true, fill = "both")
				guiserver = Tk.Image("guiserver.gif")
				guiserverinstructions = Tk.Image("guiserverinstructions.gif")
				l1 = Label(demoframe, guiserver)
				pack(l1)
				l2 = Label(demoframe, guiserverinstructions)
				pack(l2, side = "bottom")

			elseif si == "User vs Remote"
				include("client_setup.jl")
				include("gui_client.jl")
			end
    end
    pack(confirmb, expand = true, fill = "both")

    variantb = Button(game_setting_frame1, "Variant")
    bind(variantb, "command") do path
      option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
      pack_stop_propagate(option_frame); grid(option_frame, 2, 1:4)
      variant_choices = ["Standard Shogi", "Mini Shogi", "Chu Shogi", "Tenjiku Shogi"]
      variant_options = Treeview(option_frame, variant_choices)
      scrollbars_add(option_frame, variant_options)
      b = Button(option_frame, "Ok")
      pack(b, side = "bottom")
      bind(b, "command") do path  ## do style
        variant_choice2 = get_value(variant_options)
        global variant = variant_choice2[1]
				if length(variant) > 0
					option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
					pack_stop_propagate(option_frame); grid(option_frame, 2, 1:4)
				else
					global variant = "Standard Shogi"
					Messagebox(game_setting_window, "Nothing selected")
				end
        option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
        pack_stop_propagate(option_frame); grid(option_frame, 2, 1:4)
      end
    end
    pack(variantb, expand = true, fill = "both")


    time_settingsb = Button(game_setting_frame2, "Time Settings")
    bind(time_settingsb, "command") do path
      option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
      pack_stop_propagate(option_frame); grid(option_frame, 2, 1:4)
      time_choices = ["Use Time Settings", "Don't Use Time Settings"]
      time_options = Treeview(option_frame, time_choices)
      scrollbars_add(option_frame, time_options)
      b = Button(option_frame, "Ok")
      pack(b, side = "bottom")
      bind(b, "command") do path
        option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
        pack_stop_propagate(option_frame); grid(option_frame, 2, 1:4)
        use_time_limit = get_value(time_options)

        if use_time_limit[1] == "Use Time Settings"
          time_entry = ["Time Limit", "Time Increment"]
          time_entry_options = Treeview(option_frame, time_entry)
          scrollbars_add(option_frame, time_entry_options)
          b = Button(option_frame, "Ok")
          pack(b, side = "bottom")
          bind(b, "command") do path
            time_entry_options2 = get_value(time_entry_options)

						if time_entry_options2[1] == "Time Limit"
              input_window = Toplevel("Time Limit", 400, 300)
              pack_stop_propagate(input_window)
              input_frame = Frame(input_window, width = 400, height = 300)
              pack_stop_propagate(input_frame)
              pack(input_frame, expand = true, fill = "both")
              time_limit_input = Entry(input_frame)
              formlayout(time_limit_input, "Time Limit")
              focus(time_limit_input)
              b = Button(input_frame, "Ok")
              formlayout(b, nothing)
              bind(b, "command") do path
                global time_limit = get_value(time_limit_input)
								if length(time_limit) > 0
									destroy(input_window)
								else
									global time_limit = -1
									msg = "Please enter value for Time Limit"
									Messagebox(input_window, msg)
								end
              end

            elseif time_entry_options2[1] == "Time Increment"
              input_window = Toplevel("Time Increment", 400, 300)
              pack_stop_propagate(input_window)
              input_frame = Frame(input_window, width = 400, height = 300)
              pack_stop_propagate(input_frame)
              pack(input_frame, expand = true, fill = "both")
              time_increment_input = Entry(input_frame)
              formlayout(time_increment_input, "Time Increment")
              focus(time_increment_input)
              b = Button(input_frame, "Ok")
              formlayout(b, nothing)
              bind(b, "command") do path
                global time_increment = get_value(time_increment_input)
								if length(time_increment) > 0
									destroy(input_window)
								else
									global time_increment = 0
									msg = "Please enter value for Time Increment"
									Messagebox(input_window, msg)
								end
              end
            end
          end
        end
      end
    end
    pack(time_settingsb, expand = true, fill = "both")


    go_firstb = Button(game_setting_frame3, "Who Starts?")
    bind(go_firstb, "command") do path
      option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
      pack_stop_propagate(option_frame); grid(option_frame, 2, 1:4)
      start_choices = ["Player 1", "Player 2"]
      start_options = Treeview(option_frame, start_choices)
      scrollbars_add(option_frame, start_options)
      b = Button(option_frame, "Ok")
      pack(b, side = "bottom")
      bind(b, "command") do path  ## do style
        start_choice2 = get_value(start_options)
        # msg = (start_choice2 == nothing) ? "Nothing selected" : "$(start_choice2[1]) Starts First"
        # Messagebox(game_setting_window, msg)

        if start_choice2[1] == nothing
          Messagebox(game_setting_window, "Nothing selected")
        end

        if start_choice2[1] == "Player 2"
          global first_player = "Player 2"
        end
        option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
        pack_stop_propagate(option_frame); grid(option_frame, 2, 1:4)
      end
    end
    pack(go_firstb, expand = true, fill = "both")

    flip_tableb = Button(game_setting_frame4, "Roullete")
    bind(flip_tableb, "command") do path
      option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
      pack_stop_propagate(option_frame); grid(option_frame, 2, 1:4)
      choices = ["Yes", "No"]
      start_options = Treeview(option_frame, choices)
      scrollbars_add(option_frame, start_options)
      b = Button(option_frame, "Ok")
      pack(b, side = "bottom")
      bind(b, "command") do path  ## do style
        choice = get_value(start_options)
        global flip_table = choice[1]
                if length(choice[1]) > 0
                    option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
                    pack_stop_propagate(option_frame); grid(option_frame, 2, 1:4)
                else
                    global flip_table = "No"
                    Messagebox(input_window, "Please select an option")
                end
        option_frame = Frame(game_setting_window, padding = 4, width = 400, height = 300)
        pack_stop_propagate(option_frame); grid(option_frame, 2, 1:4)
      end
    end
    pack(flip_tableb, expand = true, fill = "both")
#=

  elseif si == "User vs Remote"
		global variant = "Standard Shogi"
		global time_limit = 300
		global initial_option = "Start a new game"
		global gamename = "nettest"
		ai_cheat = false
		global first_player = "human"
		global time_increment = 0
		destroy(game_setting_window)
		global initial_option = "Start a new game"
		input_window = Toplevel("Please enter the IP address and port number", 250, 100)
		pack_stop_propagate(input_window)
		input_frame = Frame(input_window, width = 250, height = 100)
		pack_stop_propagate(input_frame)
		pack(input_frame, expand = true, fill = "both")
		ip_input = Entry(input_frame)
		formlayout(ip_input, "IP Address")
		port_input = Entry(input_frame)
		formlayout(port_input, "Port Number")
		focus(ip_input)
		b = Button(input_frame, "Ok")
		formlayout(b, nothing)
		bind(b, "command") do path
			global port = parse(get_value(port_input))
			global ip = get_value(ip_input)
			if length(port) > 0 && length(ip) > 0 && length(ip) < 16
				msg = "IP address is $(ip) and Port number is $(port)"
				Messagebox(input_window, msg)
				destroy(input_window)
				include("client_setup.jl")
				include("gui_client.jl")
			else
				msg = "Please enter value for IP Address and Port Number"
				Messagebox(input_window, msg)
			end
		end
  end

	=#
end
end


function continue_game_options()
	global initial_option = "Continue an old game"
  continue_game_choices = ["Continue a local game", "Take a turn in an email game"]
	continue_game_window = Toplevel("Continue an old game: Options", 400, 300)
	tcl("pack", "propagate", continue_game_window, false)
	continue_game_frame = Frame(continue_game_window, padding = 15)
	pack(continue_game_frame, expand=true, fill="both")

	f1 = Frame(continue_game_frame)          ## need internal frame for use with scrollbars
	lb = Treeview(f1, continue_game_choices)
	scrollbars_add(f1, lb)
	pack(f1,  expand=true, fill="both")

	b = Button(continue_game_frame, "Ok")
	pack(b, side = "left")
  b2 = Button(continue_game_frame, "Cancel")
  pack(b2, side = "right")

  bind(b2, "command") do path
    destroy(continue_game_window)
  end

	bind(b, "command") do path  ## do style
	   choice = get_value(lb)

		 if choice[1] == "Continue a local game"
			 global initial_option = "Continue an old game"
			 input_window = Toplevel("Please name your new game file", 400, 300)
			 pack_stop_propagate(input_window)
			 input_frame = Frame(input_window, width = 400, height = 300)
			 pack_stop_propagate(input_frame)
			 pack(input_frame, expand = true, fill = "both")
			 gamename_input = Entry(input_frame)
			 formlayout(gamename_input, "Name of the gamefile")
			 focus(gamename_input)
			 b = Button(input_frame, "Ok")
			 formlayout(b, nothing)
			 bind(b, "command") do path
				 global gamename = get_value(gamename_input)
				 if length(gamename) > 0
		 			destroy(input_window)
		 			include("gui.jl")
		 		 else
		 			global gamename = "newgame"
		 			Messagebox(input_window, "Please enter the name of gamefile")
			   end
			 end

			elseif choice[1] == "Take a turn in an email game"
			 global initial_option = "Continue an old game"
 			 input_window = Toplevel("Please name your new game file", 400, 300)
 			 pack_stop_propagate(input_window)
 			 input_frame = Frame(input_window, width = 400, height = 300)
 			 pack_stop_propagate(input_frame)
 			 pack(input_frame, expand = true, fill = "both")
 			 gamename_input = Entry(input_frame)
 			 formlayout(gamename_input, "Name of the gamefile")
 			 focus(gamename_input)
 			 b = Button(input_frame, "Ok")
 			 formlayout(b, nothing)
 			 bind(b, "command") do path
 				 global gamename = get_value(gamename_input)
 				 if length(gamename) > 0
 		 			destroy(input_window)
 		 			include("gui.jl")
 		 		 else
 		 			global gamename = "newgame"
 		 			Messagebox(input_window, "Please enter the name of gamefile")
 			   end
			 end
		 end
	end
end


function replay_game()
	global initial_option = "Replay a finished game"
	input_window = Toplevel("Please enter the name of the game file you wish to replay", 400, 300)
	pack_stop_propagate(input_window)
	input_frame = Frame(input_window, width = 400, height = 300)
	pack_stop_propagate(input_frame)
	pack(input_frame, expand = true, fill = "both")
	gamename_input = Entry(input_frame)
	formlayout(gamename_input, "Name of the gamefile")
	focus(gamename_input)
	b = Button(input_frame, "Ok")
	formlayout(b, nothing)
	bind(b, "command") do path
		global gamename = get_value(gamename_input)
		if length(gamename) > 0
			destroy(input_window)
			include("gui.jl")
		else
			global gamename = "newgame"
			Messagebox(input_window, "Please enter the name of gamefile")
		end
	end
end
