
SMODS.Joker{ --Cobalt Joker
    key = "cobaltjoker",
    config = {
    },
    loc_txt = {
        ['name'] = '鈷小丑',
        ['text'] = {
            [1] = '{C:attention}重新觸發{}右邊的小丑'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 10,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

	calculate = function(self, card, context)

        if context.retrigger_joker then 
            return{
                repetitions = 1,
                retrigger_joker = retrigger_card
            }
        end
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
        local target_joker = nil
        local my_pos = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                my_pos = i
                break
            end
        end
			if context.other_card == G.jokers.cards[my_pos + 1] then
				return {
					message = localize("k_again_ex"),
					repetitions = 1,
					card = card,
				}
			else
				return nil, true
			end
		end
	end,
}

SMODS.Joker{ --Copper Joker
    key = "copperjoker",
    config = {
        extra = {
            multiplier = 0.25,
            base = 1
        }
    },
    loc_txt = {
        ['name'] = '銅小丑',
        ['text'] = {
            [1] = '每個剩餘的出牌次數',
            [2] = '提供{X:red,C:white}X#1#{}倍率',
            [3] = '{C:inactive}(目前{}{X:red,C:white}X#2#{}{C:inactive}倍率){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.multiplier, card.ability.extra.base + ((G.GAME.current_round.hands_left or 0)) * card.ability.extra.multiplier}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                Xmult = lenient_bignum(card.ability.extra.base + (G.GAME.current_round.hands_left) * card.ability.extra.multiplier)
            }
        end
    end
}


SMODS.Joker{ --Nahuatl Joker
    key = "nahuatljoker",
    config = {
        extra = {
            mod = 1,
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = '納瓦特爾小丑',
        ['text'] = {
            [1] = '若剛好打出{C:attention}3{}張牌,',
            [2] = '打出的牌{C:attention}計分{}時{C:attention}-1{}點數',
            [3] = '並為這張小丑提供{C:mult}+#1#{}倍率',
            [4] = '{C:inactive}(目前{}{C:red}+#2#{}{C:inactive}倍率){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mod, card.ability.extra.mult}}
    end,
    
    calculate = function(self, card, context)
       if context.individual and context.cardarea == G.play and to_big(#context.full_hand) == to_big(3) then
            local scored_card = context.other_card
            G.E_MANAGER:add_event(Event({
                func = function()
                    assert(SMODS.modify_rank(scored_card, -1))
                    return true
                end
            }))
            card.ability.extra.mult = lenient_bignum(card.ability.extra.mult + card.ability.extra.mod)
        end
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                mult = lenient_bignum(card.ability.extra.mult)
            }
        end
    end
}


SMODS.Joker{ --Rose Gold Joker
    key = "rosegoldjoker",
    config = {
        extra = {
			chips = 0.7,
			immutable = {
                slots = 2
			}
        }
    },
    loc_txt = {
        ['name'] = '玫瑰金小丑',
        ['text'] = {
            [1] = '{C:attention}+#2#{}消耗牌欄位',
            [2] = '{X:chips,C:white}X#1#{}籌碼'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chips, card.ability.extra.immutable.slots}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and not context.blueprint then
            return {
                x_chips = card.ability.extra.chips
            }
        end
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.immutable.slots
            return true
        end }))
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.immutable.slots
            return true
        end }))
    end
}

SMODS.Joker{ --Manyullyn Joker
    key = "manyullynjoker",
    config = {
        extra = {
            mult = 1,
            mod = 0.05
        }
    },
    loc_txt = {
        ['name'] = '瑪玉靈小丑',
        ['text'] = {
            [1] = '打出的牌被計分時，{X:red,C:white}X#1#{}倍率,',
            [2] = '然後將{X:red,C:white}X倍率{}數值提升{X:red,C:white}+#2#{}',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mult, card.ability.extra.mod}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play or context.forcetrigger then
            card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mod
            return {
                Xmult = card.ability.extra.mult
            }
        end
    end
}