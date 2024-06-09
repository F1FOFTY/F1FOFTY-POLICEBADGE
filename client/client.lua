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

local function notifyPlayer(message, type)
    QBCore.Functions.Notify(message, type)
end

local function getPlayerData()
    return QBCore.Functions.GetPlayerData()
end

local function flashBadge()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local targetPed, targetDistance = QBCore.Functions.GetClosestPed(playerCoords)
    local playerJob = getPlayerData().job.name

    if targetPed ~= 0 and targetDistance <= Config.MaxDistance then
        if isAllowedJob(playerJob) then
            TriggerServerEvent('badge:server:flashBadge', GetPlayerServerId(NetworkGetEntityOwner(targetPed)))
        else
            notifyPlayer(Config.Messages.StolenBadge, 'error')
            SendNUIMessage({ action = "showStolenBadge" })
        end
    else
        notifyPlayer(Config.Messages.NoOneNearby, 'error')
    end
end

local function openRankUI()
    local playerData = getPlayerData()
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
end

RegisterCommand('flashbadge', flashBadge, false)

RegisterCommand('openrankui', openRankUI, false)

RegisterNetEvent('qb-flashbadge:client:useBadge')
AddEventHandler('qb-flashbadge:client:useBadge', flashBadge)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('changeRank', function(data, cb)
    TriggerServerEvent('badge:server:changeRank', data.rank)
    cb('ok')
end)

RegisterNUICallback('updateInfo', function(data, cb)
    TriggerServerEvent('badge:server:updateInfo', data.name, data.badgeNumber, data.picture, data.department)
    cb('ok')
end)
