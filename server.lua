local DiscordRoles = {
    ["admin"] = "123456789012345678", -- Replace with the actual role ID
    ["moderator"] = "987654321098765432" -- Add more roles if needed
}

RegisterCommand("priority", function(source, args, rawCommand)
    local src = source
    if not args[1] or not args[2] then
        TriggerClientEvent("chatMessage", src, "^1Usage: /priority [county] [1|2]")
        return
    end

    local county = args[1]
    local status = tonumber(args[2])

    if status ~= 1 and status ~= 2 then
        TriggerClientEvent("chatMessage", src, "^1Invalid option! Use 1 for 'In Progress' or 2 for 'Available'.")
        return
    end

    local discordId = GetDiscordIdentifier(src)
    if not discordId then
        TriggerClientEvent("chatMessage", src, "^1Error: Could not find Discord ID.")
        return
    end

    if not HasDiscordRole(discordId) then
        TriggerClientEvent("chatMessage", src, "^1You do not have permission to use this command.")
        return
    end

    TriggerClientEvent("updatePriorityHUD", -1, county, status)
    TriggerClientEvent("chatMessage", -1, "^2Priority for ^3" .. county .. " ^2set to: ^1" .. (status == 1 and "In Progress" or "Available"))
end, false)

function GetDiscordIdentifier(player)
    for _, id in ipairs(GetPlayerIdentifiers(player)) do
        if string.find(id, "discord:") then
       
