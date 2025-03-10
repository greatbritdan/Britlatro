local modpath = ""..SMODS.current_mod.path

SMODS.Atlas{key = 'Jokers', path = 'Jokers.png', px = 71, py = 95}
SMODS.Atlas{key = 'Tarots', path = 'Tarots.png', px = 71, py = 95}
SMODS.Atlas{key = 'Planets', path = 'Planets.png', px = 71, py = 95}
SMODS.Atlas{key = 'Boosters', path = 'Boosters.png', px = 71, py = 95}
SMODS.Atlas{key = 'TagCards', path = 'TagCards.png', px = 71, py = 95}
SMODS.Atlas{key = 'Vouchers', path = 'Vouchers.png', px = 71, py = 95}
SMODS.Atlas{key = 'Spectrals', path = 'Spectrals.png', px = 71, py = 95}
SMODS.Atlas{key = 'Tags', path = 'Tags.png', px = 34, py = 34}
SMODS.Atlas{key = "modicon", path = "modicon.png", px = 32, py = 32}
SMODS.Atlas{key = "Enhancers", path = "Enhancers.png", px = 71, py = 95}

function BRT_Give_Tag(tag)
    add_tag(Tag(tag))
    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
end

G.C.TAGCARD = HEX("78859C")
G.C.BRITLATRO = HEX("415E9C")

-- JOKERS --

-- Rigged :)
BRIT_SLOTMACHINECHIPS = {1,1,2,5,5,10,10,25,25,50,100,250,999}
BRIT_SLOTMACHINEMULT = {1,1,2,5,5,10,10,15,20,25,50,99}

