ESX = nil
MedicConnected = 0
PoliceConnected = 0
PlayerOnline = 0
Mechanic = 0
CouncilConnected = 0
Kanok = 0
Buranaphon = 0
Prachachuen =  0
Indra = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('xscoreboard:server:getdata', function(source, cb)
    local iden = GetPlayerIdentifiers(source)[1]
	local _source        = source
	local xPlayer        = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @iden LIMIT 0,1', {
        ['@iden'] = iden
    -- MySQL.query('SELECT * FROM users WHERE identifier = @iden LIMIT 0,1', {
        ['@iden'] = iden
    }, function(result)
        if not (result[1] == nil) then
            local data = {}   
            local totol = {}
            local job_label = GetJobLabel(result[1].job, result[1].job_grade)     
            
        
            data =  {
                my_phonenmumber = result[1].phone_number,
                my_fullname = result[1].firstname.." "..result[1].lastname,
                my_job = ESX.GetPlayerFromId(source).job.grade_label,
                my_ping = GetPlayerPing(source),
                players = PlayerOnline, 
                MedicConnected = MedicConnected,
                PoliceConnected = PoliceConnected,
                PlayerOnline = PlayerOnline,
                CouncilConnected = CouncilConnected,
                Mechanic = Mechanic,
                Kanok = Kanok,
                Buranaphon = Buranaphon,
                Prachachuen = Prachachuen,
                Indra = Indra       
               
            }
            print(data.Buranaphon)

           
            cb(data)
        else
            cb(nil)
        end
    end)
end)

function GetJobLabel(job_name, job_grade)
    local result = MySQL.Sync.fetchAll('SELECT label FROM job_grades WHERE job_name = @job_name AND grade = @job_grade', {
        ['@job_name'] = job_name,
        ['@job_grade'] = job_grade
    })
    if not (result[1] == nil) then
        return result[1].label
    end
    return nil
end

AddEventHandler('esx:playerLoaded', function(source)
	local _source        = source
	local xPlayer        = ESX.GetPlayerFromId(_source)
	    if xPlayer.job.name == 'ambulance' then
            MedicConnected = MedicConnected +1
        elseif xPlayer.job.name == 'police' then
            PoliceConnected = PoliceConnected +1
            TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected)
        elseif xPlayer.job.name == 'gouvernment' then
            CouncilConnected = CouncilConnected +1
            TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected)
        elseif xPlayer.job.name == 'mechanic' then
            Mechanic = Mechanic +1
            TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected) 
        elseif xPlayer.job.name == 'kanok' then
            Kanok = Kanok +1
            TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok) 
        elseif xPlayer.job.name == 'buranaphon' then
            Buranaphon = Buranaphon +1
            TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok , Buranaphon) 
        elseif xPlayer.job.name == 'prachachuen' then
            Prachachuen = Prachachuen +1
            TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok, Prachachuen) 
        elseif xPlayer.job.name == 'indra' then
            Indra = Indra +1
            TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok, Indra) 
	    end
        PlayerOnline = PlayerOnline + 1 
        Wait(1000)
        TriggerClientEvent('playeronline', -1, PlayerOnline)   
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)    
    Wait(1000)
   --print('Lase Job '..lastJob.name)
   OnlinePlayer(playerId)
   --print(ESX.DumpTable(lastJob))
    if lastJob.name == "police" then
        PoliceConnected = PoliceConnected -1
        TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected) 
    elseif  lastJob.name == "ambulance" then
        MedicConnected = MedicConnected -1 
        TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected) 
    elseif  lastJob.name == "mechanic" then
        Mechanic = Mechanic - 1 
        TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected) 
    elseif lastJob.name == "gouvernment" then
        CouncilConnected = CouncilConnected - 1
        TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected) 
    elseif lastJob.name == "kanok" then
        Kanok = Kanok - 1
        TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok) 
    elseif lastJob.name == "buranaphon" then
        Buranaphon = Buranaphon -1
        TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok, Buranaphon) 
    elseif lastJob.name == "prachachuen" then
        Prachachuen = Prachachuen -1
        TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok, Prachachuen) 
    elseif lastJob.name == "indra" then
        Indra = Indra -1
        TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok, Indra) 
    end
   

        if ESX.GetPlayerFromId(playerId).job.name == "ambulance" then
            MedicConnected = MedicConnected +1
            TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected)
        elseif ESX.GetPlayerFromId(playerId).job.name == "police" then
            PoliceConnected = PoliceConnected +1
            TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected)
        elseif ESX.GetPlayerFromId(playerId).job.name == "mechanic" then
            Mechanic = Mechanic +1
            TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected)
        elseif ESX.GetPlayerFromId(playerId).job.name == 'gouvernment' then
            CouncilConnected = CouncilConnected +1
            TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected)
        elseif ESX.GetPlayerFromId(playerId).job.name == 'kanok' then
            Kanok = Kanok +1
            TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok)
        elseif ESX.GetPlayerFromId(playerId).job.name == 'buranaphon' then
            Buranaphon = Buranaphon +1
            TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok,Buranaphon)
        elseif ESX.GetPlayerFromId(playerId).job.name == 'prachachuen' then
            Prachachuen = Prachachuen +1
            TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok, Prachachuen)
        elseif ESX.GetPlayerFromId(playerId).job.name == 'indra' then
            Indra = Indra +1
            TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok, Indra)
        end
