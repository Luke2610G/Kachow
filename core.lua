-- Opret automatisk listen over billeder
local randomImages = {}
local antalBilleder = 3 -- Ret til dit faktiske antal billeder

for i = 1, antalBilleder do
    table.insert(randomImages, "Interface\\AddOns\\LucasAddon\\Textures\\billede (" .. i .. ").tga")
end

-- Opret ramme og tekstur
local imageFrame = CreateFrame("Frame", "SPZoomFrame", UIParent)
imageFrame:SetSize(256, 256) 
imageFrame:SetPoint("TOPLEFT", 50, -50) 
imageFrame:Hide() 

local texture = imageFrame:CreateTexture(nil, "BACKGROUND")
texture:SetAllPoints(imageFrame)

-- ==========================================
-- FUNKTION DER AFFYRER EFFEKTEN
-- ==========================================
local function AffyrKachow()
    -- Spil lyden
    PlaySoundFile("Interface\\AddOns\\LucasAddon\\Sounds\\lyd.ogg", "Master")
    
    -- Vis et tilfældigt billede
    local randomIndex = math.random(1, #randomImages)
    texture:SetTexture(randomImages[randomIndex])
    imageFrame:Show()
    
    -- Skjul efter 2.5 sekunder
    C_Timer.After(2.5, function()
        imageFrame:Hide()
    end)
end

-- ==========================================
-- 1. TRIGGER VIA SPELLS
-- ==========================================
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

eventFrame:SetScript("OnEvent", function(self, event, unitTarget, castGUID, spellID)
    -- Kig i vores LucasAddon_Spells liste fra spells.lua
    if unitTarget == "player" and LucasAddon_Spells[spellID] then
        AffyrKachow()
    end
end)

-- ==========================================
-- 2. TRIGGER VIA CHAT KOMMANDO (/kachow)
-- ==========================================
SLASH_LUCASKACHOW1 = "/kachow"
SlashCmdList["LUCASKACHOW"] = function(msg)
    AffyrKachow()
end