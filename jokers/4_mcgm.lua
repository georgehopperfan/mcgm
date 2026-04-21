
SMODS.Joker{ --Cobblestone Generator
    key = "cobble",
    config = {
        extra = {
            chipsmod = 5,
            chips = 0
        }
    },
    loc_txt = {
        ['name'] = '鵝卵石製造機',
        ['text'] = {
            [1] = '若打出的牌包含一張計分的黑色牌和紅色牌，',
            [2] = '這張小丑獲得{C:blue}+#1#{}籌碼',
            [3] = '{C:inactive}(目前{}{C:blue}+#2#{}{C:inactive}籌碼){}'
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

SMODS.Joker{ --MACE ATTACK
    key = "maceattack",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'MACE ATTACK',
        ['text'] = {
            [1] = '打出並計分的牌中',
            [2] = '最高點數和最低點數每差1點',
            [3] = '{X:red,C:white}X0.6{}倍率'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.joker_main then
            local low, high = context.scoring_hand[1].base.nominal, context.scoring_hand[1].base.nominal
            for k, v in ipairs(context.scoring_hand) do
                if v.base.nominal < low then
                    low = v.base.nominal
                    break
                elseif v.base.nominal > high then
                    high = v.base.nominal
                    break
                end
            end
            if high - low > 0 then
                return {
                    Xmult = 0.6 * lenient_bignum((high - low) or 0)
                }
            else
                return {
                    Xmult = 0,
                    card_eval_status_text(card, "extra", nil, nil, nil, { message = "X0 Mult", colour = G.C.RED })
                }
            end
        end
    end

}


SMODS.Joker{ --QUARTZ
    key = "quartz",
    config = {
        extra = {
            mult = 51,
            odds = 4
        }
    },
    loc_txt = {
        ['name'] = '石英',
        ['text'] = {
            [1] = '打出的{C:hearts}紅心{}牌計分時',
            [2] = '有{C:green}#2#/#3#{}機率{C:red}+#1#{}倍率',
            [3] = '{C:inactive}我的石英呢{}'
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



SMODS.Joker{ --刷鐵機
    key = "ironfarm",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = '刷鐵機',
        ['text'] = {
            [1] = '進入盲注時，生成一個鐵小丑'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 3
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
    
    calculate = function(self, card, context)
        if context.setting_blind or context.forcetrigger then
            return {
                func = function()
                    
                    local created_joker = false
                    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                        created_joker = true
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_mcgm_iron' })
                                if joker_card then
                                    
                                    
                                end
                                G.GAME.joker_buffer = 0
                                return true
                            end
                        }))
                    end
                    if created_joker then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
                    end
                    return true
                end
            }
        end
    end
}

SMODS.Joker{ --刷金機
    key = "goldfarm",
    config = {
        extra = {
            played = 0,
            repetitions = 2
        }
    },
    loc_txt = {
        ['name'] = '刷金機',
        ['text'] = {
            [1] = '{C:attention}5{}次出牌後{C:inactive}(#1#){}',
            [2] = '產生{C:attention}2{}個金小丑'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = false,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.played}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  and not context.blueprint then
            if to_big(card.ability.extra.played) < to_big(4) then
                card.ability.extra.played = (card.ability.extra.played) + 1
            elseif to_big(card.ability.extra.played) >= to_big(4) then
                card.ability.extra.played = 0
                for i = 1, 2 do
                    local created_joker = false
                    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                        created_joker = true
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_mcgm_gold' })
                                if joker_card then
                                    
                                    
                                end
                                G.GAME.joker_buffer = 0
                                return true
                            end
                        }))
                    end
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = created_joker and localize('k_plus_joker') or nil, colour = G.C.BLUE})
                end
            end
        end
        if context.forcetrigger then
                for i = 1, 2 do
                    local created_joker = false
                    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                        created_joker = true
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_mcgm_gold' })
                                if joker_card then
                                    
                                    
                                end
                                G.GAME.joker_buffer = 0
                                return true
                            end
                        }))
                    end
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = created_joker and localize('k_plus_joker') or nil, colour = G.C.BLUE})
                end
        end
    end
}

