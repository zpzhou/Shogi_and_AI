include("database.jl")

# start.jl <filename> <type> <cheating> <limit> <limit_add> will set up a game file.
function set_database(filename::ASCIIString,gametype::ASCIIString,cheating::Int,limit::Int,limit_add::Int)

        #create database
        init_database(filename)
        #set game type
        if gametype == "S"
            set_gameType(filename,"standard")
        elseif gametype == "M"
            set_gameType(filename,"minishogi")
        elseif gametype == "C"
            set_gameType(filename,"chu")
        elseif gametype == "T"
            set_gameType(filename,"ten")
        else
            set_gameType(filename,gametype)
        end
        #set if cheating allow or not
        cheating == 0 ? set_legality(filename,"legal") : set_legality(filename,"cheating")

        # set time limit and limit add
        if limit == 0
            set_isTimed(filename,"no")
            set_timeAdd(filename,0)
        else
            set_isTimed(filename,"yes")
            set_senteTime(filename,limit)
            set_goteTime(filename,limit)
            set_timeAdd(filename,limit_add)
        end

        # set seed for AI
        # generate start of unix epoch
        const UNIXEPOCH = DateTime(1970)
        # takes current date time and returns number of seconds since unix epoch
        datetime2unix(dt::DateTime) = (dt - UNIXEPOCH)/1000
        # generate current unix time for seed
        seed = Int(datetime2unix(now()))
        set_seed(filename,seed)

        # print tables
        # table_meta = get_table(filename,"meta")
        # table_moves = get_table(filename,"moves")
        # println(table_meta)
        # println(table_moves)
    end