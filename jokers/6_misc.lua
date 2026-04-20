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
SMODS.Joker{ --Bloon Exclusion Zone (v38-53)
    key = "bez",
    config = {
        extra = {
            scored = 0,
            pb_mult = 6,
            perma_mult = 0
        }
    },
    loc_txt = {
        ['name'] = '氣球禁區',
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
SMODS.Joker{ --Carrier Flagship
    key = "carrierflagship",
    config = {
        extra = {
            chips = 3,
            odds = 3
        }
    },
    loc_txt = {
        ['name'] = '航母旗艦',
        ['text'] = {
            [1] = '打出的{C:clubs}梅花{}被計分時',
            [2] = '有{C:green}#2#/#3#{}機率{X:blue,C:white}X#1#{}籌碼',
            [3] = '{C:inactive}Let\'s go gambling!{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
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
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_mcgm_carrierflagship') 
        return {vars = {card.ability.extra.chips, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Clubs") then
                if SMODS.pseudorandom_probability(card, 'group_0_86561525', 1, card.ability.extra.odds, 'j_mcgm_carrierflagship', false) then
                    return {
                      x_chips = card.ability.extra.chips
                    }
                end
            end
        end
        if context.forcetrigger then
            return {
                x_chips = card.ability.extra.chips
            }
        end
    end
}
SMODS.Joker{ --King George
    key = "kinggeorge",
    config = {
        extra = {
            eor = 3,
            eor_mod = 0.5
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
SMODS.Joker{ --Barracuda
    key = "barracuda",
    config = {
        extra = {
            repetitions = 1
        }
    },
    loc_txt = {
        ['name'] = '梭魚',
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
    cost = 7,
    rarity = 3,
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
