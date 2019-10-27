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





local INDEX = 27
local GM = 5

ULogs.AddLogType( INDEX, GM, "FAdmin", function( Cmd, Player, Targets )
	
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Cmd then return end
	
	local Informations = {}
	local Base = ULogs.RegisterBase( Player )
	table.insert( Informations, { "Copy command", Cmd } )
	local Data = {}
	Data[ 1 ] = " Admin " .. Player:Name()
	Data[ 2 ] = {}
	table.Add( Data[ 2 ], Base )
	table.insert( Informations, Data )
	
	for k, v in pairs( Targets ) do
		
		if v and v:IsValid() and v:IsPlayer() and v != Player then
		
			local Base2 = ULogs.RegisterBase( v )
			local Data2 = {}
			Data2[ 1 ] = " Target " .. v:Name()
			Data2[ 2 ] = {}
			table.Add( Data2[ 2 ], Base2 )
			table.insert( Informations, Data2 )
		
		end
		
	end
	
	return Informations
	
end)

hook.Add( "FAdmin_OnCommandExecuted", "ULogs_FAdmin_OnCommandExecuted", function( Player, Cmd, Args, Res )
	
	if !SERVER then return end
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return end
	if !Cmd then return end
	local Targets = {}
	
	if Res and Res[ 2 ] and type(Res[ 2 ] ) == "table" then
		
		for k, v in pairs( Res[ 2 ] ) do
			
			if v and v:IsValid() and v:IsPlayer() then
				
				table.insert( Targets, v )
				
			end
			
		end
		local TargetsString = ""
		if #Targets > 1 then
			TargetsString = " on multiple targets"
		elseif #Targets == 1 and Targets[ 1 ] and Targets[ 1 ]:IsValid() and Targets[ 1 ]:IsPlayer() then
			if Targets[ 1 ] == Player then
				TargetsString = " on himself"
			else
				TargetsString = " on " .. ULogs.PlayerInfo( Targets[ 1 ] )
			end
		end
		
		ULogs.AddLog( INDEX, ULogs.PlayerInfo( Player ) .. " used FAdmin command '" .. Cmd .. "'" .. TargetsString,
			ULogs.Register( INDEX, Cmd, Player, Targets ) )
		
	end
end)




