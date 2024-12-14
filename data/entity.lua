local pipe_pic = assembler3pipepictures()
local pipecoverpic = pipecoverspictures()

local box3 = { { -1.5, -1.5 }, { 1.5, 1.5 } }  -- 调整为3的大小
local box4 = { { -2, -2 }, { 2, 2 } }  -- 保持不变
local box5 = { { -2.5, -2.5 }, { 2.5, 2.5 } }  -- 保持不变
local box6 = { { -3, -3 }, { 3, 3 } }  -- 调整为6的大小
local box7 = { { -3.5, -3.5 }, { 3.5, 3.5 } }  -- 调整为7的大小
local box8 = { { -4, -4 }, { 4, 4 } }  -- 调整为8的大小
local box11 = { { -5.5, -5.5 }, { 5.5, 5.5 } }

local function shrinkBox(box)
    -- 获取 box 的左下角和右上角坐标
    local leftBottom = box[1]
    local rightTop = box[2]

    -- 计算缩小后的坐标
    local newLeftBottom = { leftBottom[1] + 0.1, leftBottom[2] + 0.1 }
    local newRightTop = { rightTop[1] - 0.1, rightTop[2] - 0.1 }

    -- 返回缩小后的 box
    return { newLeftBottom, newRightTop }
end

local function create_boxes(size)
    local position = size / 2 - 0.1
    return {
        -- 北
        {
            production_type = "input",
            volume = 1000,
            pipe_picture = pipe_pic,
            pipe_covers = pipecoverpic,
            pipe_connections = { { direction = defines.direction.north, flow_direction = "input", position = { 0, -position } } },
            secondary_draw_orders = { north = -1 }
        },
        -- 西
        {
            production_type = "input",
            volume = 1000,
            pipe_picture = pipe_pic,
            pipe_covers = pipecoverpic,
            pipe_connections = { { direction = defines.direction.west, flow_direction = "input", position = { -position, -0 } } },
            secondary_draw_orders = { north = -1 }
        },
        -- 南
        {
            production_type = "output",
            volume = 1000,
            pipe_picture = pipe_pic,
            pipe_covers = pipecoverpic,
            pipe_connections = { { direction = defines.direction.south, flow_direction = "output", position = { 0, position } } },
            secondary_draw_orders = { north = -1 }
        },
        -- 东
        {
            production_type = "output",
            volume = 1000,
            pipe_picture = pipe_pic,
            pipe_covers = pipecoverpic,
            pipe_connections = { { direction = defines.direction.east, flow_direction = "output", position = { position, 0 } } },
            secondary_draw_orders = { north = -1 }
        }
    }
end

local function getStripes(path, max)

    local stripes = {}
    for i = 1, max do

        local s = {
            filename = "__fruit__/graphics/" .. path .. i .. ".png",
            width_in_frames = 1,
            height_in_frames = 1,
        }
        table.insert(stripes, s)
    end

    return stripes
end

local function getStripesAnimation(path, max, width, height, animation_speed, shift, scale)
    local animation = {
        slice = 1,
        animation_speed = animation_speed or 0.5,
        width = width,
        height = height,
        frame_count = max,
        draw_as_glow = true,
        direction_count = 1,
        shift = shift or util.by_pixel(0, 0),
        scale = scale or 1,
        stripes = getStripes(path, max)

    }

    return animation
end

