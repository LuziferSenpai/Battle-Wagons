require "config"

local m = "__Battle_Wagons__"
local utd = util.table.deepcopy

Senpais.Functions.Create.Battle_Wagon = function( n, it, h, w, s, c, g, su, o, st, ig, t )
	local i =
	{
		{ icon = "__base__/graphics/icons/cargo-wagon.png", icon_size = 32 },
		{ icon = m .. "/graphics/cargo-wagon-mask.png", icon_size = 32, tint = util.color( c ) }
	}
	local we = utd( data.raw["cargo-wagon"]["cargo-wagon"] )
	we.name = n
	we.icon = nil
	we.icons = i
	we.inventory_size = it
	we.minable.result = n
	we.max_health = h
	we.weight = w
	we.max_speed = s

	for _, l in pairs( we.pictures.layers ) do
		if l.apply_runtime_tint == true then
			for i = 1, 8 do
				l.filenames[i] = m .. "/graphics/mask-" .. i .. ".png"
			end
			for i = 1, 16 do
				l.hr_version.filenames[i] = m .. "/graphics/hr-mask-" .. i .. ".png"
			end
			break
		end
	end

	we.horizontal_doors.layers[3].filename = m .. "/graphics/cargo-wagon-door-horizontal-side-mask.png"
	we.horizontal_doors.layers[3].hr_version.filename = m .. "/graphics/hr-cargo-wagon-door-horizontal-side-mask.png"
	we.horizontal_doors.layers[5].filename = m .. "/graphics/cargo-wagon-door-horizontal-top-mask.png"
	we.horizontal_doors.layers[5].hr_version.filename = m .. "/graphics/hr-cargo-wagon-door-horizontal-top-mask.png"

	we.vertical_doors.layers[3].filename = m .. "/graphics/cargo-wagon-door-vertical-side-mask.png"
	we.vertical_doors.layers[3].hr_version.filename = m .. "/graphics/hr-cargo-wagon-door-vertical-side-mask.png"
	we.vertical_doors.layers[5].filename = m .. "/graphics/cargo-wagon-door-vertical-top-mask.png"
	we.vertical_doors.layers[5].hr_version.filename = m .. "/graphics/hr-cargo-wagon-door-vertical-top-mask.png"

	we.color = util.color( c )
	we.equipment_grid = g

	local wi = utd( data.raw["item-with-entity-data"]["cargo-wagon"] )
	wi.name = n
	wi.icon = nil
	wi.icons = i
	wi.subgroup = su
	wi.order = o
	wi.place_result = n
	wi.stack_size = st

	local wr = utd( data.raw["recipe"]["cargo-wagon"] )
	wr.name = n
	wr.ingredients = ig
	wr.result = n

	data:extend{ we, wi, wr }

	table.insert( data.raw["technology"][t].effects, { type = "unlock-recipe", recipe = n } )
end

Senpais.Functions.Create.Grid = function( n, w, h, c )
	local g = utd( data.raw["equipment-grid"]["large-equipment-grid"] )
	g.name = n
	g.width = w
	g.height = h
	g.equipment_categories = c

	data:extend{ g }
end

if not data.raw["equipment-grid"]["Battle-Grid-01"] then
	Senpais.Functions.Create.Grid( "Battle-Grid-01", 5, 5, { "Battle-Laser", "armor" } )
end

if not data.raw["equipment-grid"]["Battle-Grid-02"] then
	Senpais.Functions.Create.Grid( "Battle-Grid-02", 10, 10, { "Battle-Laser", "armor" } )
end

if not data.raw["equipment-grid"]["Battle-Grid-03"] then
	Senpais.Functions.Create.Grid( "Battle-Grid-03", 15, 15, { "Battle-Laser", "armor" } )
end

Senpais.Functions.Create.Battle_Wagon
(
	"Battle-Wagon-1",
	40,
	1000,
	2000,
	1.2,
	"#137a9c",
	"Battle-Grid-01",
	"transport",
	"a[train-system]-gaa[cargo-wagon]",
	5,
	{ { "cargo-wagon", 1 }, { "modular-armor", 1 } },
	"modular-armor"
)

data.raw["cargo-wagon"]["Battle-Wagon-1"].resistances = utd( data.raw["armor"]["modular-armor"].resistances )

Senpais.Functions.Create.Battle_Wagon
(
	"Battle-Wagon-2",
	60,
	1500,
	4000,
	1.4,
	"#1d7f0c",
	"Battle-Grid-02",
	"transport",
	"a[train-system]-gab[cargo-wagon]",
	5,
	{ { "cargo-wagon", 1 }, { "power-armor", 1 } },
	"power-armor"
)

data.raw["cargo-wagon"]["Battle-Wagon-2"].resistances = utd( data.raw["armor"]["power-armor"].resistances )

Senpais.Functions.Create.Battle_Wagon
(
	"Battle-Wagon-3",
	80,
	2000,
	6000,
	1.6,
	"#9c4296",
	"Battle-Grid-03",
	"transport",
	"a[train-system]-gac[cargo-wagon]",
	5,
	{ { "cargo-wagon", 1 }, { "power-armor-mk2", 1 } },
	"power-armor-mk2"
)

data.raw["cargo-wagon"]["Battle-Wagon-3"].resistances = utd( data.raw["armor"]["power-armor-mk2"].resistances )

if not data.raw["active-defense-equipment"]["laser-2"] then
	local le = utd( data.raw["active-defense-equipment"]["personal-laser-defense-equipment"] )
	le.name = "laser-2"
	le.sprite.filename = m .. "/graphics/laser-2.png"
	le.energy_source.buffer_capacity = "750kJ"
	le.attack_parameters =
	{
		type = "beam",
		cooldown = 20,
		range = 30,
		damage_modifier = 8,
		ammo_type =
		{
			category = "laser-turret",
			energy_consumption = "200kJ",
			action =
			{
				type = "direct",
				action_delivery =
				{
					type = "beam",
					beam = "laser-beam",
					max_length = 30,
					duration = 20,
					source_offset = { 0, -1.31439 }
				}	
			}
		}
	}
	le.categories = { "Battle-Laser" }
	
	local li = utd( data.raw["item"]["personal-laser-defense-equipment"] )
	li.name = "laser-2"
	li.icon = m .. "/graphics/laser-2-i.png"
	li.placed_as_equipment_result = "laser-2"
	li.order = "d[active-defense]-ab[laser-2]"
	
	local lr = utd( data.raw["recipe"]["personal-laser-defense-equipment"] )
	lr.name = "laser-2"
	lr.ingredients =
	{
		{ "personal-laser-defense-equipment", 1 },
		{ "processing-unit", 10 },
		{ "steel-plate", 50 },
		{ "laser-turret", 5 }
	}
	lr.result = "laser-2"
	
	local lt = utd( data.raw["technology"]["personal-laser-defense-equipment"] )
	lt.name = "personal-laser-defense-equipment-2"
	lt.prerequisites = { "personal-laser-defense-equipment" }
	lt.effects = { { type = "unlock-recipe", recipe = "laser-2" } }
	lt.unit.count = 250
	
	data:extend{ { type = "equipment-category", name = "Battle-Laser" }, le, li, lr, lt }
end