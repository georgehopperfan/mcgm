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