if mods["space-age"] then


    local tower = table.deepcopy(data.raw["agricultural-tower"]["agricultural-tower"])

    tower.name = "super-tower"
    --	定义作物生长的随机偏移量，必须大于等于0且小于1。 默认0.25
    tower.random_growth_offset = 0
    --定义作物生长网格的瓦片大小，必须为正数。 默认3
    tower.growth_grid_tile_size = 4

    tower.input_inventory_size = 10

    tower.output_inventory_size = 10

    tower.radius = 8

    data:extend { tower }
    data:extend { {
                      type = "item",
                      subgroup = "fruit_machine",
                      name = tower.name,
                      icon = tower.icon,
                      icon_size = tower.icon_size,
                      place_result = tower.name,
                      order = tower.name,
                      stack_size = 20
                  },
                  {
                      type = "recipe",
                      name = tower.name,
                      enabled = true,
                      energy_required = 1,
                      ingredients = {
                          { type = "item", name = "assembling-machine-1", amount = 2 },
                          { type = "item", name = "iron-plate", amount = 100 },
                          { type = "item", name = "steel-plate", amount = 100 },
                          { type = "item", name = "electronic-circuit", amount = 20 },
                      },
                      results = { { type = "item", name = tower.name, amount = 1 } },
                  }, }
end

local base = {
    type = "assembling-machine",
    name = "juice-extractor",
    icon = "__fruit__/graphics/entity/juicer-machine.png",
    icon_size = 1024,
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { hardness = 0.2, mining_time = 1, result = "juice-extractor" },
    max_health = 500,
    inventory_size = 4,
    corpse = "big-remnants",
    dying_explosion = "big-explosion",
    resistances = { { type = "fire", percent = 90 } },
    collision_box = { { -2.4, -2.4 }, { 2.4, 2.4 } },
    selection_box = { { -2.5, -2.5 }, { 2.5, 2.5 } },
    fluid_boxes = {
        {
            production_type = "input",
            volume = 1000,
            pipe_picture = pipe_pic,
            pipe_covers = pipecoverpic,
            pipe_connections = { { direction = defines.direction.north, flow_direction = "input", position = { -2, -2.3 } } },
            secondary_draw_orders = { north = -1 }
        },
        {
            production_type = "input",
            volume = 1000,
            pipe_picture = pipe_pic,
            pipe_covers = pipecoverpic,
            pipe_connections = { { direction = defines.direction.north, flow_direction = "input", position = { 0, -2.3 } } },
            secondary_draw_orders = { north = -1 }
        },
        {
            production_type = "input",
            volume = 1000,
            pipe_picture = pipe_pic,
            pipe_covers = pipecoverpic,
            pipe_connections = { { direction = defines.direction.north, flow_direction = "input", position = { 2, -2.3 } } },
            secondary_draw_orders = { north = -1 }
        },
        --北
        {
            production_type = "input",
            volume = 1000,
            pipe_picture = pipe_pic,
            pipe_covers = pipecoverpic,
            pipe_connections = { { direction = defines.direction.west, flow_direction = "input", position = { -2.3, -2 } } },
            secondary_draw_orders = { north = -1 }
        },
        {
            production_type = "input",
            volume = 1000,
            pipe_picture = pipe_pic,
            pipe_covers = pipecoverpic,
            pipe_connections = { { direction = defines.direction.west, flow_direction = "input", position = { -2.3, 0 } } },
            secondary_draw_orders = { north = -1 }
        },
        {
            production_type = "input",
            volume = 1000,
            pipe_picture = pipe_pic,
            pipe_covers = pipecoverpic,
            pipe_connections = { { direction = defines.direction.west, flow_direction = "input", position = { -2.3, 2 } } },
            secondary_draw_orders = { north = -1 }
        },
        --{
        --    production_type = "input",
        --    volume = 1000,
        --    pipe_picture = pipe_pic,
        --    pipe_covers = pipecoverpic,
        --    pipe_connections = { { direction = defines.direction.north, flow_direction = "input", position = { 4, -4 } } },
        --    secondary_draw_orders = { north = -1 }
        --},
        {
            production_type = "output",
            volume = 1000,
            pipe_picture = pipe_pic,
            pipe_covers = pipecoverpic,
            pipe_connections = { { direction = defines.direction.south, flow_direction = "output", position = { -2, 2.3 } } },
            secondary_draw_orders = { north = -1 }
        },
        {
            production_type = "output",
            volume = 1000,
            pipe_picture = pipe_pic,
            pipe_covers = pipecoverpic,
            pipe_connections = { { direction = defines.direction.south, flow_direction = "output", position = { 0, 2.3 } } },
            secondary_draw_orders = { north = -1 }
        },
        {
            production_type = "output",
            volume = 1000,
            pipe_picture = pipe_pic,
            pipe_covers = pipecoverpic,
            pipe_connections = { { direction = defines.direction.south, flow_direction = "output", position = { 2, 2.3 } } },
            secondary_draw_orders = { north = -1 }
        },
        {
            production_type = "input",
            volume = 1000,
            pipe_picture = pipe_pic,
            pipe_covers = pipecoverpic,
            pipe_connections = { { direction = defines.direction.east, flow_direction = "output", position = { 2.3, -2 } } },
            secondary_draw_orders = { north = -1 }
        },
        {
            production_type = "input",
            volume = 1000,
            pipe_picture = pipe_pic,
            pipe_covers = pipecoverpic,
            pipe_connections = { { direction = defines.direction.east, flow_direction = "output", position = { 2.3, 0 } } },
            secondary_draw_orders = { north = -1 }
        },
        {
            production_type = "input",
            volume = 1000,
            pipe_picture = pipe_pic,
            pipe_covers = pipecoverpic,
            pipe_connections = { { direction = defines.direction.east, flow_direction = "output", position = { 2.3, 2 } } },
            secondary_draw_orders = { north = -1 }
        },
    },
    fluid_boxes_off_when_no_fluid_recipe = true,
    graphics_set = {
        animation = {
            layers = {
                {
                    filename = "__fruit__/graphics/entity/juicer-machine.png",
                    priority = "extra-high",
                    width = 512,
                    height = 512,
                    frame_count = 1,
                    line_length = 1,
                    repeat_count = 1,
                    animation_speed = 0.3,
                    shift = { 0, -0.8 },
                    scale = 0.4,
                },
            },
        },
    },
    crafting_categories = { "juice", },
    crafting_speed = 1,
    impact_category = "metal",
    energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        emissions_per_minute = {
            pollution = 10
        }
    },
    circuit_connector = circuit_connector_definitions["assembling-machine"],
    circuit_wire_max_distance = 20,
    energy_usage = "100kW",
    ingredient_count = 6,
    module_slots = 4,
    allowed_effects = { "consumption", "speed", "productivity", "pollution", "quality" },
    heating_energy = feature_flags["freezing"] and "100kW" or nil,
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    squeak_behaviour = false,
    working_sound = {
        audible_distance_modifier = 0.5,
        fade_in_ticks = 4,
        fade_out_ticks = 20,
        sound = {
            filename = "__base__/sound/assembling-machine-t3-1.ogg",
            volume = 0.45
        }
    }
}
local juice = table.deepcopy(base)
juice.collision_box = shrinkBox(box3)
juice.selection_box = box3
juice.fluid_boxes = create_boxes(3)
juice.icon_size = 512