function reset_slotmachine_card()
    G.GAME.current_round.slotmachinechips = BRIT_SLOTMACHINECHIPS[math.random(1, #BRIT_SLOTMACHINECHIPS)]
    G.GAME.current_round.slotmachinemult = BRIT_SLOTMACHINEMULT[math.random(1, #BRIT_SLOTMACHINEMULT)]
end

BRIT_VALID_TAGS = {
    tag_uncommon=1,tag_rare=1,tag_foil=1,tag_holo=1,tag_polychrome=1,tag_investment=1,tag_voucher=1,tag_boss=1,
    tag_handy=1,tag_garbage=1,tag_coupon=1,tag_double=1,tag_juggle=1,tag_d_six=1,tag_top_up=1,tag_brit_grabber=1,tag_brit_wasteful=1
}
BRIT_TAGS_TO_TAGCARD = {
    tag_uncommon='c_brit_uncommoner',tag_rare='c_brit_rarer',tag_foil='c_brit_foiler',tag_holo='c_brit_holoer',tag_polychrome='c_brit_chromer',
    tag_investment='c_brit_invester',tag_voucher='c_brit_claimer',tag_boss='c_brit_roller',tag_handy='c_brit_handler',tag_garbage='c_brit_discarder',
    tag_coupon='c_brit_thrifter',tag_double='c_brit_doubler',tag_juggle='c_brit_reacher',tag_d_six='c_brit_clearer',tag_top_up='c_brit_creator',
    tag_brit_grabber='c_brit_grabber',tag_brit_wasteful='c_brit_waster'
}

function BRT_Joker_Vars(s,info_queue,card)
    local name = card.ability.name
    if name == 'j_brit_steppingstones' then return {vars={card.ability.extra.chips,card.ability.extra.chips_mod}}
    elseif name == 'j_brit_runningrocks' then return {vars={card.ability.extra.mult,card.ability.extra.mult_mod}}
    elseif name == 'j_brit_concrete' then return {vars={card.ability.extra.mult}}
    elseif name == 'j_brit_jimbobooster' then return {vars={card.ability.extra}}
    elseif name == 'j_brit_peeledseal' then
        local mult = card.ability.extra.Xmult-(card.ability.seal_tally*card.ability.extra.Xmult_mod)
        if mult < 1 then mult = 1 end
        return {vars={mult,card.ability.extra.Xmult_mod}}
    elseif name == 'j_brit_bruhman' then return {vars={card.ability.extra.basemult,card.ability.extra.mult}}
    elseif name == 'j_brit_unionjack' then
        local mult = card.ability.extra.Xmult + (card.ability.extra.Xmult_mod*card.ability.jack_tally)
        return {vars={card.ability.extra.Xmult_mod,mult}}
    elseif name == 'j_brit_wildjoker' then return {vars={card.ability.extra}}
    elseif name == 'j_brit_united' then return {vars={card.ability.extra}}
    elseif name == 'j_brit_slotmachine' then return {vars={G.GAME.current_round.slotmachinechips,G.GAME.current_round.slotmachinemult}}
    elseif name == 'j_brit_red_joker' then return {vars={card.ability.extra, card.ability.extra*((G.deck and G.deck.cards) and #G.deck.cards or 52)}}
    elseif name == 'j_brit_rekoj' then return {vars={card.ability.extra.mult,''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds}}
    elseif name == 'j_brit_lastteabag' then return {vars={card.ability.extra}}
    elseif name == 'j_brit_britdan' then
        info_queue[#info_queue+1] = G.P_CENTERS.m_brit_copper
        return {vars={card.ability.extra}}
    elseif name == 'j_brit_sixpence' then
        info_queue[#info_queue+1] = G.P_CENTERS.m_brit_copper
        return {vars={}}
    elseif name == 'j_brit_hopscotch' then return {vars={card.ability.extra.chips_mod,card.ability.extra.chips}}
    elseif name == 'j_brit_dentures' then
        info_queue[#info_queue+1] = G.P_CENTERS.m_gold
        info_queue[#info_queue+1] = G.P_SEALS.Gold
        return {vars={card.ability.extra.mult_mod,card.ability.extra.mult}}
    elseif name == 'j_brit_vat' then return {vars={card.ability.extra.dollar_mod}}
    elseif name == 'j_brit_tagteam' then return {vars={localize('Two Pair','poker_hands')}}
    elseif name == 'j_brit_fridgemagnet' then return {vars={card.ability.extra.mult_mod,card.ability.extra.mult}}
    elseif name == 'j_brit_vouchablejoker' then return {vars={card.ability.extra.Xmult_mod,card.ability.extra.Xmult}}
    else return {vars={}}
    end
end

function BRT_Joker_Calculate(s,card,context)
    local name = card.ability.name
    if context.joker_main then
        if name == 'j_brit_steppingstones' then
            return { chips=card.ability.extra.chips }
        end
        if name == 'j_brit_peeledseal' then
            local mult = card.ability.extra.Xmult-(card.ability.seal_tally*card.ability.extra.Xmult_mod)
            if mult < 1 then mult = 1 end
            return { Xmult_mod=mult, message=localize{type='variable', key='a_xmult', vars={mult}} }
        end
        if name == 'j_brit_bruhman' then
            local mult = card.ability.extra.mult
            if mult < 1 then mult = 1 end
            return { mult_mod=mult, message=localize{type='variable', key='a_mult', vars={mult}} }
        end
        if name == 'j_brit_unionjack' then
            local mult = card.ability.extra.Xmult+(card.ability.extra.Xmult_mod*card.ability.jack_tally)
            return { Xmult_mod=mult, message=localize{type='variable', key='a_xmult', vars={mult}} }
        end
        if name == 'j_brit_slotmachine' then
            local chipmod = G.GAME.current_round.slotmachinechips
            local multmod = G.GAME.current_round.slotmachinemult
            return { chip_mod=chipmod, mult_mod=multmod, message="Cash Out!" }
        end
        if name == 'j_brit_red_joker' then
            local mult = card.ability.extra
            if G.deck and G.deck.cards then
                mult = mult*((G.deck and G.deck.cards) and #G.deck.cards or 52)
            end
            return { mult_mod=mult, message=localize{type='variable', key='a_mult', vars={mult}} }
        end
        if name == 'j_brit_rekoj' then
            return { Xmult_mod=card.ability.extra.mult, message=localize{type='variable', key='a_xmult', vars={card.ability.extra.mult}} }
        end
        if name == 'j_brit_hopscotch' then
            if card.ability.extra.chips > 0 then
                return { chips=card.ability.extra.chips }
            end
        end
        if name == 'j_brit_dentures' then
            if card.ability.extra.mult > 0 then
                return { mult_mod=card.ability.extra.mult, message=localize{type='variable', key='a_mult', vars={card.ability.extra.mult}} }
            end
        end
        if name == 'j_brit_tagteam' and (next(context.poker_hands['Two Pair']) or next(context.poker_hands['Full House'])) then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                        local tagcard = create_card('TagCard',G.consumeables, nil, nil, nil, nil, nil, 'tg1')
                        tagcard:add_to_deck()
                        G.consumeables:emplace(tagcard)
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)}))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_brit_tagcard_add'), colour = G.C.TAGCARD})
            end
        end
        if name == 'j_brit_fridgemagnet' then
            if card.ability.extra.mult > 0 then
                return { mult_mod=card.ability.extra.mult, message=localize{type='variable', key='a_mult', vars={card.ability.extra.mult}} }
            end
        end
        if name == 'j_brit_vouchablejoker' then
            return { Xmult_mod=card.ability.extra.Xmult, message=localize{type='variable', key='a_xmult', vars={card.ability.extra.Xmult}} }
        end
    elseif context.final_scoring_step then
        if name == 'j_brit_rekoj' and (not context.blueprint) then
            if pseudorandom('rekoj') < G.GAME.probabilities.normal/card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true
                            end
                        }))
                        return true
                    end
                })) 
                return { message = localize('k_extinct_ex') }
            else
                return { message = localize('k_safe_ex') }
            end
        end
    elseif context.skip_blind then
        if name == 'j_brit_hopscotch' and (not context.blueprint) then
            G.E_MANAGER:add_event(Event({func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips_mod}},
                    colour = G.C.CHIPS,
                    card = card
                })
                return true
            end}))
        end
    elseif context.discard then
        if name == 'j_brit_lastcrumpet' and (not context.blueprint)
        and G.GAME.current_round.discards_left <= 1 and #context.full_hand == 1 then
            for k, v in ipairs(context.full_hand) do
                local cen_pool = {}
                for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                    if v.key ~= 'm_stone' then 
                        cen_pool[#cen_pool+1] = v
                    end
                end
                v:set_ability(pseudorandom_element(cen_pool, pseudoseed('last_crumpet')), nil, true)

                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:juice_up()
                        return true
                    end
                }))
            end
        end
    elseif context.buying_card then
        if name == 'j_brit_vat' and context.card.ability.set == 'Joker' and card ~= context.card then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.dollar_mod
            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
        if name == 'j_brit_vouchablejoker' and context.card.ability.set == 'Voucher' then
            local count = G.GAME.current_round.vouchers_used or 0
            local newxmult = 1 + (card.ability.extra.Xmult_mod * count)
            G.E_MANAGER:add_event(Event({func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize{type = 'variable', key = 'a_xmult', vars = {newxmult}},
                    colour = G.C.MULT,
                    card = card
                })
                return true
            end}))
        end
    end
    if context.individual and context.cardarea == G.hand and (not context.end_of_round) then
        if name == "j_brit_britdan" and context.other_card.ability.name == "m_brit_copper" then
            return { Xmult_mod=card.ability.extra, message=localize{type='variable', key='a_xmult', vars={card.ability.extra}}, card=card }
        end
    elseif context.individual and context.cardarea == G.play then
        if name == 'j_brit_concrete' and context.other_card.ability.effect == 'Stone Card' then
            return { mult=card.ability.extra.mult, card=card }
        end
        if name == 'j_brit_wildjoker' and context.other_card.ability.effect == 'Wild Card' then
            return { dollars=card.ability.extra, card=card }
        end
    elseif context.other_joker then
        if name == 'j_brit_united' and string.find(context.other_joker.ability.name, "j_brit") and card ~= context.other_joker then
            G.E_MANAGER:add_event(Event({
                func = function()
                    context.other_joker:juice_up(0.5, 0.5)
                    return true
                end
            })) 
            return { Xmult_mod=card.ability.extra, message=localize{type='variable', key='a_xmult', vars={card.ability.extra}} }
        end
    else
        if context.cardarea == G.jokers then
            if context.before then
                if name == 'j_brit_sixpence' then
                    local affected = {}
                    for k, v in ipairs(context.scoring_hand) do
                        if v:get_id() == 14 or v:get_id() == 6 then
                            affected[#affected+1] = v
                            v:set_ability(G.P_CENTERS.m_brit_copper, nil, true)
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    v:juice_up()
                                    return true
                                end
                            }))
                        end
                    end
                    if #affected > 0 then
                        return { message="Copper", colour=G.C.ORANGE, card=card }
                    end
                end
                if name == 'j_brit_steppingstones' and (not context.blueprint) then
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
                    return { message=localize('k_upgrade_ex'), colour=G.C.CHIPS, card=card }
                end
                if name == 'j_brit_runningrocks' and (not context.blueprint) then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                    return { message=localize('k_upgrade_ex'), colour=G.C.MULT, card=card }
                end
            end
        end
    end
