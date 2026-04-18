
SMODS.Joker{ --QUARTZ
    key = "quartz",
    config = {
        extra = {
            mult = 51,
            odds = 4
        }
    },
    loc_txt = {
        ['name'] = 'QUARTZ',
        ['text'] = {
            [1] = '{C:green}#2# in #3#{} chance to {C:red}+#1#{} Mult',
            [2] = 'when each played {C:hearts}Hearts{} is scored',
            [3] = '{C:inactive}WHERE\'S MY QUARTZ{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_mcgm_quartz') 
        return {vars = {card.ability.extra.mult, new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Hearts") then
                if SMODS.pseudorandom_probability(card, 'group_0_42e3a785', 1, card.ability.extra.odds, 'j_mcgm_quartz', false) then
                    return {
                        mult = card.ability.extra.mult
                    }
                end
            end
        end
    end
}