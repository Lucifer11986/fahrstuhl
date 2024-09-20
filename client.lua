local isNearElevator = false
local isMenuOpen = false
local selectedIndex = 1 -- Aktuell ausgewähltes Stockwerk im Menü

-- Liste der Stockwerke
local floors = {
        {x = -1095.84, y = -850.77, z = 4.88, label = 'Etage -1'}, -- Etage -1
		    {x = -1095.84, y = -850.77, z = 4.88, label = 'Etage -1'}, -- Etage -1
			{x = -1095.84, y = -850.77, z = 10.27, label = 'Etage -2'},  -- Etage -2
			{x = -1095.84, y = -850.77, z = 13.76, label = 'Etage-3'},  -- Etage -3
			{x = -1095.84, y = -850.44, z = 19.0, label = 'Erdgeschoss'},     -- Etage 0
			{x = -1095.84, y = -850.77, z = 23.03, label = 'Kantiene'},       -- Etage 1
			{x = -1095.84, y = -850.47, z = 26.82, label = 'Gym'},       -- Etage 2
			{x = -1095.84, y = -850.4, z = 30.76, label = 'Officer Büros'},         -- Etage 3
			{x = -1095.84, y = -850.32, z = 34.36, label = 'Chief Büros', job = 'police', rank = 4},       -- Etage 4
			{x = -1095.84, y = -850.37, z = 38.24, label = 'Helicopter Platz'},       -- Etage 5
}

-- Hauptthread für Menü und Fahrstuhlinteraktionen
Citizen.CreateThread(function()
    while true do
        if isNearElevator and not isMenuOpen then
            showInfobar('Drücke ~g~E~s~, für den Fahrstuhl')
            if IsControlJustReleased(0, 38) then -- Wenn "E" gedrückt wird
                openElevatorMenu() -- Menü öffnen
            end
        end

        Citizen.Wait(1)
    end
end)

-- Zweiter Thread zur Überprüfung der Nähe zum Fahrstuhl
Citizen.CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        isNearElevator = false

        for _, floor in pairs(floors) do
            local dist = Vdist(playerCoords, floor.x, floor.y, floor.z)
            if dist < 1.5 then
                isNearElevator = true
                break
            end
        end

        Citizen.Wait(500) -- Längere Pause, um die CPU zu schonen
    end
end)

-- Funktion zum Öffnen des selbst erstellten Menüs
function openElevatorMenu()
    isMenuOpen = true

    Citizen.CreateThread(function()
        while isMenuOpen do
            -- Menüsteuerung (Hoch und Runter mit Pfeiltasten)
            if IsControlJustReleased(0, 172) then -- Pfeil nach oben
                selectedIndex = selectedIndex - 1
                if selectedIndex < 1 then
                    selectedIndex = #floors -- Gehe zum letzten Element
                end
            elseif IsControlJustReleased(0, 173) then -- Pfeil nach unten
                selectedIndex = selectedIndex + 1
                if selectedIndex > #floors then
                    selectedIndex = 1 -- Gehe zum ersten Element
                end
            elseif IsControlJustReleased(0, 191) then -- Enter-Taste (Auswahl)
                local selectedFloor = floors[selectedIndex]
                SetEntityCoords(PlayerPedId(), selectedFloor.x, selectedFloor.y, selectedFloor.z)
                isMenuOpen = false -- Schließe Menü nach Auswahl
            elseif IsControlJustReleased(0, 202) then -- Rücktaste (Menü schließen)
                isMenuOpen = false
            end

            -- Menü anzeigen
            showMenu()

            Citizen.Wait(1)
        end
    end)
end

-- Funktion zur Darstellung des Menüs auf dem Bildschirm
function showMenu()
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    AddTextComponentString("Wähle ein Stockwerk:")
    DrawText(0.5, 0.3) -- Position auf dem Bildschirm

    -- Zeige jedes Stockwerk an
    for i, floor in ipairs(floors) do
        local text = floor.label
        local yPos = 0.3 + (i * 0.03)

        if i == selectedIndex then
            -- Hintergrund für das ausgewählte Stockwerk zeichnen
            DrawRect(0.52, yPos + 0.012, 0.2, 0.03, 0, 0, 0, 150) -- Ein dunklerer Hintergrund
            text = "~g~> " .. text .. " <~s~" -- Hervorheben des ausgewählten Elements
        end

        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.4, 0.4)
        SetTextColour(255, 255, 255, 255)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(0.5, yPos) -- Positioniere die Liste der Stockwerke
    end
end

-- Funktion zur Anzeige von Info-Text (Infobar)
function showInfobar(text)
    SetTextComponentFormat('STRING')
    AddTextComponentString(text)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end
