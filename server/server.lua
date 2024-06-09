local QBCore = exports['qb-core']:GetCoreObject()
local Config = Config or {}

-- Function to handle flashing the badge
local function flashBadge(source, targetPlayer)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        local playerName = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname
        local playerJob = xPlayer.PlayerData.job.name
        TriggerClientEvent('badge:client:showBadge', targetPlayer, playerName, playerJob)
    end
end

-- Function to handle changing the rank
local function changeRank(source, newRank)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        xPlayer.Functions.SetJob(xPlayer.PlayerData.job.name, newRank)
        TriggerClientEvent('QBCore:Notify', source, 'Rank changed to ' .. newRank, 'success')
    end
end

-- Function to handle updating player info
local function updateInfo(source, newName, newBadgeNumber, newPicture, newDepartment)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        local firstName, lastName = newName:match("([^ ]+)"), newName:match(" (.+)")
        xPlayer.Functions.SetCharInfo({
            firstname = firstName,
            lastname = lastName,
            citizenid = newBadgeNumber
        })
        xPlayer.Functions.SetJob(newDepartment, xPlayer.PlayerData.job.grade)
        -- Add logic to save the picture URL if necessary
        TriggerClientEvent('QBCore:Notify', source, 'Information updated successfully.', 'success')
    end
end

-- Register the server events
RegisterServerEvent('badge:server:flashBadge')
AddEventHandler('badge:server:flashBadge', function(targetPlayer)
    flashBadge(source, targetPlayer)
end)

RegisterServerEvent('badge:server:changeRank')
AddEventHandler('badge:server:changeRank', function(newRank)
    changeRank(source, newRank)
end)

RegisterServerEvent('badge:server:updateInfo')
AddEventHandler('badge:server:updateInfo', function(newName, newBadgeNumber, newPicture, newDepartment)
    updateInfo(source, newName, newBadgeNumber, newPicture, newDepartment)
end)

-- Make the badge item usable
QBCore.Functions.CreateUseableItem(Config.BadgeItem, function(source, item)
    TriggerClientEvent('qb-flashbadge:client:useBadge', source)
end)