--Jam Machine
local jam = table.deepcopy(base)
jam.name = "jam-machine"
jam.icon = "__fruit__/graphics/entity/jam-machine.png"
jam.icon_size = 512
jam.minable.result = "jam-machine"
jam.crafting_categories = { "jam", }
jam.collision_box = shrinkBox(box4)
jam.selection_box = box4
jam.fluid_boxes = create_boxes(4)
jam.graphics_set = {
    animation = {
        layers = {
            {
                filename = "__fruit__/graphics/entity/jam-machine.png",
                priority = "extra-high",
                width = 512,
                height = 512,
                frame_count = 1,
                line_length = 1,
                repeat_count = 2,
                animation_speed = 0.3,
                shift = { 0, -1 },
                scale = 0.5,
            },
        },
    },
}

--fermentation chamber
local fermentation = table.deepcopy(base)
fermentation.name = "fermentation-chamber"
fermentation.icon = "__fruit__/graphics/entity/fermentation-chamber.png"
fermentation.icon_size = 512
fermentation.minable.result = "fermentation-chamber"
fermentation.crafting_categories = { "fermentation", }
fermentation.collision_box = shrinkBox(box4)
fermentation.selection_box = box4
fermentation.fluid_boxes = create_boxes(4)
fermentation.graphics_set = {
    animation = {
        layers = {
            {
                filename = "__fruit__/graphics/entity/fermentation-chamber.png",
                priority = "extra-high",
                width = 512,
                height = 512,
                frame_count = 1,
                line_length = 1,
                repeat_count = 2,
                animation_speed = 0.3,
                shift = { 0, -1.2 },
                scale = 0.5,
            },
        },
    },
}
--oven
local oven = table.deepcopy(base)
oven.name = "oven"
oven.icon = "__fruit__/graphics/entity/oven.png"
oven.icon_size = 512
oven.minable.result = "oven"
oven.crafting_categories = { "oven", }
oven.graphics_set = {
    animation = {
        layers = {
            {
                filename = "__fruit__/graphics/entity/oven.png",
                priority = "extra-high",
                width = 512,
                height = 512,
                frame_count = 1,
                line_length = 1,
                repeat_count = 2,
                animation_speed = 0.3,
                shift = { 0,  0.3 },
                scale = 0.5,
            },
        },
    },
}