end

function BRT_New_Joker(args)
    local blueprint_compat = true
    if args.blueprint_compat ~= nil then blueprint_compat = args.blueprint_compat end
    local temp = {key=args.key, atlas='Jokers', pos=args.pos, rarity=args.rarity, cost=args.rarity*2, config=args.config,
    unlocked=true, discovered=false, blueprint_compat=blueprint_compat, eternal_compat=true, perishable_compat=true}
    temp.in_pool =   function(s,w1,w2) return true end
    temp.calculate = function (s,card,context) return BRT_Joker_Calculate(s,card,context) end
    temp.loc_vars =  function (s,info_queue,card) return BRT_Joker_Vars(s,info_queue,card) end
    temp.joker_display_def = args.joker_display_def

    temp.calc_dollar_bonus = args.calc_dollar_bonus
    temp.add_to_deck = args.add_to_deck
    temp.remove_from_deck = args.remove_from_deck
    temp.update = args.update
    temp.soul_pos = args.soul_pos

    return temp
end

SMODS.Joker(BRT_New_Joker{key='steppingstones', rarity=1, pos={x=0,y=0}, config={extra={chips=0, chips_mod=5}},
    joker_display_def = function (JokerDisplay)
        return {
            text = {{ text = "+" }, { ref_table = "card.ability.extra", ref_value = "chips" }},
            text_config = { colour = G.C.CHIPS }
        }
    end
})

SMODS.Joker(BRT_New_Joker{key='concrete', rarity=1, pos={x=1,y=0}, config={extra={mult=5}},
    joker_display_def = function (JokerDisplay)
        return {
            text = {{ text = "+" }, { ref_table = "card.joker_display_values", ref_value = "mult" }},
            text_config = { colour = G.C.MULT },
            reminder_text = {{ text = "(Stone Cards)" }},
            calc_function = function(card)
                local mult = 0
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= 'Unknown' then
                    for _, scoring_card in pairs(scoring_hand) do
                        if scoring_card.ability.effect == 'Stone Card' then
                            mult = mult + (card.ability.extra.mult * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand))
                        end
                    end
                end
                card.joker_display_values.mult = mult
            end
        }
    end
})

SMODS.Joker(BRT_New_Joker{key='peeledseal', rarity=3, pos={x=3,y=0}, config={extra={Xmult=3,Xmult_mod=0.2}},
    update = function (s, card, dt)
        card.ability.seal_tally = 0
        if G.STAGE == G.STAGES.RUN then
            for k, v in pairs(G.playing_cards) do
                if v.seal then card.ability.seal_tally = card.ability.seal_tally+1 end
            end
        end
    end,
    joker_display_def = function (JokerDisplay)
        return {
            text = {{ border_nodes = {{ text = "X" }, { ref_table = "card.joker_display_values", ref_value = "xmult" }}}},
            calc_function = function(card)
                local xmult = card.ability.extra.Xmult - (card.ability.seal_tally * card.ability.extra.Xmult_mod)
                if xmult < 1 then xmult = 1 end
                card.joker_display_values.xmult = xmult
            end
        }
    end
})

SMODS.Joker(BRT_New_Joker{key='jimbobooster', rarity=1, pos={x=2,y=0}, config={extra=1}, blueprint_compat=false,
    add_to_deck = function(s, card, from_debuff)
        G.GAME.modifiers.booster_packs = (G.GAME.modifiers.booster_packs or 2) + card.ability.extra
    end,
    remove_from_deck = function(s, card, from_debuff)
        G.GAME.modifiers.booster_packs = (G.GAME.modifiers.booster_packs or 2) - card.ability.extra
    end,
})

SMODS.Joker(BRT_New_Joker{key='bruhman', rarity=1, pos={x=0,y=1}, config={extra={mult=30, basemult=30}},
    update = function (s, card, dt)
        card.ability.extra.mult = card.ability.extra.basemult
        if G.jokers and G.jokers.cards then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].edition and G.jokers.cards[i].edition.negative then
                    card.ability.extra.mult = 0
                    return
                end
            end
        end
    end,
    joker_display_def = function (JokerDisplay)
        return {
            text = {{ text = "+" }, { ref_table = "card.ability.extra", ref_value = "mult" }},
            text_config = { colour = G.C.MULT },
        }
    end
})

SMODS.Joker(BRT_New_Joker{key='unionjack', rarity=2, pos={x=1,y=1}, config={extra={Xmult=1,Xmult_mod=0.2}},
    update = function (s, card, dt)
        card.ability.jack_tally = 0
        if G.STAGE == G.STAGES.RUN then
            for k, v in pairs(G.playing_cards) do
                if v:get_id() == 11 then card.ability.jack_tally = card.ability.jack_tally+1 end
            end
        end
    end,
    joker_display_def = function (JokerDisplay)
        return {
            text = {{ border_nodes = {{ text = "X" }, { ref_table = "card.joker_display_values", ref_value = "xmult" }}}},
            calc_function = function(card)
                local xmult = card.ability.extra.Xmult + (card.ability.jack_tally * card.ability.extra.Xmult_mod)
                if xmult < 1 then xmult = 1 end
                card.joker_display_values.xmult = xmult
            end
        }
    end
})

SMODS.Joker(BRT_New_Joker{key='wildjoker', rarity=1, pos={x=2,y=1}, config={extra=3},
    joker_display_def = function (JokerDisplay)
        return {
            text = {{ text = "+$" }, { ref_table = "card.joker_display_values", ref_value = "dollars" }},
            text_config = { colour = G.C.MONEY },
            reminder_text = {{ text = "(Wild Cards)" }},
            calc_function = function(card)
                local dollars = 0
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= 'Unknown' then
                    for _, scoring_card in pairs(scoring_hand) do
                        if scoring_card.ability.effect == 'Wild Card' then
                            dollars = dollars + (card.ability.extra * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand))
                        end
                    end
                end
                card.joker_display_values.dollars = dollars
            end
        }
    end
})

