SMODS.Joker{ --Green Cookie
    key = "greencookie",
    config = {
        extra = {
            mult = 17,
            multiplier = 1.03
        }
    },
    loc_txt = {
        ['name'] = 'Green Cookie',
        ['text'] = {
            [1] = '{C:red}+#1#{}倍率',
            [2] = '出牌時此數值乘以{C:red}#2#{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
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
        return {vars = {card.ability.extra.mult, card.ability.extra.multiplier}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                local mult_value = card.ability.extra.mult
                card.ability.extra.mult = (card.ability.extra.mult) * card.ability.extra.multiplier
                return {
                    mult = mult_value
                }
        end
    end
}
SMODS.Joker{ --普拿疼
    key = "paracetamol",
    config = {
        extra = {
            blind_size0 = 0.33
        }
    },
    loc_txt = {
        ['name'] = '普拿疼',
        ['text'] = {
            [1] = '{C:attention}-67%{}盲注大小',
            [2] = '{C:inactive,s:0.5}                              積分{}',
            [3] = '{C:inactive,s:0.8}對乙醯氨基酚{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
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
                    if G.GAME.blind.in_blind then
                        G.GAME.blind.chips = G.GAME.blind.chips * 0.33
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        G.HUD_blind:recalculate()
                        return true
                    end
                end
            }
        end
    end
}
SMODS.Joker{ --Iciclez_
    key = "iciclez",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Iciclez_',
        ['text'] = {
            [1] = '進入{C:attention}Boss盲注{}時',
            [2] = '建立兩個{C:attention}小帳{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 6
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
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.setting_blind and G.GAME.blind.boss or context.forcetrigger then
            if true then
                for i = 1, 2 do
                    SMODS.calculate_effect({func = function()
                        
                        local created_joker = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_mcgm_iciclezalt' })
                                if joker_card then
                                    
                                    
                                end
                                
                                return true
                            end
                        }))
                        
                        if created_joker then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
                        end
                        return true
                    end}, card)
                end
            end
        end
    end
}

SMODS.Joker{ --Iciclez_ alt
    key = "iciclezalt",
    config = {
		extra = {
			mult = 1.1,
			slots = 1
		}
    },
    loc_txt = {
        ['name'] = 'Iciclez_小帳',
        ['text'] = {
            [1] = '{X:red,C:white}X#1#{}倍率',
            [2] = '{C:dark_edition}+#2#{}小丑牌欄位'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 1,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 2,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
	
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult, card.ability.extra.slots}}
    end,
	
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    Xmult = lenient_bignum(card.ability.extra.mult)
                }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_mcgm_iciclezalt" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
	if e.config.ref_table.config.center.key == "j_mcgm_iciclezalt" then
		e.config.colour = G.C.GREEN
		e.config.button = "use_card"
	else
		can_select_card_ref(e)
	end
end

SMODS.Joker{ --Chocolatebar Quotes
    key = "chocolatebarquotes",
    config = {
    },
    loc_txt = {
        ['name'] = 'Chocolatebar名言',
        ['text'] = {
            [1] = 'In today\'s {C:attention}video{}, {C:attention}five{} of my friends',
            [2] = 'try {C:attention}hunt{} me down and {C:attention}stop{} me',
            [3] = 'from beating {C:attention}Minecraft{}.',
            [4] = 'Can they stop me from beating the',
            [5] = '{C:dark_edition}ender dragon{} or will I {C:attention}survive{}?',
            [6] = 'This is it, {C:blue}Minecraft manhunt versus 5 hunters{},',
            [7] = 'the finale. Also, only a {C:green}small percentage{}',
            [8] = 'of people that watch my videos',
            [9] = 'are actually {C:attention}subscribed{}, so consider subscribing.',
            [10] = 'it\'s {C:green}free{} and you can always change your mind later.',
            [11] = '{C:attention}Enjoy.{}',
            [12] = '{C:inactive}實際效果:每個cbqpl的Chocolatebar名言提供+1倍率{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 8,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
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
                return {
                    mult = 72
                }
        end
    end
}

if Cryptid then
SMODS.Joker{ --Mabel
    key = "mabel",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = '梅寶',
        ['text'] = {
            [1] = '打出牌結算前，所有小丑的數值',
            [2] = '隨機改為目前數值的{C:attention}X0.8{}到{C:attention}X1.28{}倍'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 5
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
    
    calculate = function(self, card, context)
        if (context.cardarea == G.jokers and context.before) or context.forcetrigger then
            local result = pseudorandom(pseudoseed("mcgm_mabel"), 80, 128)
            local check = false
            for i = 1, #G.jokers.cards do
                if not (G.jokers.cards[i] == card) then
                    if not Card.no(G.jokers.cards[i], "immutable", true) then
                        check = true
						Cryptid.manipulate(G.jokers.cards[i], { value = result / 100 })
                    end
                end
            end
            if check then
                card_eval_status_text(card, "extra", nil, nil, nil, { message = "X"..tostring(result / 100), colour = G.C.GREEN })
            end
        end
    end
}
end
SMODS.Joker{ --Loaf
    key = "loaf",
    config = {
        extra = {
            chips_mod = 5,
            chips = 0,
        }
    },
    loc_txt = {
        ['name'] = '洛夫',
        ['text'] = {
            [1] = '回合結束時，每個剩餘的出牌和棄牌',
            [2] = '為這張小丑提供{C:blue}+#1#{}籌碼',
            [3] = '{C:inactive}(目前{}{C:blue}+#2#{}{C:inactive}籌碼){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 5
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
        
        return {vars = {card.ability.extra.chips_mod, card.ability.extra.chips}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            local chips_value = card.ability.extra.chips
            return {
                func = function()
                    card.ability.extra.chips = (card.ability.extra.chips) + ((G.GAME.current_round.hands_left or 0) + (G.GAME.current_round.discards_left or 0)) * card.ability.extra.chips_mod
                    return true
                end,
                message = localize('k_upgrade_ex')
            }
        end
        if context.forcetrigger then
            card.ability.extra.chips = (card.ability.extra.chips) + ((G.GAME.current_round.hands_left or 0) + (G.GAME.current_round.discards_left or 0)) * card.ability.extra.chips_mod
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

SMODS.Joker{ --Tom
    key = "tom",
    config = {
        extra = {
            mult_mod = 1.5,
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = '湯姆',
        ['text'] = {
            [1] = '打出的牌{C:attention}4{}計分時，',
            [2] = '這張小丑獲得{C:red}+#1#{}倍率',
            [3] = '{C:inactive}(目前{}{C:red}+#2#{}{C:inactive}倍率){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 5
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
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if context.other_card:get_id() == 4 then
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

SMODS.Joker{ --Ellen
    key = "ellen",
    config = {
        extra = {
            xmult = 3
        }
    },
    loc_txt = {
        ['name'] = '艾倫',
        ['text'] = {
            [1] = '若打出的牌型為',
            [2] = '本回合首次打出，',
            [3] = '{X:red,C:white}X#1#{}倍率'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 5
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
        
        return {vars = {card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if not (G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1) then
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
SMODS.Joker{ --King George
    key = "kinggeorge",
    config = {
        extra = {
            eor = 3,
            eor_mod = 0.3
        }
    },
    loc_txt = {
        ['name'] = '喬治國王',
        ['text'] = {
            [1] = '回合結束時賺取{C:gold}$#1#{}',
            [2] = '打出的{C:diamonds}方塊{}牌計分時此數值{C:gold}+$#2#{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
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
        
        return {vars = {lenient_bignum(card.ability.extra.eor), lenient_bignum(card.ability.extra.eor_mod)}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if context.other_card:is_suit("Diamonds") then
                return {
                    func = function()
                    card.ability.extra.eor = lenient_bignum(card.ability.extra.eor) + lenient_bignum(card.ability.extra.eor_mod)
                    return true
                end,
                    message = localize('k_upgrade_ex'),
                    extra = {
                        colour = G.C.MONEY
                    }
                }
            end
        end
        if context.forcetrigger then
            card.ability.extra.eor = lenient_bignum(card.ability.extra.eor) + lenient_bignum(card.ability.extra.eor_mod)
                return {
                    dollars = lenient_bignum(card.ability.extra.eor),
                }
        end
    end,

    calc_dollar_bonus = function(self, card)
        if to_big(card.ability.extra.eor) > to_big(0) then
            return lenient_bignum(card.ability.extra.eor)
        end
    end
}
SMODS.Joker{ --Samurai
    key = "samurai",
    config = {
        extra = {
            xmult = 7,
            scored = 0
        }
    },
    loc_txt = {
        ['name'] = '武士',
        ['text'] = {
            [1] = '每{C:attention}7{}張牌計分時{X:red,C:white}X#1#{}倍率',
            [2] = '{C:inactive}(目前#2#/7){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7, y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult, card.ability.extra.scored}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if to_big((card.ability.extra.scored or 0)) < to_big(6) then
                card.ability.extra.scored = (card.ability.extra.scored) + 1
                return {
                    message = "domp"
                }
            else
                card.ability.extra.scored = 0
                return {
                    Xmult = card.ability.extra.xmult
                }
            end
        end
    end
}
SMODS.Joker{ --Stupid Owl Stall
    key = "stupidowlstall",
    config = {
        extra = {
            hands = 1,
            chips = 0,
            odds = 2,
            round = 0
        }
    },
    loc_txt = {
        ['name'] = 'Stupid Owl Stall',
        ['text'] = {
            [1] = '出牌時有{C:green}#4#/#5#{}機率',
            [2] = '{C:blue}+#1#{}出牌次數並{X:blue,C:white}X#2#{}籌碼'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 9,
        y = 5
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
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_mcgm_stupidowlstall') 
        return {vars = {card.ability.extra.hands, card.ability.extra.chips, card.ability.extra.round, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_e9967624', 1, card.ability.extra.odds, 'j_mcgm_stupidowlstall', false) then
              SMODS.calculate_effect({x_chips = card.ability.extra.chips}, card)
                        SMODS.calculate_effect({func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.hands).." Hand", colour = G.C.GREEN})
                G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.hands
                return true
            end}, card)
          end
            end
        end
    end
}

if Cryptid then
SMODS.Joker{ --Ninja Kiwi balance be like
    key = "nksucks",
    config = {
        extra = {
            version = 53
        }
    },
    loc_txt = {
        ['name'] = 'Ninja Kiwi 平衡 be like',
        ['text'] = {
            [1] = '回合結束時，若這張小丑兩側的小丑的數值均可調整，',
            [2] = '{C:attention}左邊小丑{}數值{C:attention}砍半{}，{C:attention}右邊小丑{}數值{C:attention}翻倍{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 2
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

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.version}}
    end,
    
	calculate = function(self, card, context)
		if
			(context.end_of_round and not context.repetition and not context.individual and not context.blueprint)
			or context.forcetrigger
		then
			local check = false
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i < #G.jokers.cards and i >1 then
						if not (Card.no(G.jokers.cards[i + 1], "immutable", true) or Card.no(G.jokers.cards[i - 1], "immutable", true)) then
							check = true
							Cryptid.manipulate(G.jokers.cards[i + 1], { value = 2 })
							Cryptid.manipulate(G.jokers.cards[i - 1], { value = 0.5 })
						end
					end
				end
			end
			if check then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = 'update is out!', colour = G.C.GREEN }
				)
			end
		end
	end
}
end
SMODS.Joker{ --Ten the purples
    key = "tenthepurples",
    config = {
    },
    loc_txt = {
        ['name'] = 'Ten the purples',
        ['text'] = {
            [1] = '選擇{C:attention}Boss盲注{}時，',
            [2] = '{C:attention}取消{}盲注效果並{C:red}X2{}盲注大小'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 3
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
        if context.setting_blind  and not context.blueprint then
            if G.GAME.blind.boss then
                return {
                    func = function()
                        if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.GAME.blind:disable()
                                    play_sound('timpani')
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled'), colour = G.C.GREEN})
                        end
                        return true
                    end,
                    extra = {
                        
                        func = function()
                            if G.GAME.blind.in_blind then
                                G.GAME.blind.chips = G.GAME.blind.chips * 2
                                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                                G.HUD_blind:recalculate()
                                return true
                            end
                        end,
                        colour = G.C.GREEN
                    }
                }
            end
        end
    end
}