--icecream
local icecream = table.deepcopy(base)
icecream.name = "icecream"
icecream.icon = "__fruit__/graphics/entity/icecream.png"
icecream.icon_size = 512
icecream.minable.result = "icecream"
icecream.crafting_categories = { "icecream", }
icecream.collision_box = shrinkBox(box3)
icecream.selection_box = box3
icecream.fluid_boxes = create_boxes(3)
icecream.graphics_set = {
    animation = {
        layers = {
            {
                filename = "__fruit__/graphics/entity/icecream.png",
                priority = "extra-high",
                width = 512,
                height = 512,
                frame_count = 1,
                line_length = 1,
                repeat_count = 2,
                animation_speed = 0.3,
                shift = { 0, -1.2 },
                scale = 0.5,
            },
        },
    },
}
--bbq
local bbq = table.deepcopy(base)
bbq.name = "bbq"
bbq.icon = "__fruit__/graphics/entity/bbq.png"
bbq.icon_size = 512
bbq.minable.result = "bbq"
bbq.crafting_categories = { "bbq", }
bbq.collision_box = shrinkBox(box5)
bbq.selection_box = box5
bbq.fluid_boxes = create_boxes(5)
bbq.graphics_set = {
    animation = {
        layers = {
            {
                filename = "__fruit__/graphics/entity/bbq.png",
                priority = "extra-high",
                width = 512,
                height = 512,
                frame_count = 1,
                line_length = 1,
                repeat_count = 2,
                animation_speed = 0.3,
                shift = { 0, -0.4 },
                scale = 0.5,
            },
        },
    },
}

--agitator
local agitator = table.deepcopy(base)
agitator.name = "agitator"
agitator.icon = "__fruit__/graphics/entity/agitator.png"
agitator.icon_size = 512
agitator.minable.result = "agitator"
agitator.crafting_categories = { "agitator", }
agitator.collision_box = shrinkBox(box3)
agitator.selection_box = box3
agitator.fluid_boxes = create_boxes(3)
agitator.graphics_set = {
    animation = {
        layers = {
            {
                filename = "__fruit__/graphics/entity/agitator.png",
                priority = "extra-high",
                width = 512,
                height = 512,
                frame_count = 1,
                line_length = 1,
                repeat_count = 2,
                animation_speed = 0.3,
                shift = { -0.05, -1.2 },
                scale = 0.5,
            },
        },
    },
}

