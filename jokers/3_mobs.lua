
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
            mult = 20,
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
        x = 0,
        y = 0
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
            xmult_mod = 0.15,
            xmult = 1
        }
    },
    loc_txt = {
        ['name'] = '終界使者',
        ['text'] = {
            [1] = '回合結束時，',
            [2] = '每個剩餘的棄牌數{X:red,C:white}X#1#{}倍率',
            [3] = '{C:inactive}（目前{}{X:red,C:white}X#2#{}{C:inactive}倍率）{}',
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
        
        return {vars = {card.ability.extra.xmult_mod, card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.xmult = (card.ability.extra.xmult) + (card.ability.extra.xmult_mod * G.GAME.current_round.discards_left)
                    return true
                end,
                message = localize('k_upgrade_ex')
            }
        end
        if context.forcetrigger then
            card.ability.extra.xmult = (card.ability.extra.xmult) + (card.ability.extra.xmult_mod * G.GAME.current_round.discards_left)
            return {
                Xmult = card.ability.extra.xmult
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