SMODS.Joker(BRT_New_Joker{key='united', rarity=3, pos={x=3,y=1}, config={extra=1.5},
    joker_display_def = function (JokerDisplay)
        return {
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "count",          colour = G.C.ORANGE },
                { text = "x" },
                { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.BRITLATRO },
                { text = ")" },
            },
            calc_function = function(card)
                local count = -1 -- Doesnt count itself
                if G.jokers then
                    for _, joker_card in ipairs(G.jokers.cards) do
                        if string.find(joker_card.ability.name, "j_brit") then
                            count = count + 1
                        end
                    end
                end
                card.joker_display_values.count = count
                card.joker_display_values.localized_text = "Britlatro"
            end,
            mod_function = function(card, mod_joker)
                return { x_mult = (string.find(mod_joker.ability.name, "j_brit") and mod_joker.ability.extra ^ JokerDisplay.calculate_joker_triggers(mod_joker) or nil) }
            end
        }
    end
})

SMODS.Joker(BRT_New_Joker{key='slotmachine', rarity=1, pos={x=0,y=2}, config={},
    joker_display_def = function (JokerDisplay)
        return {
            text = {
                { text = "+", colour = G.C.CHIPS }, { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS },
                { text = " +", colour = G.C.MULT }, { ref_table = "card.joker_display_values", ref_value = "mult", colour = G.C.MULT },
            },
            calc_function = function(card)
                card.joker_display_values.chips = G.GAME.current_round.slotmachinechips
                card.joker_display_values.mult = G.GAME.current_round.slotmachinemult
            end
        }
    end
})

SMODS.Joker(BRT_New_Joker{key='red_joker', rarity=1, pos={x=1,y=2}, config={extra=0.25},
    joker_display_def = function (JokerDisplay)
        return {
            text = {{ text = "+" }, { ref_table = "card.joker_display_values", ref_value = "mult" }},
            text_config = { colour = G.C.MULT },
            calc_function = function(card)
                card.joker_display_values.mult = card.ability.extra*((G.deck and G.deck.cards) and #G.deck.cards or 52)
            end
        }
    end
})

SMODS.Joker(BRT_New_Joker{key='rekoj', rarity=2, pos={x=2,y=2}, config={extra={mult=4,odds=12}},
    joker_display_def = function (JokerDisplay)
        return {
            text = {{ border_nodes = {{ text = "X" }, { ref_table = "card.ability.extra", ref_value = "mult" }}}},
            text_config = { colour = G.C.MULT },
            extra = {{ { text = "(" }, { ref_table = "card.joker_display_values", ref_value = "odds" }, { text = ")" } }},
            extra_config = { colour = G.C.GREEN, scale = 0.3 },
            calc_function = function(card)
                card.joker_display_values.odds = localize{ type = 'variable', key = "jdis_odds", vars = {
                    (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds
                }}
            end
        }
    end
})

SMODS.Joker(BRT_New_Joker{key='lastteabag', rarity=2, pos={x=3,y=2}, config={extra=10},
    calc_dollar_bonus = function(s, card)
        if G.GAME.current_round.hands_left == 0 then
            return card.ability.extra
        end
    end
})

SMODS.Joker(BRT_New_Joker{key='sixpence', rarity=1, pos={x=2,y=3}, config={},
    joker_display_def = function (JokerDisplay)
        return { reminder_text = {{ text = "(Aces, 6s)" }} }
    end,
})

SMODS.Joker(BRT_New_Joker{key='hopscotch', rarity=2, pos={x=3,y=3}, config={extra={chips=0, chips_mod=50}},
    joker_display_def = function (JokerDisplay)
        return {
            text = {{ text = "+" }, { ref_table = "card.ability.extra", ref_value = "chips" }},
            text_config = { colour = G.C.CHIPS }
        }
    end,
    update = function (s, card, dt)
        if G.STAGE == G.STAGES.RUN then
            card.ability.extra.chips = G.GAME.skips*card.ability.extra.chips_mod
        end
    end
})

SMODS.Joker(BRT_New_Joker{key='lastcrumpet', rarity=2, pos={x=0,y=4}, config={shaking=false},
    update = function (s, card, dt)
        if G.GAME and G.GAME.current_round and G.GAME.current_round.discards_left <= 1 then
            if not card.ability.shaking then
                local eval = function(c) return G.GAME.current_round.discards_left > 0 and not G.RESET_JIGGLES end
                juice_card_until(card, eval, true)
                card.ability.shaking = true
            end
        else
            card.ability.shaking = false
        end
    end
})

--[[SMODS.Joker(BRT_New_Joker{key='dentures', rarity=2, pos={x=1,y=4}, config={extra={mult=0, mult_mod=3}},
    update = function (s, card, dt)
        card.ability.extra.mult = 0
        if G.STAGE == G.STAGES.RUN then
            for k, v in pairs(G.playing_cards) do
                if v.ability.effect == 'Gold Card' or v.seal == "Gold" then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                end
            end
        end
    end,
    joker_display_def = function (JokerDisplay)
        return {
            text = {{ text = "+" }, { ref_table = "card.ability.extra", ref_value = "mult" }},
            text_config = { colour = G.C.MULT }
        }
    end
})]]

SMODS.Joker(BRT_New_Joker{key='vouchablejoker', rarity=3, pos={x=1,y=4}, config={extra={Xmult=1,Xmult_mod=0.25}},
    update = function (s, card, dt)
        local count = G.GAME.current_round.vouchers_used or 0
        card.ability.extra.Xmult = 1 + (card.ability.extra.Xmult_mod * count)
    end,
    joker_display_def = function (JokerDisplay)
        return {
            text = {{ border_nodes = {{ text = "X" }, { ref_table = "card.joker_display_values", ref_value = "xmult" }}}},
            calc_function = function(card)
                local count = G.GAME.current_round.vouchers_used or 0
                local xmult = 1 + (card.ability.extra.Xmult_mod * count)
                if xmult < 1 then xmult = 1 end
                card.joker_display_values.xmult = xmult
            end
        }
    end
})

SMODS.Joker(BRT_New_Joker{key='vat', rarity=1, pos={x=2,y=4}, config={extra={dollar_mod=3}},
    joker_display_def = function (JokerDisplay)
        return {
            reminder_text = {{ text = "(" }, { text = "$", colour = G.C.GOLD }, { ref_table = "card", ref_value = "sell_cost", colour = G.C.GOLD }, { text = ")" }},
            reminder_text_config = { scale = 0.35 }
        }
    end
})

SMODS.Joker(BRT_New_Joker{key='tagteam', rarity=1, pos={x=3,y=4}, config={},
    joker_display_def = function (JokerDisplay)
        return {
            reminder_text = {{ text = "(" }, { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE }, { text = ")" }},
            calc_function = function(card)
                card.joker_display_values.localized_text = localize('Two Pair', 'poker_hands')
            end
        }
    end
})

SMODS.Joker(BRT_New_Joker{key='fridgemagnet', rarity=2, pos={x=0,y=5}, config={extra={mult=0,mult_mod=5}},
    update = function (s, card, dt)
        local notags = G.GAME and G.GAME.tags and #G.GAME.tags or 0
        card.ability.extra.mult = notags * card.ability.extra.mult_mod
    end,
    joker_display_def = function (JokerDisplay)
        return {
            text = {{ text = "+" }, { ref_table = "card.ability.extra", ref_value = "mult" }},
            text_config = { colour = G.C.MULT }
        }
    end
})

SMODS.Joker(BRT_New_Joker{key='britdan', rarity=4, pos={x=0,y=3}, soul_pos={x=1,y=3}, config={extra=2},
    joker_display_def = function (JokerDisplay)
        return {
            text = {{ border_nodes = {{ text = "X" }, { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }}}},
            reminder_text = {{ text = "(Copper Cards)" }},
            calc_function = function(card)
                local playing_hand = next(G.play.cards)
                local count = 0
                for _, playing_card in ipairs(G.hand.cards) do
                    if playing_hand or not playing_card.highlighted then
                        if not (playing_card.facing == 'back') and not playing_card.debuff and playing_card.ability.name == "m_brit_copper" then
                            count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                        end
                    end
                end
                card.joker_display_values.x_mult = card.ability.extra ^ count
            end
        }
    end
})

-- CONSUMABLES --

function BRT_Use_Consumable(s,card,area,copier)
    if not card.ability.extra then
        return
    end
    if card.ability.extra.tagcard then
        G.E_MANAGER:add_event(Event({func = (function()
            BRT_Give_Tag(card.ability.extra.tag)
            for i = 1, #G.GAME.tags do
                G.GAME.tags[i]:apply_to_run({type = 'immediate'})
            end
            return true
        end)}))
        return
    end
    if card.ability.name == 'c_brit_skipper' then
        for i = 1, math.min((card.ability.extra.tagcards), G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    local newcard = create_card('TagCard', G.consumeables, nil, nil, nil, nil, nil, 'emp')
                    newcard:add_to_deck()
                    G.consumeables:emplace(newcard)
                    card:juice_up(0.3, 0.5)
                end
                return true
            end}))
        end
        delay(0.6)
    end
