

local perks = RES_perks
local indexed = {}

for _, perk in ipairs(perks) do
	indexed[perk.alias] = perk
end

return indexed