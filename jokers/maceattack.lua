
SMODS.Joker{ --MACE ATTACK
    key = "maceattack",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'MACE ATTACK',
        ['text'] = {
            -- [1] = '打出並計分的牌中',
            -- [2] = '最高點數和最低點數每差1點',
            -- [3] = '{X:red,C:white}X0.5{}倍率'
            [1] = 'Give {X:red,C:white}X0.5{} Mult for the difference',
            [2] = 'of the highest and lowest',
            [3] = 'scoring card contained in played hand'
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
                    Xmult = 0.5 * lenient_bignum((high - low) or 0)
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