--Grinder
local grinder = table.deepcopy(base)
grinder.name = "grinder"
grinder.icon = "__fruit__/graphics/entity/grinder.png"
grinder.icon_size = 512
grinder.minable.result = "grinder"
grinder.crafting_categories = { "grinder", }
grinder.collision_box = shrinkBox(box4)
grinder.selection_box = box4
grinder.fluid_boxes = create_boxes(4)

grinder.graphics_set = {
    animation = {
        layers = {
            {
                filename = "__fruit__/graphics/entity/grinder.png",
                priority = "extra-high",
                width = 512,
                height = 512,
                frame_count = 1,
                line_length = 1,
                repeat_count = 2,
                animation_speed = 0.3,
                shift = { 0, -1 },
                scale = 0.5,
            },
        },
    },
}

local pot = {
    type = "assembling-machine",
    name = "pot",
    icon = "__fruit__/graphics/entity/pot/1.png",
    icon_size = 400,
    max_health = 500,
    flags = { "not-rotatable", "placeable-neutral", "placeable-player", "player-creation" },
    minable = { hardness = 0.2, mining_time = 1, result = "pot" },
    crafting_categories = { "pot", "pie" },
    crafting_speed = 1,
    collision_box = { { -1.4, -1.4 }, { 1.4, 1.4 } },
    selection_box = { { -2, -2 }, { 2, 2 } },
    scale_entity_info_icon = true,
    always_draw_idle_animation = true,
    graphics_set = {
        animation = {
            layers = {
                {
                    filename = "__base__/graphics/entity/stone-furnace/stone-furnace.png",
                    height = 146,
                    priority = "extra-high",
                    scale = 0.5,
                    frame_count = 1,
                    repeat_count = 61,
                    shift = { 0, 1.2 },
                    width = 151
                },
                {
                    draw_as_shadow = true,
                    filename = "__base__/graphics/entity/stone-furnace/stone-furnace-shadow.png",
                    priority = "extra-high",
                    height = 74,
                    frame_count = 1,
                    repeat_count = 61,
                    scale = 0.5,
                    shift = { 0.45, 1.4 },
                    width = 164
                },
                getStripesAnimation("entity/pot/", 61, 400, 400, nil, util.by_pixel(0, 8), 0.5),
            }
        },
        working_visualisations = {
            {
                animation = {
                    layers = {
                        {
                            draw_as_glow = true,
                            filename = "__base__/graphics/entity/stone-furnace/stone-furnace-fire.png",
                            frame_count = 48,
                            height = 100,
                            line_length = 8,
                            priority = "extra-high",
                            scale = 0.5,
                            shift = { 0, 1.2 },
                            width = 41
                        },
                        {
                            blend_mode = "additive",
                            draw_as_glow = true,
                            filename = "__base__/graphics/entity/stone-furnace/stone-furnace-light.png",
                            height = 144,
                            repeat_count = 48,
                            scale = 0.5,
                            shift = { 0, 1.2 },
                            width = 106
                        }
                    }
                },
                effect = "flicker",
                fadeout = true
            },
            --{
            --    animation = {
            --        blend_mode = "additive",
            --        draw_as_light = true,
            --        filename = "__base__/graphics/entity/stone-furnace/stone-furnace-ground-light.png",
            --        height = 110,
            --        repeat_count = 48,
            --        scale = 0.5,
            --        shift = { 0, 2.3 },
            --        width = 116
            --    },
            --    effect = "flicker",
            --    fadeout = true
            --}
        },
        water_reflection = {
            orientation_to_variation = false,
            pictures = {
                filename = "__base__/graphics/entity/stone-furnace/stone-furnace-reflection.png",
                height = 16,
                priority = "extra-high",
                scale = 5,
                shift = {
                    0,
                    1.09375
                },
                variation_count = 1,
                width = 16
            },
            rotate = false
        },

    },

    energy_usage = "100W",
    energy_source = {
        type = "burner",
        fuel_categories = { "chemical" },
        effectivity = 1,
        fuel_inventory_size = 2,
        emissions_per_minute = { pollution = 10 },
        light_flicker = {
            color = { 0, 0, 0 },
            minimum_intensity = 0.6,
            maximum_intensity = 0.95
        },
        smoke = {
            {
                name = "smoke",
                deviation = { 0.1, 0.1 },
                frequency = 5,
                position = { 0.0, -0.8 },
                starting_vertical_speed = 0.08,
                starting_frame_deviation = 60
            }
        }
    },
    result_inventory_size = 0,
    source_inventory_size = 0,
    se_allow_in_space = true
}