end

function BRT_New_Consumable(args)
    local set = 'Tarot'
    if args.set then set = args.set end
    local temp = {key=args.key, set=set, atlas=set..'s', pos=args.pos, cost=args.cost, in_pool = function(s,w1,w2) return true end,
        config=args.config, unlocked=true, discovered=false, loc_vars=args.loc_vars, can_use=function(self, card) return true end, use=function (s,card,area,copier)
            if area then area:remove_from_highlighted(card) end; BRT_Use_Consumable(s,card,area,copier)
        end}
    if args.nouse then temp.can_use = nil; temp.use = nil end
    temp.hidden = args.hidden
    temp.soul_set = args.soul_set
    temp.soul_rate = args.soul_rate
    temp.can_repeat_soul = args.can_repeat_soul
    return temp
end

-- Tarots --

SMODS.Consumable(BRT_New_Consumable{set='Tarot', key='skipper', pos={x=0,y=0}, cost=3, config={extra={tagcards = 2}},
    loc_vars=function (s,iq,center)
        if center then
            return {vars={center.ability.extra.tagcards}}
        end
        return {vars={}}
    end
})

SMODS.Consumable{
    set = "Tarot",
	name = "brit-honeycomb",
	key = "honeycomb",
	order = 1,
    atlas = "Tarots",
	pos = {x=1, y=0},
	config = {mod_conv="m_brit_copper", max_highlighted=1},
	loc_vars = function(s, info_queue, center)
        if center then
            info_queue[#info_queue + 1] = G.P_CENTERS.m_brit_copper
            return { vars = { center.ability.max_highlighted } }
        end
        return {vars={}}
	end,
}

-- Spectrals --

SMODS.Consumable{
    set = "Spectral",
	name = "brit-triumph",
	key = "triumph",
	order = 1,
    atlas = "Spectrals",
	pos = {x=1, y=0},
	config = {extra='brit_grey', max_highlighted=1},
	loc_vars = function(s, info_queue, center)
        if center then
            info_queue[#info_queue + 1] = {key = 'brit_grey_seal', set = 'Other'}
            return { vars = { center.ability.max_highlighted } }
        end
        return {vars={}}
	end,
    use = function (s,card,area,copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true
        end}))
        
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            conv_card:set_seal(card.ability.extra, nil, true)
            return true
        end}))
        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function()
            G.hand:unhighlight_all()
            return true
        end}))
    end
}

-- Planets --

