local QBCore = exports['qb-core']:GetCoreObject()
local Config = Config or {}

local function isAllowedJob(job)
    for _, allowedJob in ipairs(Config.AllowedJobs) do
        if job == allowedJob then
            return true
        end
    end
    return false
end

RegisterNetEvent('qb-flashbadge:client:useBadge')
AddEventHandler('qb-flashbadge:client:useBadge', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local targetPed, targetDistance = QBCore.Functions.GetClosestPed(playerCoords)
    local playerJob = QBCore.Functions.GetPlayerData().job.name

    if targetPed ~= 0 and targetDistance <= Config.MaxDistance then
        if isAllowedJob(playerJob) then
            TriggerServerEvent('badge:server:flashBadge', GetPlayerServerId(NetworkGetEntityOwner(targetPed)))
        else
            QBCore.Functions.Notify(Config.Messages.StolenBadge, 'error')
            SendNUIMessage({
                action = "showStolenBadge"
            })
        end
    else
        QBCore.Functions.Notify(Config.Messages.NoOneNearby, 'error')
    end
end)

RegisterCommand('flashbadge', function()
    TriggerEvent('qb-flashbadge:client:useBadge')
end, false)

RegisterCommand('openrankui', function()
    local playerData = QBCore.Functions.GetPlayerData()
    local playerJob = playerData.job.name
    if isAllowedJob(playerJob) then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "open",
            name = playerData.charinfo.firstname .. ' ' .. playerData.charinfo.lastname,
            badgeNumber = playerData.citizenid,
            picture = '', -- Add default picture URL if needed
            rank = playerData.job.grade_name,
            department = playerJob
        })
    end
end, false)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('changeRank', function(data, cb)
    local newRank = data.rank
    TriggerServerEvent('badge:server:changeRank', newRank)
    cb('ok')
end)

RegisterNUICallback('updateInfo', function(data, cb)
    local newName = data.name
    local newBadgeNumber = data.badgeNumber
    local newPicture = data.picture
    local newDepartment = data.department
    TriggerServerEvent('badge:server:updateInfo', newName, newBadgeNumber, newPicture, newDepartment)
    cb('ok')
end)
