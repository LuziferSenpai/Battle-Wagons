require "defines"

local MODNAME = "__Battle_Wagons__"
local table_deepcopy = util.table.deepcopy
local temp01 = "vehicle-laser"
local temp02 = "Battle-Grid-"
local temp03 = "modular-armor"

local laser_equipment = table_deepcopy(data.raw["active-defense-equipment"]["personal-laser-defense-equipment"])
laser_equipment.name = temp01
laser_equipment.sprite.filename = MODNAME .. "/graphics/" .. temp01 .. ".png"
laser_equipment.energy_source.buffer_capacity = "750kJ"
laser_equipment.categories = {"Battle-Laser"}
laser_equipment.attack_parameters = {
    type = "beam",
    cooldown = 20,
    range = 30,
    damage_modifier = 8,
    ammo_type = {
        category = "laser",
        energy_consumption = "200kJ",
        action = {
            type = "direct",
            action_delivery = {
                type = "beam",
                beam = "laser-beam",
                max_length = 30,
                duration = 20,
                source_offset = {0, -1.31439}
            }
        }
    }
}

local laser_item = table_deepcopy(data.raw["item"]["personal-laser-defense-equipment"])
laser_item.name = temp01
laser_item.icon = MODNAME .. "/graphics/" .. temp01 .. "-i.png"
laser_item.icon_size = 32
laser_item.icon_mipmap = nil
laser_item.placed_as_equipment_result = temp01
laser_item.order = "d[active-defense]-ab[" .. temp01 .. "]"

local laser_recipe = table_deepcopy(data.raw["recipe"]["personal-laser-defense-equipment"])
laser_recipe.name = temp01
laser_recipe.ingredients = {
    {"personal-laser-defense-equipment", 1},
    {"processing-unit", 10},
    {"steel-plate", 50},
    {"laser-turret", 5}
}
laser_recipe.result = temp01

local laser_technology = table_deepcopy(data.raw["technology"]["personal-laser-defense-equipment"])
laser_technology.name = "personal-laser-defense-equipment-2"
laser_technology.prerequisites = {"personal-laser-defense-equipment"}
laser_technology.effects = {{type = "unlock-recipe", recipe = temp01}}
laser_technology.unit.count = 250

data:extend{{type = "equipment-category", name = "Battle-Laser"}, laser_equipment, laser_item, laser_recipe, laser_technology}

Senpais.Functions.Create.Grid("Battle-Grid-01", 5, 5, { "Battle-Laser", "armor" })
Senpais.Functions.Create.Grid("Battle-Grid-02", 10, 10, { "Battle-Laser", "armor" })
Senpais.Functions.Create.Grid("Battle-Grid-03", 15, 15, { "Battle-Laser", "armor" })

temp01 = "Battle-Wagon-"

Senpais.Functions.Create.Battle_Wagon(temp01 .. "1", 40, 1000, 2000, 1.2, "#137a9c", temp02 .. "01", "train-transport", "a[train-system]-gaa[" .. temp01 .. "1]", 5, {{"cargo-wagon", 1}, {temp03, 1}}, temp03)

data.raw["cargo-wagon"][temp01 .. "1"].resistances = table_deepcopy(data.raw["armor"][temp03].resistances)

temp03 = "power-armor"

Senpais.Functions.Create.Battle_Wagon(temp01 .. "2", 50, 1500, 2000, 1.2, "#1d7f0c", temp02 .. "02", "train-transport", "a[train-system]-gab[" .. temp01 .. "2]", 5, {{"cargo-wagon", 1}, {temp03, 1}}, temp03)

data.raw["cargo-wagon"][temp01 .. "2"].resistances = table_deepcopy(data.raw["armor"][temp03].resistances)

temp03 = "power-armor-mk2"

Senpais.Functions.Create.Battle_Wagon(temp01 .. "3", 60, 2000, 2000, 1.2, "#9c4296", temp02 .. "03", "train-transport", "a[train-system]-gac[" .. temp01 .. "2]", 5, {{"cargo-wagon", 1}, {temp03, 1}}, temp03)

data.raw["cargo-wagon"][temp01 .. "3"].resistances = table_deepcopy(data.raw["armor"][temp03].resistances)