SMODS.PokerHand{
    key = "clean_slate",
    mult = 8, chips = 60,
    l_mult = 2, l_chips = 15,
    example = {{'S_A',true,'m_stone'},{'S_A',true,'m_stone'},{'S_A',true,'m_stone'},{'S_A',true,'m_stone'},{'S_A',true,'m_stone'}},
    evaluate = function(parts, hand)
        local stones = {}
        for i, card in ipairs(hand) do
            if card.config.center_key == 'm_stone' or (card.config.center.no_rank and card.config.center.no_suit) then stones[#stones+1] = card end
        end
        return #stones >= 5 and {stones} or {}
    end,
    visible = false
}

SMODS.Consumable{
    set = 'Planet',
    key = 'eclipse',
    config = {hand_type = 'brit_clean_slate'},
    pos = {x=0,y=0},
    cost = 3,
    atlas = 'Planets',
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge("Moon", get_type_colour(self or card.config, card), nil, 1.2)
    end,
	loc_vars = function(self, info_queue, center)
        local level = G.GAME.hands["brit_eclipse"].level or 1
        local color = G.C.HAND_LEVELS[math.min(level, 7)]
        if level == 1 then color = G.C.UI.TEXT_DARK end
        return {
            vars = {
                "Eclipse",
                G.GAME.hands["brit_eclipse"].level,
				G.GAME.hands["brit_eclipse"].l_mult,
				G.GAME.hands["brit_eclipse"].l_chips,
                colours = {color},
            },
        }
    end,
    generate_ui = 0,
}

-- Tag Cards --

SMODS.ConsumableType{
    key = 'TagCard',
    collection_rows = {5, 4},
    primary_colour = HEX("96A1B6"),
    secondary_colour = HEX("96A1B6"),
    shop_rate = 0,
    loc_txt = {},
}
SMODS.UndiscoveredSprite({
	key = "TagCard", atlas = "TagCards", path = "TagCards.png",
	pos = {x=0,y=3}, px = 71, py = 95,
}):register()

function BRT_GetMostUsedTag()
    if not G.GAME.current_round.brit_used_tags then
        return nil
    end
    local _tagcard, _count = nil, 0
    for k, v in pairs(G.GAME.current_round.brit_used_tags) do
        if v > _count then
            _tagcard = k
            _count = v
        end
    end
    return _tagcard
end

function BRT_TagBooster(i)
    local _tagcard = BRT_GetMostUsedTag()
    if i == 1 and G.GAME.used_vouchers.v_brit_meta_tagger and _tagcard then
        return create_card("TagCard", G.pack_cards, nil, nil, true, true, BRIT_TAGS_TO_TAGCARD[_tagcard], 'tg1')
    else
        return create_card("TagCard", G.pack_cards, nil, nil, true, true, nil, "tg1")
    end
end

SMODS.Booster{
    key = 'tag_normal_1',
    kind = 'Tag',
    atlas = 'Boosters',
    pos = {x=0,y=0},
    weight = 0.75,
    config = { extra = 2, choose = 1 },
    create_card = function(self, card, i)
        return BRT_TagBooster(i)
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, mix_colours(G.C.TAGCARD, G.C.BLACK, 0.9))
		ease_background_colour{new_colour = G.C.TAGCARD, special_colour = darken(G.C.BLACK, 0.2), contrast = 2}
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end,
    update = function (self, card, dt)
        if G.GAME.used_vouchers.v_brit_avid_tagger and card.ability.extra == 2 then
            card.ability.extra = 3
        end
    end,
    group_key = 'k_brit_tag_pack'
}

SMODS.Booster{
    key = 'tag_normal_2',
    kind = 'Tag',
    atlas = 'Boosters',
    pos = {x=1,y=0},
    weight = 0.75,
    config = { extra = 2, choose = 1 },
    create_card = function(self, card, i)
        return BRT_TagBooster(i)
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, mix_colours(G.C.TAGCARD, G.C.BLACK, 0.9))
		ease_background_colour{new_colour = G.C.TAGCARD, special_colour = darken(G.C.BLACK, 0.2), contrast = 2}
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end,
    update = function (self, card, dt)
        if G.GAME.used_vouchers.v_brit_avid_tagger and card.ability.extra == 2 then
            card.ability.extra = 3
        end
    end,
    group_key = 'k_brit_tag_pack'
}

SMODS.Booster{
    key = 'tag_jumbo_1',
    kind = 'Tag',
    atlas = 'Boosters',
    pos = {x=2,y=0},
    weight = 0.75,
    cost = 6,
    config = { extra = 4, choose = 1 },
    create_card = function(self, card, i)
        return BRT_TagBooster(i)
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, mix_colours(G.C.TAGCARD, G.C.BLACK, 0.9))
		ease_background_colour{new_colour = G.C.TAGCARD, special_colour = darken(G.C.BLACK, 0.2), contrast = 2}
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end,
    update = function (self, card, dt)
        if G.GAME.used_vouchers.v_brit_avid_tagger and card.ability.extra == 4 then
            card.ability.extra = 5
        end
    end,
    group_key = 'k_brit_tag_pack'
}

SMODS.Booster{
    key = 'tag_mega_1',
    kind = 'Tag',
    atlas = 'Boosters',
    pos = {x=3,y=0},
    weight = 0.75,
    cost = 8,
    config = { extra = 4, choose = 2 },
    create_card = function(self, card, i)
        return BRT_TagBooster(i)
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, mix_colours(G.C.TAGCARD, G.C.BLACK, 0.9))
		ease_background_colour{new_colour = G.C.TAGCARD, special_colour = darken(G.C.BLACK, 0.2), contrast = 2}
	end,
	loc_vars = function(self, info_queue, card)
        if not card then return {vars={2, 4}} end
		return { vars = { card.ability.choose, card.ability.extra } }
	end,
    update = function (self, card, dt)
        if G.GAME.used_vouchers.v_brit_avid_tagger and card.ability.extra == 4 then
            card.ability.extra = 5
        end
    end,
    group_key = 'k_brit_tag_pack'
}

function BRT_TAG_VARS(s,iq,center)
    iq[#iq+1] = G.P_TAGS[center.ability.extra.tag]
    return {vars = {}}
end

-- good god...
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='clearer', pos={x=0,y=0}, cost=3, config={extra={tagcard=true, tag='tag_d_six'}}, loc_vars=BRT_TAG_VARS})
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='creator', pos={x=1,y=0}, cost=3, config={extra={tagcard=true, tag='tag_top_up'}}, loc_vars=BRT_TAG_VARS})
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='thrifter', pos={x=2,y=0}, cost=3, config={extra={tagcard=true, tag='tag_coupon'}}, loc_vars=BRT_TAG_VARS})
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='claimer', pos={x=3,y=0}, cost=3, config={extra={tagcard=true, tag='tag_voucher'}}, loc_vars=BRT_TAG_VARS})
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='reacher', pos={x=4,y=0}, cost=3, config={extra={tagcard=true, tag='tag_juggle'}}, loc_vars=BRT_TAG_VARS})
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='uncommoner', pos={x=0,y=1}, cost=3, config={extra={tagcard=true, tag='tag_uncommon'}}, loc_vars=BRT_TAG_VARS})
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='rarer', pos={x=1,y=1}, cost=3, config={extra={tagcard=true, tag='tag_rare'}}, loc_vars=BRT_TAG_VARS})
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='handler', pos={x=2,y=1}, cost=3, config={extra={tagcard=true, tag='tag_handy'}}, loc_vars=BRT_TAG_VARS})
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='discarder', pos={x=3,y=1}, cost=3, config={extra={tagcard=true, tag='tag_garbage'}}, loc_vars=BRT_TAG_VARS})
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='doubler', pos={x=0,y=2}, cost=3, config={extra={tagcard=true, tag='tag_double'}}, loc_vars=BRT_TAG_VARS})
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='foiler', pos={x=1,y=2}, cost=3, config={extra={tagcard=true, tag='tag_foil'}}, loc_vars=BRT_TAG_VARS})
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='holoer', pos={x=2,y=2}, cost=3, config={extra={tagcard=true, tag='tag_holo'}}, loc_vars=BRT_TAG_VARS})
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='chromer', pos={x=3,y=2}, cost=3, config={extra={tagcard=true, tag='tag_polychrome'}}, loc_vars=BRT_TAG_VARS})
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='grabber', pos={x=4,y=2}, cost=3, config={extra={tagcard=true, tag='tag_brit_grabber'}}, loc_vars=BRT_TAG_VARS})
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='waster', pos={x=1,y=3}, cost=3, config={extra={tagcard=true, tag='tag_brit_wasteful'}}, loc_vars=BRT_TAG_VARS})
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='invester', pos={x=2,y=3}, cost=3, config={extra={tagcard=true, tag='tag_investment'}}, loc_vars=BRT_TAG_VARS})
SMODS.Consumable(BRT_New_Consumable{set='TagCard', key='roller', pos={x=4,y=3}, cost=3, config={extra={tagcard=true, tag='tag_boss'}}, loc_vars=BRT_TAG_VARS})