SMODS.Joker{ --Zombie Skeleton
    key = "zombieskeleton",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = '殭屍骷髏',
        ['text'] = {
            [1] = '打出並計分的{C:spades}黑桃{}牌轉換為{C:clubs}梅花{}牌'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if context.other_card:is_suit("Spades") then
                local scored_card = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        
                        assert(SMODS.change_base(scored_card, "Clubs", nil))
                        card_eval_status_text(scored_card, 'extra', nil, nil, nil, {message = "Card Modified!", colour = G.C.ORANGE})
                        return true
                    end
                }))
            end
        end
    end
}


SMODS.Joker{ --Low Tier 1
    key = "lowtier1",
    config = {
        extra = {
            repetitions0 = 2
        }
    },
    loc_txt = {
        ['name'] = 'Low Tier 1',
        ['text'] = {
            [1] = '重新觸發打出的{C:attention}A{}兩次'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if context.other_card:get_id() == 14 then
                return {
                    repetitions = 2,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}

SMODS.Joker{ --High Tier 1
    key = "hightier1",
    config = {
        extra = {
            chips0 = 50,
            mult0 = 10,
            xmult0 = 1.5
        }
    },
    loc_txt = {
        ['name'] = 'High Tier 1',
        ['text'] = {
            [1] = '打出的{C:attention}A{}視為擁有{C:dark_edition}負片{}以外',
            [2] = '的所有其他原版版本'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 14 then
                return {
                    chips = 50,
                    extra = {
                        mult = 10,
                        extra = {
                            Xmult = 1.5
                        }
                    }
                }
            end
        end
    end
}

SMODS.Joker{ --Solo
    key = "solo",
    config = {
        extra = {
            mult_mod = 1,
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Solo',
        ['text'] = {
            [1] = '若打出的牌型為{C:attention}高牌{}，',
            [2] = '這張小丑獲得{C:red}+#1#{}倍率',
            [3] = '{C:inactive}(目前{}{C:red}+#2#{}{C:inactive}倍率){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    demicoloncomapt = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mult_mod, card.ability.extra.mult}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if context.scoring_name == "High Card" then
                return {
                    func = function()
                        card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mult_mod
                        return true
                    end,
                    message = localize('k_upgrade_ex')
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.forcetrigger then
            card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mult_mod
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{ --Party
    key = "party",
    config = {
        extra = {
            chips = 0,
            jokercount = 0
        }
    },
    loc_txt = {
        ['name'] = 'Party',
        ['text'] = {
            [1] = '若打出並計分的牌數量',
            [2] = '{C:attention}大於{}擁有的小丑數量，',
            [3] = '這張小丑獲得{C:blue}4{}倍',
            [4] = '小丑數量的{C:blue}籌碼{}',
            [5] = '{C:inactive}(目前{}{C:blue}+#1#{}{C:inactive}籌碼){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chips, #(G.jokers and (G.jokers and G.jokers.cards or {}) or {})}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if to_big(#context.full_hand) > to_big(#(G.jokers and G.jokers.cards or {})) then
                return {
                    func = function()
                        card.ability.extra.chips = (card.ability.extra.chips) + (#(G.jokers and G.jokers.cards or {})) * 4
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
            card.ability.extra.chips = (card.ability.extra.chips) + (#(G.jokers and G.jokers.cards or {})) * 4
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
SMODS.Joker{ --Attribute Swapping
    key = "attributeswapping",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Attribute Swapping',
        ['text'] = {
            [1] = '{C:attention}左邊{}的小丑結算時',
            [2] = '{C:attention}強制觸發右邊{}的小丑'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' 
            or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    calculate = function(self, card, context)
        if context.post_trigger then
            local left_joker = nil
            for k, v in ipairs(G.jokers.cards) do
                if v == card then
                    if k > 1 then
                        left_joker = G.jokers.cards[k - 1]
                    end
                end
            end
            if left_joker and context.other_card == left_joker then
			    for i = 1, #G.jokers.cards do
				    if G.jokers.cards[i] == card then
					    if Cryptid.demicolonGetTriggerable(G.jokers.cards[i + 1])[1] then
						    local results = Cryptid.forcetrigger(G.jokers.cards[i + 1], context)
						    if results and results.jokers then
							    return results.jokers
						    end
						end
					end
				end
			end
        end
    end
}