end)

function OnlinePlayer(ID)       
    TriggerClientEvent('profile', ID)
end

AddEventHandler('esx:playerDropped', function(source)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.job.name == "police" then
        PoliceConnected = PoliceConnected -1
        TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected) 
    elseif xPlayer.job.name == "ambulance" then
        MedicConnected = MedicConnected -1
        TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected) 
    elseif xPlayer.job.name == "mechanic" then
        Mechanic = Mechanic - 1
        TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected) 
    elseif xPlayer.job.name == "gouvernment" then
        CouncilConnected = CouncilConnected - 1
        TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected) 
    elseif xPlayer.job.name == "kanok" then
        Kanok = Kanok - 1
        TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok) 
    elseif xPlayer.job.name == "buranaphon" then
        Buranaphon = Buranaphon -1
        TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok,Buranaphon) 
    elseif xPlayer.job.name == "prachachuen" then
        Prachachuen = Prachachuen -1
        TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok,Prachachuen) 
    elseif xPlayer.job.name == "indra" then
        Indra = Indra -1
        TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok,Indra) 
    end
    PlayerOnline = PlayerOnline -1
    Wait(1000)
    TriggerClientEvent('playeronline', -1, PlayerOnline) 
end)


function CheckPlayerByBoseVps() 
	
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        --PlayerOnline = (PlayerOnline + 1)
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
            MedicConnected = MedicConnected + 1
        elseif xPlayer.job.name == 'police' then
            PoliceConnected = PoliceConnected +1
        elseif xPlayer.job.name == 'mechanic' then
            Mechanic = Mechanic +1
        elseif xPlayer.job.name == 'gouvernment' then
            CouncilConnected = CouncilConnected +1
        elseif xPlayer.job.name == 'kanok' then
            Kanok = Kanok +1
        elseif xPlayer.job.name == 'buranaphon' then
            Buranaphon = Buranaphon +1
        elseif xPlayer.job.name == 'prachachuen' then
            Prachachuen = Prachachuen +1
        elseif xPlayer.job.name == 'indra' then
            Indra = Indra +1
		end
	end
	
end

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
            CheckPlayerByBoseVps()           
            TriggerClientEvent('update1', -1, MedicConnected, PoliceConnected, Mechanic, CouncilConnected, Kanok, Buranaphon ,Prachachuen ,Indra) 
            local xPlayers = ESX.GetPlayers()
             for i=1, #xPlayers, 1 do
                 --PlayerOnline = 0
                 PlayerOnline = (PlayerOnline + 1)
                 
             end
             Wait(1000)
             TriggerClientEvent('playeronline',-1,PlayerOnline)
             TriggerClientEvent('profile',-1)  
            --print(PlayerOnline..' PlayerOnline') 
            local a = (MedicConnected + PoliceConnected + PlayerOnline +  Mechanic + Buranaphon)  -1
            -- print(a)  
		end)
	end
end)
