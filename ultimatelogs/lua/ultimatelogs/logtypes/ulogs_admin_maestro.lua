--[[
    
     _   _  _  _    _                    _           _                        
    | | | || || |  (_)                  | |         | |                       
    | | | || || |_  _  _ __ ___    __ _ | |_   ___  | |      ___    __ _  ___ 
    | | | || || __|| || '_ ` _ \  / _` || __| / _ \ | |     / _ \  / _` |/ __|
    | |_| || || |_ | || | | | | || (_| || |_ |  __/ | |____| (_) || (_| |\__ \
     \___/ |_| \__||_||_| |_| |_| \__,_| \__| \___| \_____/ \___/  \__, ||___/
                                                                    __/ |     
                                                                   |___/      
    
    
]]--





local INDEX = 28
local GM = 5

ULogs.AddLogType( INDEX, GM, "Maestro", function( Cmd, Args, Player )
	
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Cmd then return end
	if !Args then Args = {} end
	if !Args[ 1 ] then Args[ 1 ] = {} end
	
	local Informations = {}
	local Base = ULogs.RegisterBase( Player )
	table.insert( Informations, { "Copy command", Cmd } )
	local Data = {}
	Data[ 1 ] = " Admin " .. Player:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	if #Args[ 1 ] > 0 then
		local Data2 = {}
		Data2[ 1 ] = "Details"
		Data2[ 2 ] = {}
		Data3 = {}
		for k, v in pairs( Args[ 1 ] ) do
			local s = ""
			if type( v ) == "Player" then
				s = v:Nick()
			elseif type( v ) == "string" then
				s = v
			end
			table.insert( Data3, { "Argument " .. k .. " : " .. s, s } )
		end
		table.Add( Data2[ 2 ], Data3 )
		table.insert( Informations, Data2 )
	end
	
	return Informations
	
end)

hook.Add( "maestro_command", "ULogs_maestro_command", function( Player, Cmd, Args )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Cmd then return end
	local ArgsString = ""
	
	if Args and Args[ 1 ] then
		for k, v in pairs( Args[ 1 ] ) do
			local s = ""
			if type( v ) == "Player" then
				s = ULogs.PlayerInfo( v )
			elseif type( v ) == "string" then
				s = v
			end
			
			ArgsString = ArgsString .. " " .. s
		end
	end
	
	
	ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " used maestro command '" .. Cmd .. ArgsString .. "'",
		ULogs.Register( INDEX, Cmd, Args, Player ) )
	
end)




