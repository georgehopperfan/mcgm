
SMODS.Joker{ --Cobblestone Generator
    key = "cobble",
    config = {
        extra = {
            chipsmod = 5,
            chips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Cobblestone Generator',
        ['text'] = {
            [1] = 'This Joker gains {C:blue}+#1#{} Chips',
            [2] = 'if played hand contains',
            [3] = 'a scoring card in {C:clubs}Black{} suit and',
            [4] = 'a scoring card in {C:diamonds}Red{} suit',
            [5] = '{C:inactive}(Currently{} {C:blue}+#2#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chipsmod, card.ability.extra.chips}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if ((function()
                local count = 0
                for _, playing_card in pairs(context.scoring_hand or {}) do
                    if playing_card:is_suit("Spades") or playing_card:is_suit("Clubs") then
                        count = count + 1
                    end
                end
                return count >= 1
            end)() and (function()
                local count = 0
                for _, playing_card in pairs(context.scoring_hand or {}) do
                    if playing_card:is_suit("Hearts") or playing_card:is_suit("Diamonds") then
                        count = count + 1
                    end
                end
                return count >= 1
            end)()) then
                return {
                    func = function()
                        card.ability.extra.chips = (card.ability.extra.chips) + card.ability.extra.chipsmod
                        return true
                    end,
                message = localize('k_upgrade_ex')
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.forcetrigger then
            card.ability.extra.chips = (card.ability.extra.chips) + card.ability.extra.chipsmod
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}