SMODS.Consumable(BRT_New_Consumable{set='Spectral', key='giver', pos={x=0,y=0}, cost=4, config={extra={tagcard=true, tag='tag_negative'}}, loc_vars=BRT_TAG_VARS,
    hidden = true, soul_set = 'TagCard', soul_rate = 0.03, can_repeat_soul = true
})

SMODS.Tag:take_ownership("tag_handy", {
    config = {type='immediate', dollars_per_hand=1, max_dollars=20},
    loc_vars = function (s, iq, center)
        local dollars = center.config.dollars_per_hand*(G.GAME.hands_played or 0)
        if dollars > center.config.max_dollars then dollars = center.config.max_dollars end
        return {vars={center.config.dollars_per_hand,dollars,center.config.max_dollars}}
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            self:yep('+', G.C.MONEY, function()
                return true
            end)
            local dollars = tag.config.dollars_per_hand*(G.GAME.hands_played or 0)
            if dollars > tag.config.max_dollars then dollars = tag.config.max_dollars end
            ease_dollars(dollars)
            self.triggered = true
        end
	end
})

SMODS.Tag:take_ownership("tag_garbage", {
    config = {type='immediate', dollars_per_discard=1, max_dollars=20},
    loc_vars = function (s, iq, center)
        local dollars = center.config.dollars_per_discard*(G.GAME.unused_discards or 0)
        if dollars > center.config.max_dollars then dollars = center.config.max_dollars end
        return {vars={center.config.dollars_per_discard,dollars,center.config.max_dollars}}
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            self:yep('+', G.C.MONEY, function()
                return true
            end)
            local dollars = tag.config.dollars_per_discard*(G.GAME.unused_discards or 0)
            if dollars > tag.config.max_dollars then dollars = tag.config.max_dollars end
            ease_dollars(dollars)
            self.triggered = true
        end
	end
})

-- Enhancers --

SMODS.Seal{
    name = "grey_seal",
	key = "grey",
	badge_colour = G.C.GREY,
	atlas = "Enhancers",
	pos = {x=0, y=0},
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				func = function()
					if G.consumeables.config.card_limit > #G.consumeables.cards then
						local c = create_card("TagCard", G.consumeables, nil, nil, nil, nil, nil, "tg1")
						c:add_to_deck()
						G.consumeables:emplace(c)
						card:juice_up()
					end
					return true
				end,
			}))
		end
	end,
}

SMODS.Enhancement{
    key = 'copper',
    atlas = 'Enhancers',
    pos = {x=1,y=0},
    config = {h_mult=10},
    loc_vars = function(self, info_queue)
		return { vars = { self.config.h_mult } }
	end,
}

-- Vouchers --

SMODS.Voucher{
    key = 'tag_merchent',
    atlas = 'Vouchers',
    cost = 10,
    pos = {x=0,y=0},
    config = {},
    loc_vars = function(s,iq,center) return {vars={}} end,
    redeem = function(s)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.tagcard_rate = (G.GAME.tagcard_rate or 0) + 2
				return true
			end,
		}))
	end
}

SMODS.Voucher{
    key = 'tag_tycoon',
    requires = {"v_brit_tag_merchent"},
    atlas = 'Vouchers',
    cost = 10,
    pos = {x=1,y=0},
    config = {extra=2},
    loc_vars = function(s,iq,center) return {vars={center.ability.extra}} end,
    redeem = function(s)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.tagcard_rate = (G.GAME.tagcard_rate or 2) + 2
				return true
			end,
		}))
	end
}

SMODS.Voucher{
    key = 'avid_tagger',
    atlas = 'Vouchers',
    cost = 10,
    pos = {x=2,y=0},
    config = {standard=3,jumbomega=5},
    loc_vars = function(s,iq,center) return {vars={center.ability.standard,center.ability.jumbomega}} end,
    redeem = function(s) end
}

SMODS.Voucher{
    key = 'meta_tagger',
    requires = {"v_brit_avid_tagger"},
    atlas = 'Vouchers',
    cost = 10,
    pos = {x=3,y=0},
    config = {},
    loc_vars = function(s,iq,center)
        local _tagcard = BRT_GetMostUsedTag()
        if _tagcard then
            local tag = G.P_TAGS[_tagcard]
            iq[#iq+1] = tag
            return {vars={tag.name}}
        end
        return {vars={"None"}}
    end,
    redeem = function(s) end
}

-- Tags --

SMODS.Tag{
    key = 'grabber',
    atlas = 'Tags',
    pos = {x=0,y=0},
    min_ante = 2,
    config = {extra=1},
    discovered = false,
    loc_vars = function(s,iq) return {vars={s.config.extra}} end,
    apply = function(self, tag, context)
        if context.type == 'round_start_bonus' then
            tag:yep("+", G.C.BLUE, function()
                return true
            end)
            ease_hands_played(tag.config.extra)
            tag.triggered = true
        end
	end,
}

SMODS.Tag{
    key = 'wasteful',
    atlas = 'Tags',
    pos = {x=1,y=0},
    min_ante = 2,
    config = {extra=1},
    discovered = false,
    loc_vars = function(s,iq) return {vars={s.config.extra}} end,
    apply = function(self, tag, context)
        if context.type == 'round_start_bonus' then
            tag:yep("+", G.C.RED, function()
                return true
            end)
            ease_discard(tag.config.extra)
            tag.triggered = true
        end
	end,
}

SMODS.Tag{
    key = 'sleave',
    atlas = 'Tags',
    pos = {x=2,y=0},
    min_ante = 2,
    config = {},
    discovered = false,
    loc_vars = function(s,info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS['p_brit_tag_mega_1']
        return {vars={}}
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            tag:yep('+', G.C.TAGCARD, function() 
                local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS['p_brit_tag_mega_1'], {bypass_discovery_center = true, bypass_discovery_ui = true})
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({config = {ref_table = card}})
                card:start_materialize()
                return true
            end)
            tag.triggered = true
        end
	end,
}

--

SMODS.Back{
    name = "Shiny Deck",
    key = "shiny",
    atlas = "Enhancers",
    pos = {x = 2, y = 0},
    config = {ante_scaling = 2, joker_slot = -1},
    loc_vars = function(s,iq) return {vars={s.config.joker_slot,s.config.ante_scaling}} end,
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                local abilities = {"m_gold","m_steel","m_brit_copper"}
                local available = {m_gold=17,m_steel=17,m_brit_copper=18,none=0}
                for i = #G.playing_cards, 1, -1 do
                    local ability = "none"
                    while available[ability] <= 0 do
                        ability = abilities[math.random(1,3)]
                    end
                    G.playing_cards[i]:set_ability(G.P_CENTERS[ability])
                    available[ability] = available[ability] - 1
                end
                return true
            end
        }))
    end
}

