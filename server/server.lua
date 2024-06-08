local QBCore = exports['qb-core']:GetCoreObject()
local Config = Config or {}

RegisterServerEvent('badge:server:flashBadge')
AddEventHandler('badge:server:flashBadge', function(targetPlayer)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    
    if xPlayer then
        local playerName = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname
        local playerJob = xPlayer.PlayerData.job.name
        
        TriggerClientEvent('badge:client:showBadge', targetPlayer, playerName, playerJob)
    end
end)

QBCore.Functions.CreateUseableItem(Config.BadgeItem, function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        TriggerClientEvent('qb-flashbadge:client:useBadge', source)
    end
end)

RegisterServerEvent('badge:server:changeRank')
AddEventHandler('badge:server:changeRank', function(newRank)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    if xPlayer then
        xPlayer.Functions.SetJob(xPlayer.PlayerData.job.name, newRank)
        TriggerClientEvent('QBCore:Notify', src, 'Rank changed to ' .. newRank, 'success')
    end
end)

RegisterServerEvent('badge:server:updateInfo')
AddEventHandler('badge:server:updateInfo', function(newName, newBadgeNumber, newPicture, newDepartment)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    if xPlayer then
        xPlayer.Functions.SetCharInfo({
            firstname = newName:match("([^ ]+)"),
            lastname = newName:match(" (.+)"),
            citizenid = newBadgeNumber
        })
        xPlayer.Functions.SetJob(newDepartment, xPlayer.PlayerData.job.grade)
        -- Assuming you want to save the picture URL somewhere, you'd need to implement this logic as well
        TriggerClientEvent('QBCore:Notify', src, 'Information updated successfully.', 'success')
    end
end)