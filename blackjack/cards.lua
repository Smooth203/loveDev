Cards = {}

function Cards:load()
	values = {
		"2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"
	}
	suits = {
		"clubs", "diamonds", "hearts", "spades"
	}
end

function Cards:newDeck(decksUsed)
	Cards:load()
	local deck = {}
	for i = 1, decksUsed do
		for i, suit in ipairs(suits) do
			for j, value in ipairs(values) do
				weight = tonumber(value)
				if value == "J" or value == "Q" or value == "K" then
					weight = 10
				elseif value == "A" then
					weight = 11
				end
				card = {
					Value = value,
					Suit = suit,
					Weight = weight
				}
				table.insert(deck, card)
			end
		end
	end
	return deck
end