SMODS.Back{
    name = "Concrete Deck",
    key = "concrete",
    atlas = "Enhancers",
    pos = {x = 3, y = 0},
    config = {},
    loc_vars = function(s,iq) return {vars={}} end,
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    if G.playing_cards[i]:is_face() then
                        G.playing_cards[i]:set_ability(G.P_CENTERS.m_stone)
                    end
                end
                return true
            end
        }))
    end
}


SMODS.Challenge{
    key = 'nationallottery',
    rules = {
        custom = {
            {id = 'no_shop_purchases'},
        },
        modifiers = {
            {id = 'dollars', value = 25},
            {id = 'joker_slots', value = 6},
        }
    },
    jokers = {
        {id = 'j_brit_jimbobooster'},
        {id = 'j_brit_jimbobooster'},
        {id = 'j_brit_jimbobooster'},
        {id = 'j_brit_jimbobooster'},
        {id = 'j_brit_jimbobooster'},
    },
    restrictions = {
        banned_cards = {
            {id = 'j_chaos'},{id = 'j_flash'},
            {id = 'v_overstock_norm'},{id = 'v_overstock_plus'},
            {id = 'v_magic_trick'},{id = 'v_illusion'},
            {id = 'v_planet_merchant'},{id = 'v_planet_tycoon'},
            {id = 'v_tarot_merchant'},{id = 'v_tarot_tycoon'},
            {id = 'v_brit_tag_merchent'},{id = 'v_brit_tag_tycoon'},
            {id = 'v_reroll_surplus'},{id = 'v_reroll_glut'},
            {id = 'c_brit_clearer'},
            {id = 'c_brit_foiler'},
            {id = 'c_brit_holoer'},
            {id = 'c_brit_chromer'},
            {id = 'c_brit_uncommoner'},
            {id = 'c_brit_rarer'},
            {id = 'c_brit_giver'},
        },
        banned_tags = {
            {id = 'tag_d_six'},
            {id = 'tag_foil'},{id = 'tag_holo'},{id = 'tag_polychrome'},{id = 'tag_negative'},
            {id = 'tag_rare'},{id = 'tag_uncommon'},
        },
        banned_other = {
        }
    }
}

SMODS.Challenge{
    key = 'tagfull',
    rules = {
        custom = {
            {id = 'no_blind_skips'},
        },
        modifiers = {
            {id = 'dollars', value = 10},
        }
    },
    vouchers = {
        {id = 'v_brit_tag_merchent'},
        {id = 'v_brit_tag_tycoon'},
        {id = 'v_brit_avid_tagger'},
        {id = 'v_brit_meta_tagger'},
    },
    restrictions = {
        banned_cards = {
            {id = 'j_throwback'},
            {id = 'j_brit_hopscotch'},
        },
        banned_tags = {
            {id = 'tag_skip'}
        }
    }
}

SMODS.Challenge{
    key = 'equality',
    rules = {
        custom = {
            {id = 'boosters_in_shop'},
        },
        modifiers = {}
    },
    vouchers = {
        {id = 'v_magic_trick'},{id = 'v_illusion'},
    },
    restrictions = {
        banned_cards = {
            {id = 'v_planet_merchant'},{id = 'v_planet_tycoon'},
            {id = 'v_tarot_merchant'},{id = 'v_tarot_tycoon'},
            {id = 'v_brit_tag_merchent'},{id = 'v_brit_tag_tycoon'},
        },
        banned_tags = {}
    }
}

local lc = SMODS.Atlas{key = 'britdanpack_lc', path = 'britdanpack_lc.png', px = 71, py = 95}
local hc = SMODS.Atlas{key = 'britdanpack_hc', path = 'britdanpack_hc.png', px = 71, py = 95}

SMODS.DeckSkin{
    key = 'britdanpack',
    suit = 'Clubs',
    loc_txt = "Britdan Pack",
    palettes = {
        {
            key = "lc",
            ranks = {"Jack","Queen","King"},
            display_ranks = {"King","Queen","Jack"},
            atlas = lc.key,
            pos_style = 'collab'
        },
        {
            key = "hc",
            ranks = {"Jack","Queen","King"},
            display_ranks = {"King","Queen","Jack"},
            atlas = hc.key,
            pos_style = 'collab',
            colour = HEX("008ee6"),
        }
    }
}

--

function G.FUNCS.can_reroll(e)
    if G.GAME.modifiers.no_shop_purchases or (((G.GAME.dollars-G.GAME.bankrupt_at) - G.GAME.current_round.reroll_cost < 0) and G.GAME.current_round.reroll_cost ~= 0) then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.GREEN
        e.config.button = 'reroll_shop'
    end
end

function G.FUNCS.exit_button()
    G.SETTINGS.paused = true; love.event.quit()
end

local createOptionsRef = create_UIBox_options
function create_UIBox_options()
    contents = createOptionsRef()
    local exit_button = UIBox_button({minw = 5, button = "exit_button", label = {"Exit Game"}})
    table.insert(contents.nodes[1].nodes[1].nodes[1].nodes, #contents.nodes[1].nodes[1].nodes[1].nodes + 1, exit_button)
    return contents
end