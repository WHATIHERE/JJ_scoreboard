ESX = nil
local display = false
local keys = 178
local IsPress = false

EMS = 0
POLICE = 0
MECHANICONLINE = 0
PlayerOnline = 0
COUNCIL = 0
KANOK = 0
BURANAPHON = 0
PRACHACHUEN = 0
INDRA = 0
FirstName = {}
LastName = {}
PhoneNumber = {}
JOB = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    Wait(7)
    ESX.TriggerServerCallback('xscoreboard:server:getdata', function(data)
        -- print("CallBack ") 
        Wait(1000)
        updatedatafirsttime(data)
        UserProfile(data)
    end)

end)

RegisterNetEvent('esx:playerLoaded') 
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	ESX.TriggerServerCallback('xscoreboard:server:getdata', function(data)      
       Wait(5000)
       updatedatafirsttime(data)
       UserProfile(data)
      -- TriggerEvent('update')
   end)
end) 


RegisterNetEvent('profile')
AddEventHandler('profile', function()
    ESX.TriggerServerCallback('xscoreboard:server:getdata', function(data)
        Wait(1000)        
        UserProfile(data)
         --print('Profile')
         SendNUIMessage({
            type = "update",
            my_id = GetPlayerServerId(PlayerId()),
            my_phonenmumber = PhoneNumber,
            my_fullname = FirstName,
            my_job = JOB,
            my_ping = Ping,
            players = PlayerOnline,
            police = POLICE,
            ems = EMS,
            mc = MECHANICONLINE,
            council = COUNCIL,
            kanok = KANOK,
            buranaphon = BURANAPHON,
            prachachuen = PRACHACHUEN,
            indra = INDRA
        })
         
     end)
   
   
end)


RegisterNetEvent('update1')
AddEventHandler('update1', function(e,p,m,c,k,b,x,i)
    EMS = e
    POLICE = p    
    MECHANICONLINE = m
    COUNCIL = c
    KANOK = k
    BURANAPHON = b
    PRACHACHUEN = x
    INDRA = i
    Wait(1000)
    updatedata(k,b,x,i)
   print(i,b,x,k)
   
   
end)

RegisterNetEvent('playeronline')
AddEventHandler('playeronline', function(allplayer)
   
   -- print('yo'..allplayer)
    PlayerOnline = allplayer
    SendNUIMessage({
        type = "update",       
        players = PlayerOnline,
      
    })
   
end)

local GuiTime = 0
RegisterCommand('scoreboard', function()
    if (GetGameTimer() - GuiTime) >= 250 then
        GuiTime = GetGameTimer()
        display = not display
        TriggerEvent("xscoreboard:display", display)
    end
end, false)

RegisterKeyMapping('scoreboard', 'Scoreboard', 'keyboard', 'DELETE')

AddEventHandler("xscoreboard:display", function(value) 
    SendNUIMessage({
        type = "ui",
        display = value
    })
end)

function updatedata(E,P,M,C,K,B,X,I)
    SendNUIMessage({
        type = "update",
        my_id = GetPlayerServerId(PlayerId()),
        my_phonenmumber = PhoneNumber,
        my_fullname = FirstName,
        my_job = JOB,
        my_ping = Ping,
        players = PlayerOnline,
        police = P,
        ems = E,
        mc = M,
        council = C,
        kanok = K,
        buranaphon = B,
        prachachuen = X,
        indra = I,


    })
   print('From Function ',K,B,X,I)
end

function updatedatafirsttime(data)
    SendNUIMessage({
        type = "update",
        my_id = GetPlayerServerId(PlayerId()),
        my_phonenmumber = data.my_phonenmumber,
        my_fullname = data.my_fullname,
        my_job = data.my_job,
        my_ping = data.my_ping,
        players = data.PlayerOnline,
        police = data.PoliceConnected,
        ems = data.MedicConnected,
        mc = data.Mechanic,
        council = data.CouncilConnected,
        kanok = data.Kanok,
        buranaphon = data.Buranaphon,
        prachachuen = data.Prachachuen,
        indra = data.Indra,
    })
    
    print('From Function ',data.Kanok)
    print('From Function ',data.Buranaphon)
    print('From Function ',data.Prachachuen)
    print('From Function ',data.Indra)
end

function UserProfile(data)
    PhoneNumber = data.my_phonenmumber
    FirstName = data.my_fullname
    JOB = data.my_job
    Ping = data.my_ping
    --MECHANICONLINE = data.mc
end