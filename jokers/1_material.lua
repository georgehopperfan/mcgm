
SMODS.Joker{ --木小丑
    key = "wood",
    config = {
        extra = {
            remain = 3
        }
    },
    loc_txt = {
        ['name'] = '木小丑',
        ['text'] = {
            [1] = '接下來的{C:attention}#1#{}個回合開始時',
            [2] = '產生一張隨機小丑'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
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
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.remain}}
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind  then
            if to_big(card.ability.extra.remain) > to_big(0) then
                return {
                    func = function()
                        
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker' })
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
                    end,
                    extra = {
                        func = function()
                            card.ability.extra.remain = math.max(0, (card.ability.extra.remain) - 1)
                            return true
                        end,
                        colour = G.C.RED
                    }
                }
            end
        end
        if context.forcetrigger then
                return {
                    func = function()
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker' })
                                    G.GAME.joker_buffer = 0
                                    return true
                                end
                            }))
                        end
                        if created_joker then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
                        end
                        return true
                    end,
                    extra = {
                        colour = G.C.RED
                    }
                }
        end
    end
}


SMODS.Joker{ --石小丑
    key = "stone",
    config = {
        extra = {
            chips = 50
        }
    },
    loc_txt = {
        ['name'] = '石小丑',
        ['text'] = {
            [1] = '{C:blue}+#1#{} 籌碼'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
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
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chips}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}


SMODS.Joker{ --鐵小丑
    key = "iron",
    config = {
        extra = {
            mult = 15
        }
    },
    loc_txt = {
        ['name'] = '鐵小丑',
        ['text'] = {
            [1] = '{C:red}+#1#{} 倍率'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    demicoloncopmat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{ --金小丑
    key = "gold",
    config = {
        extra = {
            xmult = 3,
            remaining = 32
        }
    },
    loc_txt = {
        ['name'] = '金小丑',
        ['text'] = {
            [1] = '{X:red,C:white}X#1#{}倍率',
            [2] = '打出的牌得分{C:attention}#2#{}次後{C:red}自我摧毀{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult, card.ability.extra.remaining}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if to_big((card.ability.extra.remaining or 0)) <= to_big(0) then
                local target_joker = card
                
                if target_joker then
                    if target_joker.ability.eternal then
                        target_joker.ability.eternal = nil
                    end
                    target_joker.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "壞掉了!", colour = G.C.RED})
                end
            elseif to_big((card.ability.extra.remaining or 0)) > to_big(0) then
                card.ability.extra.remaining = math.max(0, (card.ability.extra.remaining) - 1)
            end
        end
    end
}

SMODS.Joker{ --鑽石小丑
    key = "diamond",
    config = {
        extra = {
            xmult = 2.5
        }
    },
    loc_txt = {
        ['name'] = '鑽石小丑',
        ['text'] = {
            [1] = '{X:red,C:white}X#1#{}倍率'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
    end
}