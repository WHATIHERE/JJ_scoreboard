ESX = nil

Citizen.CreateThread(function() 
    Citizen.Wait(1000)
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end

    ESX.RegisterServerCallback('jj:server:getdata', function(source, cb)
        local iden = GetPlayerIdentifiers(source)[1]
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @iden LIMIT 0,1', {
            ['@iden'] = iden
        }, function(result)
            if not (result[1] == nil) then
                local data = {}
                local job_label = GetJobLabel(result[1].job, result[1].job_grade)
                local xPlayers = ESX.GetPlayers()
                local players = 0
                local blue = 0
                local churn = 0
                local indra = 0
                local kanok = 0
                for i=1, #xPlayers, 1 do
                    players = (players + 1)
                    local xP = ESX.GetPlayerFromId(xPlayers[i])
                    local xP_Job = xP.getJob()
                    if xP_Job.name == "blue" then
                        blue = (blue + 1)
                    elseif xP_Job.name == "churn" then
                        churn = (churn + 1)
                    elseif xP_Job.name == "indra" then
                        indra = (indra + 1)
                    elseif xP_Job.name == "kanok" then
                        kanok = (kanok + 1)
                    end
                end
                table.insert(data, {
                    my_phonenmumber = result[1].phone_number,
                    my_fullname = result[1].firstname .. " " .. result[1].lastname,
                    my_job = job_label,
                    my_ping = GetPlayerPing(source),
                    players = players,
                    blue = blue,
                    indra = indra,
                    kanok = kanok,
                    churn = churn
                })

                cb(data)
            else
                cb(nil)
            end
        end)
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