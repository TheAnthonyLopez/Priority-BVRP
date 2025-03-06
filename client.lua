local priorityStatus = {}

RegisterNetEvent("updatePriorityHUD")
AddEventHandler("updatePriorityHUD", function(county, status)
    priorityStatus[county] = status
    DisplayPriorityHUD(county, status)
end)

function DisplayPriorityHUD(county, status)
    local text = status == 1 and "~y~IN PROGRESS" or "~g~AVAILABLE"
    
    Citizen.CreateThread(function()
        while priorityStatus[county] == status do
            Citizen.Wait(0)
            DrawTextOnScreen("PRIORITY STATUS - " .. string.upper(county) .. "\n" .. text, 0.85, 0.05)
        end
    end)
end

function DrawTextOnScreen(text, x, y)
    SetTextFont(4)
    SetTextScale(0.45, 0.45)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
