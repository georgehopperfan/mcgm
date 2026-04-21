SMODS.Joker{ --Sports drink
    key = "sportsdrink",
    config = {
        extra = {
            chips = 150,
            chipsmod = 10
        }
    },
    loc_txt = {
        ['name'] = '寶礦力',
        ['text'] = {
            [1] = '若剩餘出牌數小於{C:blue}2{}，',
            [2] = '{C:blue}+#1#{}籌碼，結算完畢後{C:blue}-#2#{}',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
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
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chips, card.ability.extra.chipsmod}}
    end,
    
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            if to_big(G.GAME.current_round.hands_left) < to_big(2) then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
        if context.after and context.cardarea == G.jokers  and not context.blueprint then
            if to_big(G.GAME.current_round.hands_left) < to_big(2) then
                if to_big(card.ability.extra.chips) > to_big(card.ability.extra.chipsmod) then
                    return {
                        func = function()
                            card.ability.extra.chips = math.max(0, (card.ability.extra.chips) - card.ability.extra.chipsmod)
                            return true
                        end,
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(card.ability.extra.chipsmod), colour = G.C.BLUE})
                    }
                else
                    return {
                        func = function()
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
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Eaten!", colour = G.C.RED})
                        end
                        return true
                    end
                    }
                end
            end
        end
    end
}

SMODS.Joker{ --椰子
    key = "coconut",
    config = {
        extra = {
            hand_size_increase = '1',
            mult = 25
        }
    },
    loc_txt = {
        ['name'] = '椰子',
        ['text'] = {
            [1] = '{C:red}+#1#{}倍率',
            [2] = '{C:attention}-1{}手牌上限'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
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
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(-1)
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(1)
    end
}

SMODS.Joker{ --棒棒糖
    key = "lolipop",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = '棒棒糖',
        ['text'] = {
            [1] = '這張小丑被賣出時，',
            [2] = '賦予兩側的小丑{C:dark_edition}多彩{}及{C:dark_edition}易腐{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'jud' and args.source ~= 'rif' 
            or args.source == 'sho' or args.source == 'buf' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
    end,
    calculate = function(self, card, context)
		if
			(context.selling_self and not context.retrigger_joker and not context.blueprint_card)
		then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i > 1 then
						G.jokers.cards[i - 1]:set_edition({ polychrome = true })
						G.jokers.cards[i - 1]:set_perishable()
					end
					if i < #G.jokers.cards then
						G.jokers.cards[i + 1]:set_edition({ polychrome = true })
						G.jokers.cards[i + 1]:set_perishable()
					end
				end
			end
		end
    end
}
SMODS.Joker{ --奶白金
    key = "fortmilk",
    config = {
        extra = {
            active = 0,
            scale0 = 1,
            rotation0 = 1
        }
    },
    loc_txt = {
        ['name'] = '奶白金',
        ['text'] = {
            [1] = '回合結束時',
            [2] = '若分數未達盲注要求，',
            [3] = '{C:attention}防止死亡{}直到本底注結束，',
            [4] = '並在該底注結束時{C:red}自我摧毀{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.active}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval  and not context.blueprint then
            local target_card = context.other_card
            local function juice_card_until_(card, eval_func, first, delay) -- balatro function doesn't allow for custom scale and rotation
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',delay = delay or 0.1, blocking = false, blockable = false, timer = 'REAL',
                func = (function() if eval_func(card) then if not first or first then card:juice_up(1, 1) end;juice_card_until_(card, eval_func, nil, 0.8) end return true end)
                }))
            end
            return {
                saved = true,
                message = 'milk',
                extra = {
                    func = function()
                    local eval = function() return not G.RESET_JIGGLES end
                        juice_card_until_(card, eval, true)
                        return true
                    end,
                    colour = G.C.WHITE,
                    extra = {
                        func = function()
                            card.ability.extra.active = 1
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            }
        end
        if context.ante_change  and not context.blueprint then
            if to_big(card.ability.extra.active) ~= to_big(0) then
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
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "喝完了!", colour = G.C.RED})
                        end
                        return true
                    end
                }
            end
        end
    end
}

SMODS.Joker{ --潘朵拉的午餐盒
    key = "lunch",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = '潘朵拉的午餐盒',
        ['text'] = {
            [1] = '{X:blue,C:white}=???{}籌碼',
            [2] = '{X:red,C:white}=??{}倍率'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 3,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            local rad_chips = pseudorandom(pseudoseed("mcgm_lunch"), 100, 999)
            local rad_mult = pseudorandom(pseudoseed("mcgm_lunch"), 10, 99)
            return {
                x_chips = 0,
                extra = {
                    chips = rad_chips,
                    colour = G.C.CHIPS,
                    extra = {
                        Xmult = 0,
                        extra = {
                            mult = rad_mult
                        }
                    }
                }
            }
        end
    end
}
SMODS.Joker{ --Bing Bong
    key = "bingbong",
    config = {
        extra = {
            remain = 5,
            joker_slots0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Bing Bong',
        ['text'] = {
            [1] = '{C:green}i am bing bong{} {C:inactive}(#1#){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.remain}}
    end,
    
    calculate = function(self, card, context)
        if context.ante_change  and not context.blueprint then
            if to_big(card.ability.extra.remain) > to_big(1) then
                return {
                    func = function()
                        card.ability.extra.remain = math.max(0, (card.ability.extra.remain) - 1)
                        return true
                    end
                }
            elseif to_big(card.ability.extra.remain) <= to_big(1) then
                return {
                    func = function()
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "You Peaked!", colour = G.C.DARK_EDITION})
                        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                        return true
                    end,
                    extra = {
                        func = function()
                            card.ability.extra.remain = 5
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            end
        end
    end
}
SMODS.Joker{ --Ancient idol
    key = "ancientidol",
    config = {
        extra = {
            slot_change = '1',
            xmult = 3
        }
    },
    loc_txt = {
        ['name'] = '遠古雕像',
        ['text'] = {
            [1] = '{C:red}-1{}消耗牌欄位',
            [2] = '手中的{C:attention}#2#{}給予{X:red,C:white}X#1#{}倍率',
            [3] = '{C:inactive}回合結束時重製點數{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    demicolon_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {lenient_bignum(card.ability.extra.xmult), localize((G.GAME.current_round.idol_card or {}).rank or 'Ace', 'ranks')}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round  then
            if context.other_card:get_id() == G.GAME.current_round.idol_card.id then
                return {
                    Xmult = lenient_bignum(card.ability.extra.xmult)
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            G.GAME.current_round.idol_card.rank = 'Ace'
            local valid_cards = {}
            for k, v in ipairs(G.playing_cards) do
                if not SMODS.has_no_rank(v) then
                    valid_cards[#valid_cards+1] = v
                end
            end
            if valid_cards[1] then 
                local idol_card = pseudorandom_element(valid_cards, pseudoseed('idol'..G.GAME.round_resets.ante))
                G.GAME.current_round.idol_card.rank = idol_card.base.value
                G.GAME.current_round.idol_card.id = idol_card.base.id
            end
        end
		if context.forcetrigger then
            return {
                 Xmult = lenient_bignum(card.ability.extra.xmult)
            }
		end
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = math.max(0, G.consumeables.config.card_limit - 1)
            return true
        end }))
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
            return true
        end }))
    end
}