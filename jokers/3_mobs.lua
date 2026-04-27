-- villagers

SMODS.Joker{ --無業
    key = "nojob",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = '無業',
        ['text'] = {
            [1] = '根據下一張使用的{C:attention}消耗牌{}獲得職業'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.using_consumeable  and not context.blueprint then
            if context.consumeable and context.consumeable.ability.set == 'Planet' then
                return {
                    func = function()
                        local target_joker = card
                        
                        if target_joker then
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                        end
                        return true
                    end,
                    extra = {
                        func = function()
                            
                            local created_joker = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_mcgm_toolsmith' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                            end
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            elseif context.consumeable and context.consumeable.ability.set == 'Tarot' then
                return {
                    func = function()
                        local target_joker = card
                        
                        if target_joker then
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                        end
                        return true
                    end,
                    extra = {
                        func = function()
                            
                            local created_joker = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_mcgm_cartographer' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                            end
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            elseif context.consumeable and context.consumeable.ability.set == 'Spectral' then
                return {
                    func = function()
                        local target_joker = card
                        
                        if target_joker then
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                        end
                        return true
                    end,
                    extra = {
                        func = function()
                            
                            local created_joker = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_mcgm_librarian' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                            end
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            end
        end
    end
}


SMODS.Joker{ --傻子
    key = "nitwit",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = '傻子',
        ['text'] = {
            [1] = '請輸入文本'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 10,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  and not context.blueprint then
            local created_joker = false
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                created_joker = true
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_mcgm_nitwit' })
                        if joker_card then
                            
                            
                        end
                        G.GAME.joker_buffer = 0
                        return true
                    end
                }))
            end
            return {
                message = created_joker and localize('k_plus_joker') or nil
            }
        end
    end
}

SMODS.Joker{ --工具匠
    key = "toolsmith",
    config = {
        extra = {
            mult_mod = 1,
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = '工具匠',
        ['text'] = {
            [1] = '從商店購買牌時，',
            [2] = '這張小丑獲得{C:red}+#1#{}倍率',
            [3] = '{C:inactive}(目前{}{C:red}+#2#{}{C:inactive}倍率){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 4
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
        
        return {vars = {card.ability.extra.mult_mod, card.ability.extra.mult}}
    end,
    
    calculate = function(self, card, context)
        if context.buying_card  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mult_mod
                    return true
                end,
                message = localize('k_upgrade_ex')
            }
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

SMODS.Joker{ --製箭師
    key = "fletcher",
    config = {
        extra = {
            req = 4,
            played = 0,
            money = 1,
            cardsinhand = 0
        }
    },
    loc_txt = {
        ['name'] = '製箭師',
        ['text'] = {
            [1] = '每打出{C:attention}#1#{}張牌{C:inactive}(#2#){}',
            [2] = '賺取{C:gold}$#3#{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.req, card.ability.extra.played, card.ability.extra.money, (#(G.hand and G.hand.cards or {}) or 0)}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.played = (card.ability.extra.played) + #context.full_hand
                    return true
                end
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            if to_big(card.ability.extra.played) >= to_big(card.ability.extra.req) then
                local dollar = math.floor(card.ability.extra.played / card.ability.extra.req)
                return {
                    func = function()
                        ease_dollars(dollar * card.ability.extra.money)
                        card.ability.extra.played = card.ability.extra.played - (dollar * card.ability.extra.req)
                    return true
                    end,
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "$"..tostring(dollar * card.ability.extra.money), colour = G.C.MONEY})
                }
            end
        end
    end
}

SMODS.Joker{ --農夫
    key = "farmer",
    config = {
        extra = {
            discount_amount = '2'
        }
    },
    loc_txt = {
        ['name'] = '農夫',
        ['text'] = {
            [1] = '商店的消耗牌便宜{C:money}$2{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end
} 
      
local card_set_cost_ref = Card.set_cost
function Card:set_cost()
    card_set_cost_ref(self)
    
    if next(SMODS.find_card("j_mcgm_farmer")) then
        if (self.ability.set == 'Tarot' or self.ability.set == 'Planet' or self.ability.set == 'Spectral') then
            self.cost = math.max(0, self.cost - (2))
        end
    end
    
    self.sell_cost = math.max(1, math.floor(self.cost / 2)) + (self.ability.extra_value or 0)
    self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
end

SMODS.Joker{ --製圖師
    key = "cartographer",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = '製圖師',
        ['text'] = {
            [1] = '{C:attention}+2{}商店欄位'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 4
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
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        change_shop_size(2)
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        change_shop_size(-2)
    end
}

SMODS.Joker{ --製甲師
    key = "armorsmith",
    config = {
        extra = {
            bought = 0,
            xmult_mod = 0.25,
            xmult = 1
        }
    },
    loc_txt = {
        ['name'] = '製甲師',
        ['text'] = {
            [1] = '每從商店購買',
            [2] = '{C:attention}4{}張{C:inactive}(#1#){}卡牌時，',
            [3] = '這張小丑獲得{X:red,C:white}X#2#{}倍率',
            [4] = '{C:inactive}(目前{}{X:red,C:white}X#3#{}{C:inactive}倍率){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.bought, card.ability.extra.xmult_mod, card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.buying_card  and not context.blueprint then
            if to_big(card.ability.extra.bought) < to_big(3) then
                return {
                    func = function()
                        card.ability.extra.bought = (card.ability.extra.bought) + 1
                        return true
                    end
                }
            else
                return {
                    func = function()
                        card.ability.extra.bought = 0
                        return true
                    end,
                    extra = {
                        func = function()
                            card.ability.extra.xmult = (card.ability.extra.xmult) + card.ability.extra.xmult_mod
                            return true
                        end,
                        message = localize('k_upgrade_ex')
                    }
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
        if context.forcetrigger then
            card.ability.extra.xmult = (card.ability.extra.xmult) + card.ability.extra.xmult_mod
            return {
                Xmult = card.ability.extra.xmult
            }
        end
    end
}
SMODS.Joker{ --圖書管理員
    key = "librarian",
    config = {
        extra = {
            odds = 3
        }
    },
    loc_txt = {
        ['name'] = '圖書管理員',
        ['text'] = {
            [1] = '重骰商店時，',
            [2] = '{C:green}#1#/#2#{}機率產生一張',
            [3] = '隨機{C:spectral}幻靈牌{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_mcgm_librarian') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.reroll_shop  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_7cec881a', 1, card.ability.extra.odds, 'j_mcgm_librarian', false) then
                    SMODS.calculate_effect({func = function()
                        
                        for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.4,
                                func = function()
                                    play_sound('timpani')
                                    SMODS.add_card({ set = 'Spectral', soulable = true, })                            
                                    card:juice_up(0.3, 0.5)
                                    return true
                                end
                            }))
                        end
                        delay(0.6)
                        
                        if created_consumable then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                        end
                        return true
                    end}, card)
                end
            end
        end
    end
}

SMODS.Joker{ --神職人員
    key = "cleric",
    config = {
        extra = {
            xmult = 2.6
        }
    },
    loc_txt = {
        ['name'] = '神職人員',
        ['text'] = {
            [1] = '打出並計分的{C:attention}倍率牌{}',
            [2] = '提供{X:red,C:white}X#1#{}倍率'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if SMODS.get_enhancements(context.other_card)["m_mult"] == true then
                return {
                    Xmult = card.ability.extra.xmult
                }
            end
        end
        if context.forcetrigger then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
    end
}



-- hostile mobs


SMODS.Joker{ --殭屍
    key = "zombie",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = '殭屍',
        ['text'] = {
            [1] = '賣掉這張牌時，',
            [2] = '產生兩個{C:attention}皇后{}{C:tarot}塔羅牌{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.selling_self or context.forcetrigger then
            return {
                func = function()
                    
                    for i = 1, math.min(2, G.consumeables.config.card_limit - #G.consumeables.cards) do
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                play_sound('timpani')
                                SMODS.add_card({ set = 'Tarot', key = 'c_empress'})                            
                                card:juice_up(0.3, 0.5)
                                return true
                            end
                        }))
                    end
                    delay(0.6)
                    
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                    end
                    return true
                end
            }
        end
    end
}

SMODS.Joker{ --苦力怕
    key = "creeper",
    config = {
        extra = {
            xmult = 3
        }
    },
    loc_txt = {
        ['name'] = '苦力怕',
        ['text'] = {
            [1] = '最後一次出牌時，',
            [2] = '{X:red,C:white}X#1#{}倍率並摧毀有計分的牌，然後{C:red}自爆{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if (context.cardarea == G.jokers and context.joker_main and to_big(G.GAME.current_round.hands_left) <= to_big(0)) or context.forcetrigger then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
        if context.after and context.cardarea == G.jokers  and not context.blueprint then
            if to_big(G.GAME.current_round.hands_left) <= to_big(0) then
                return {
                    func = function()
                        local target_joker = card
                        
                        if target_joker then
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:explode({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                        end
                        return true
                    end
                }
            end
        end
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if to_big(G.GAME.current_round.hands_left) <= to_big(0) then
                context.other_card.should_destroy = true
            end
        end
    end
}

SMODS.Joker{ --骷髏
    key = "skeleton",
    config = {
        extra = {
            mult = 25,
            odds = 2
        }
    },
    loc_txt = {
        ['name'] = '骷髏',
        ['text'] = {
            [1] = '{C:green}#2#/#3#{}機率{C:red}+#1#{}倍率'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 3
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
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_mcgm_skeleton') 
        return {vars = {card.ability.extra.mult, new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_6d53c9bb', 1, card.ability.extra.odds, 'j_mcgm_skeleton', false) then
                    SMODS.calculate_effect({mult = card.ability.extra.mult}, card)
                end
            end
        end
        if context.forcetrigger then
            return {mult = card.ability.extra.mult}
        end
    end
}

SMODS.Joker{ --小殭屍
    key = "babyzombie",
    config = {
        extra = {
            odds = 2,
        }
    },
    loc_txt = {
        ['name'] = '小殭屍',
        ['text'] = {
            [1] = '打出的牌有{C:green}#1#/#2#{}機率重新觸發'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 1
    },
    display_size = {
        w = 71 * 0.5, 
        h = 95 * 0.5
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_mcgm_babyzombie') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, 'group_0_51a47a35', 1, card.ability.extra.odds, 'j_mcgm_babyzombie', false) then
                return {
                    repetitions = 1,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}

SMODS.Joker{ --蜘蛛
    key = "spider",
    config = {
        extra = {
            pb_bonus = 16,
            perma_bouns = 0
        }
    },
    loc_txt = {
        ['name'] = '蜘蛛',
        ['text'] = {
            [1] = '打出的{C:attention}8{}',
            [2] = '永久獲得{C:blue}+#1#{}籌碼'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.pb_bonus}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 8 then
                context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.pb_bonus
                return {
                    extra = { message = localize('k_upgrade_ex'), colour = G.C.CHIPS }, card = card
                }
            end
        end
    end
}
SMODS.Joker{ --女巫
    key = "witch",
    config = {
        extra = {
            played = 0,
            req = 3
        }
    },
    loc_txt = {
        ['name'] = '女巫',
        ['text'] = {
            [1] = '每{C:attention}#2#{}次{C:inactive}(#1#){}出牌',
            [2] = '產生一張隨機{C:tarot}塔羅牌{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
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
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.played, card.ability.extra.req}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            if to_big(card.ability.extra.played) < to_big(card.ability.extra.req - 1) then
                if not context.blueprint then
                    card.ability.extra.played = (card.ability.extra.played) + 1
                end
            elseif to_big(card.ability.extra.played) >= to_big(card.ability.extra.req - 1) then
                card.ability.extra.played = (card.ability.extra.played) + 1
                for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            play_sound('timpani')
                            SMODS.add_card({ set = 'Tarot', })                            
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                end
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                delay(0.6)
            end
        end
        if context.after and context.cardarea == G.jokers  and not context.blueprint then
            if to_big(card.ability.extra.played) >= to_big(card.ability.extra.req) then
                return {
                    func = function()
                        card.ability.extra.played = 0
                        return true
                    end
                }
            end
        end
    end
}

SMODS.Joker{ --終界使者
    key = "enderman",
    config = {
        extra = {
            xmult = 1
        }
    },
    loc_txt = {
        ['name'] = '終界使者',
        ['text'] = {
            [1] = '每個回合首次出牌時，失去所有棄牌，',
            [2] = '每失去1棄牌本回合{X:red,C:white}X1{}倍率',
            [3] = '{C:inactive}（目前{}{X:red,C:white}X#1#{}{C:inactive}倍率）{}',
            [4] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    func = function()
                        card.ability.extra.xmult = 1 + (G.GAME.current_round.discards_left or 0)
                        return true
                    end,
                    extra = {
                        
                        func = function()
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = tostring(card.ability.extra.xmult), colour = G.C.BLUE})
                            G.GAME.current_round.discards_left = 0
                            return true
                        end,
                        colour = G.C.GREEN
                    }
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.xmult = 1
                    return true
                end
            }
        end
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
    end
}
SMODS.Joker{ --guardian
    key = "guardian",
    config = {
        extra = {
            repetitions = 1
        }
    },
    loc_txt = {
        ['name'] = '深海守衛',
        ['text'] = {
            [1] = '重新觸發打出的',
            [2] = '{C:attention}6,7,8,9,10{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 6,
        y = 3
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
            if (context.other_card:get_id() == 6 or context.other_card:get_id() == 7 or context.other_card:get_id() == 8 or context.other_card:get_id() == 9 or context.other_card:get_id() == 10) then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = "Again!"
                }
            end
        end
    end
}

SMODS.Joker{ --遠古深海守衛
    key = "elderguardian",
    config = {
        extra = {
            money = 8
        }
    },
    loc_txt = {
        ['name'] = '遠古深海守衛',
        ['text'] = {
            [1] = '打出的{C:attention}3,6{}或{C:attention}9{}計分時{C:money}+$#1#{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.money}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if (context.other_card:get_id() == 3) or (context.other_card:get_id() == 6) or (context.other_card:get_id() == 9) then
                return {
                    
                    func = function()
                        
                        local current_dollars = G.GAME.dollars
                        local target_dollars = G.GAME.dollars + card.ability.extra.money
                        local dollar_value = target_dollars - current_dollars
                        ease_dollars(dollar_value)
                        card_eval_status_text(context.other_card or card, 'extra', nil, nil, nil, {message = "$"..tostring(card.ability.extra.money), colour = G.C.MONEY})
                        return true
                    end
                }
            end
        end
        if context.forcetrigger then
            return {
                dollars = card.ability.extra.money
            }
        end
    end
}
SMODS.Joker{ --Piglin
    key = "piglin",
    config = {
        extra = {
            tarot = 0
        }
    },
    loc_txt = {
        ['name'] = '豬布林',
        ['text'] = {
            [1] = '若打出的牌包含{C:gold}黃金牌{}',
            [2] = '產生一張{C:tarot}塔羅牌{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    enhancement_gate = 'm_gold',
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.tarot}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if (SMODS.get_enhancements(context.other_card)["m_gold"] == true and to_big((card.ability.extra.tarot or 0)) < to_big(1)) then
                card.ability.extra.tarot = 1
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            if to_big(card.ability.extra.tarot) > to_big(0) then
                for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            play_sound('timpani')
                            SMODS.add_card({ set = 'Tarot', })                            
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                end
                delay(0.6)
                return {
                    message = created_consumable and localize('k_plus_tarot') or nil
                }
            end
        end
        if context.after and context.cardarea == G.jokers  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.tarot = 0
                    return true
                end
            }
        end
        if context.forcetrigger then
            for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('timpani')
                        SMODS.add_card({ set = 'Tarot', })                            
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
        end
    end
}

SMODS.Joker{ --殭屍化豬布林
    key = "zombiepigman",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = '殭屍化豬布林',
        ['text'] = {
            [1] = '賣掉這張牌時產生',
            [2] = '一張{C:attention}惡魔{}和一張{C:attention}皇后{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.selling_self  and not context.blueprint or context.forcetrigger then
            return {
                func = function()
                    
                    for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                play_sound('timpani')
                                SMODS.add_card({ set = 'Tarot', key = 'c_devil'})                            
                                card:juice_up(0.3, 0.5)
                                return true
                            end
                        }))
                    end
                    delay(0.6)
                    return true
                end,
                extra = {
                    func = function()
                        
                        for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.4,
                                func = function()
                                    play_sound('timpani')
                                    SMODS.add_card({ set = 'Tarot', key = 'c_empress'})                            
                                    card:juice_up(0.3, 0.5)
                                    return true
                                end
                            }))
                        end
                        delay(0.6)
                        return true
                    end,
                    colour = G.C.PURPLE
                }
            }
        end
    end
}

SMODS.Joker{ --豬布獸
    key = "hoglin",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = '豬布獸',
        ['text'] = {
            [1] = '若打出的牌為{C:attention}剛好1張牌{}，',
            [2] = '這張牌計分時點數{C:attention}+2{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if to_big(#context.full_hand) == to_big(1) then
            local scored_card = context.other_card
            G.E_MANAGER:add_event(Event({
                func = function()
                    assert(SMODS.modify_rank(scored_card, 2))
                    return true
                end
            }))
            end
        end
    end
}
SMODS.Joker{ --Piglin Brute
    key = "piglinbrute",
    config = {
        extra = {
            mult = 1,
            scale = 2
        }
    },
    loc_txt = {
        ['name'] = '豬布林蠻兵',
        ['text'] = {
            [1] = '若打出的牌型包含{C:attention}同花順{}',
            [2] = '這張小丑獲得{X:red,C:white}X#2#{}倍率',
            [3] = '{C:inactive}(目前{}{X:red,C:white}X#1#{}{C:inactive}倍率){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 2
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mult, card.ability.extra.scale}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if next(context.poker_hands["Straight Flush"]) then
                return {
                    func = function()
                        card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.scale
                        return true
                    end,
                    message = localize('k_upgrade_ex')
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main then
            return {
                Xmult = card.ability.extra.mult
            }
        end
        if context.forcetrigger then
            return {
                func = function()
                    card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.scale
                    Xmult = card.ability.extra.mult
                    return true
                end
            }
        end
    end
}
SMODS.Joker{ --wither skeleton
    key = "witherskeleton",
    config = {
        extra = {
            scored = 0,
            pb_mult = 5,
            perma_mult = 0
        }
    },
    loc_txt = {
        ['name'] = '凋零骷髏',
        ['text'] = {
            [1] = '打出並計分的{C:spades}黑桃{}牌',
            [2] = '永久獲得{C:red}+#1#{}倍率'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.pb_mult}}
    end,
	
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Spades") then
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.pb_mult
                return {
                    extra = { message = localize('k_upgrade_ex'), colour = G.C.MULT }, card = card
                }
            end
        end
    end
}
SMODS.Joker{ --烈焰使者
    key = "blaze",
    config = {
        extra = {
            odds = 2
        }
    },
    loc_txt = {
        ['name'] = '烈焰使者',
        ['text'] = {
            [1] = '若打出牌型包含{C:attention}三條{}，',
            [2] = '{C:green}#1#/#2#{}機率產生一張{C:attention}火祭{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2, y = 7 -- bulgoe reference
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
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_mcgm_blaze') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if next(context.poker_hands["Three of a Kind"]) then
                if SMODS.pseudorandom_probability(card, 'group_0_22491ffe', 1, card.ability.extra.odds, 'j_mcgm_blaze', false) then
                    for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                play_sound('timpani')
                                SMODS.add_card({ set = 'Spectral', key = 'c_immolate'})                            
                                card:juice_up(0.3, 0.5)
                                return true
                            end
                        }))
                    end
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = created_consumable and localize('k_plus_spectral') or nil, colour = G.C.SECONDARY_SET.Spectral})
                end
            end
        end
    end
}

SMODS.Joker{ --界伏蚌
    key = "shulker",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = '界伏蚌',
        ['text'] = {
            [1] = '商店結束時，',
            [2] = '將所有消耗牌欄位中的牌',
            [3] = '改為{C:dark_edition}負片{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.ending_shop  and not context.blueprint then
			for i, v in pairs(G.consumeables.cards) do
				if not v.edition or not v.edition.negative then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card = v
                        card:set_edition("e_negative", true)
                        card:add_to_deck()
                        return true
                    end
                }))
				end
			end
        end
    end
}