local machines = {
    juice,
    jam,
    fermentation,
    oven,
    icecream,
    agitator,
    grinder,
    bbq,
    pot,
}

for k, machine in pairs(machines) do
    data:extend {
        {
            type = "item",
            subgroup = "fruit_machine",
            name = machine.name,
            icon = machine.icon,
            icon_size = machine.icon_size,
            place_result = machine.name,
            order = machine.name,
            stack_size = 20
        },
        {
            type = "recipe",
            name = machine.name,
            enabled = true,
            energy_required = 1,
            ingredients = {
                { type = "item", name = "assembling-machine-1", amount = 2 },
                { type = "item", name = "iron-plate", amount = 100 },
                { type = "item", name = "steel-plate", amount = 100 },
                { type = "item", name = "electronic-circuit", amount = 20 },
            },
            results = { { type = "item", name = machine.name, amount = 1 } },
        },
    }

end

data:extend(machines)

local xx = {
    allowed_effects = {
        "speed",
        "consumption",
        "pollution"
    },
    close_sound = {
        filename = "__base__/sound/machine-close.ogg",
        volume = 0.5
    },
    collision_box = {
        {
            -0.7,
            -0.7
        },
        {
            0.7,
            0.7
        }
    },
    corpse = "stone-furnace-remnants",
    crafting_categories = {
        "smelting"
    },
    crafting_speed = 1,
    damaged_trigger_effect = {
        damage_type_filters = "fire",
        entity_name = "rock-damaged-explosion",
        offset_deviation = {
            {
                -0.5,
                -0.5
            },
            {
                0.5,
                0.5
            }
        },
        offsets = {
            {
                0,
                1
            }
        },
        type = "create-entity"
    },
    dying_explosion = "stone-furnace-explosion",
    effect_receiver = {
        uses_beacon_effects = false,
        uses_module_effects = false,
        uses_surface_effects = true
    },
    energy_source = {
        effectivity = 1,
        emissions_per_minute = {
            pollution = 2
        },
        fuel_categories = {
            "chemical"
        },
        fuel_inventory_size = 1,
        light_flicker = {
            color = {
                0,
                0,
                0
            },
            maximum_intensity = 0.95,
            minimum_intensity = 0.6
        },
        smoke = {
            {
                deviation = {
                    0.1,
                    0.1
                },
                frequency = 5,
                name = "smoke",
                position = {
                    0,
                    -0.8
                },
                starting_frame_deviation = 60,
                starting_vertical_speed = 0.08
            }
        },
        type = "burner"
    },
    energy_usage = "90kW",
    fast_replaceable_group = "furnace",
    flags = {
        "placeable-neutral",
        "placeable-player",
        "player-creation"
    },
    graphics_set = {
        animation = {
            layers = {
                {
                    filename = "__base__/graphics/entity/stone-furnace/stone-furnace.png",
                    height = 146,
                    priority = "extra-high",
                    scale = 0.5,
                    shift = {
                        -0.0078125,
                        0.1875
                    },
                    width = 151
                },
                {
                    draw_as_shadow = true,
                    filename = "__base__/graphics/entity/stone-furnace/stone-furnace-shadow.png",
                    height = 74,
                    priority = "extra-high",
                    scale = 0.5,
                    shift = {
                        0.453125,
                        0.40625
                    },
                    width = 164
                }
            }
        },
        water_reflection = {
            orientation_to_variation = false,
            pictures = {
                filename = "__base__/graphics/entity/stone-furnace/stone-furnace-reflection.png",
                height = 16,
                priority = "extra-high",
                scale = 5,
                shift = {
                    0,
                    1.09375
                },
                variation_count = 1,
                width = 16
            },
            rotate = false
        },
        working_visualisations = {
            {
                animation = {
                    layers = {
                        {
                            draw_as_glow = true,
                            filename = "__base__/graphics/entity/stone-furnace/stone-furnace-fire.png",
                            frame_count = 48,
                            height = 100,
                            line_length = 8,
                            priority = "extra-high",
                            scale = 0.5,
                            shift = {
                                -0.0234375,
                                0.171875
                            },
                            width = 41
                        },
                        {
                            blend_mode = "additive",
                            draw_as_glow = true,
                            filename = "__base__/graphics/entity/stone-furnace/stone-furnace-light.png",
                            height = 144,
                            repeat_count = 48,
                            scale = 0.5,
                            shift = {
                                0,
                                0.15625
                            },
                            width = 106
                        }
                    }
                },
                effect = "flicker",
                fadeout = true
            },
            {
                animation = {
                    blend_mode = "additive",
                    draw_as_light = true,
                    filename = "__base__/graphics/entity/stone-furnace/stone-furnace-ground-light.png",
                    height = 110,
                    repeat_count = 48,
                    scale = 0.5,
                    shift = {
                        -0.03125,
                        1.375
                    },
                    width = 116
                },
                effect = "flicker",
                fadeout = true
            }
        }
    },
    icon = "__base__/graphics/icons/stone-furnace.png",
    icon_draw_specification = {
        scale = 0.66000000000000005,
        shift = {
            0,
            -0.1
        }
    },
    impact_category = "stone",
    max_health = 200,
    minable = {
        mining_time = 0.2,
        result = "stone-furnace"
    },
    mined_sound = {
        switch_vibration_data = {
            filename = "__core__/sound/deconstruct-bricks.bnvib",
            gain = 0.32000000000000002
        },
        variations = {
            {
                filename = "__base__/sound/deconstruct-bricks.ogg",
                volume = 0.8
            }
        }
    },
    name = "stone-furnace",
    next_upgrade = "steel-furnace",
    open_sound = {
        filename = "__base__/sound/machine-open.ogg",
        volume = 0.5
    },
    repair_sound = {
        {
            filename = "__base__/sound/manual-repair-simple-1.ogg",
            volume = 0.5
        },
        {
            filename = "__base__/sound/manual-repair-simple-2.ogg",
            volume = 0.5
        },
        {
            filename = "__base__/sound/manual-repair-simple-3.ogg",
            volume = 0.5
        },
        {
            filename = "__base__/sound/manual-repair-simple-4.ogg",
            volume = 0.5
        },
        {
            filename = "__base__/sound/manual-repair-simple-5.ogg",
            volume = 0.5
        }
    },
    resistances = {
        {
            percent = 90,
            type = "fire"
        },
        {
            percent = 30,
            type = "explosion"
        },
        {
            percent = 30,
            type = "impact"
        }
    },
    result_inventory_size = 1,
    selection_box = {
        {
            -0.8,
            -1
        },
        {
            0.8,
            1
        }
    },
    source_inventory_size = 1,
    type = "furnace",
    working_sound = {
        audible_distance_modifier = 0.4,
        fade_in_ticks = 4,
        fade_out_ticks = 20,
        sound = {
            filename = "__base__/sound/furnace.ogg",
            modifiers = {
                {
                    type = "main-menu",
                    volume_multiplier = 1.5
                },
                {
                    type = "tips-and-tricks",
                    volume_multiplier = 1.3999999999999999
                }
            },
            volume = 0.6
        }
    }
}
