local MODNAME = "__Battle_Wagons__"
local table_deepcopy = util.table.deepcopy

Senpais = Senpais or {}

Senpais.Functions = Senpais.Functions or {}

Senpais.Functions.Create = Senpais.Functions.Create or {}

Senpais.Functions.Create.Battle_Wagon = function( name, inventory_size, max_health, weight, max_speed, color, grid, subgroup, order, stack_size, ingredients, technology )
	local icons =
	{
		{ icon = "__base__/graphics/icons/cargo-wagon.png", icon_size = 64, icon_mipmap = 4 },
		{ icon = MODNAME .. "/graphics/cargo-wagon-mask.png", icon_size = 32, tint = util.color( color ) }
	}

	local wagon_entity = table_deepcopy( data.raw["cargo-wagon"]["cargo-wagon"] )
	wagon_entity.name = name
	wagon_entity.icon = nil
	wagon_entity.icon_size = nil
	wagon_entity.icon_mipmap = nil
	wagon_entity.icons = icons
	wagon_entity.inventory_size = inventory_size
	wagon_entity.minable.result = name
	wagon_entity.max_health = max_health
	wagon_entity.weight = weight
	wagon_entity.max_speed = max_speed
	wagon_entity.color = util.color( color )
	wagon_entity.equipment_grid = grid

	for _, layer in pairs( wagon_entity.pictures.layers ) do
		if layer.apply_runtime_tint == true then
			for i = 1, 8 do
				layer.filenames[i] = MODNAME .. "/graphics/mask-" .. i .. ".png"
			end

			for i = 1, 16 do
				layer.hr_version.filenames[i] = MODNAME .. "/graphics/hr-mask-" .. i .. ".png"
			end
			break
		end
	end

	wagon_entity.horizontal_doors.layers[3].filename = MODNAME .. "/graphics/cargo-wagon-door-horizontal-side-mask.png"
	wagon_entity.horizontal_doors.layers[3].hr_version.filename = MODNAME .. "/graphics/hr-cargo-wagon-door-horizontal-side-mask.png"
	wagon_entity.horizontal_doors.layers[5].filename = MODNAME .. "/graphics/cargo-wagon-door-horizontal-top-mask.png"
	wagon_entity.horizontal_doors.layers[5].hr_version.filename = MODNAME .. "/graphics/hr-cargo-wagon-door-horizontal-top-mask.png"

	wagon_entity.vertical_doors.layers[3].filename = MODNAME .. "/graphics/cargo-wagon-door-vertical-side-mask.png"
	wagon_entity.vertical_doors.layers[3].hr_version.filename = MODNAME .. "/graphics/hr-cargo-wagon-door-vertical-side-mask.png"
	wagon_entity.vertical_doors.layers[5].filename = MODNAME .. "/graphics/cargo-wagon-door-vertical-top-mask.png"
	wagon_entity.vertical_doors.layers[5].hr_version.filename = MODNAME .. "/graphics/hr-cargo-wagon-door-vertical-top-mask.png"

	local wagon_item = table_deepcopy( data.raw["item-with-entity-data"]["cargo-wagon"] )
	wagon_item.name = name
	wagon_item.icon = nil
	wagon_item.icon_size = nil
	wagon_item.icon_mipmap = nil
	wagon_item.icons = icons
	wagon_item.subgroup = subgroup
	wagon_item.order = order
	wagon_item.place_result = name
	wagon_item.stack_size = stack_size

	local wagon_recipe = table_deepcopy( data.raw["recipe"]["cargo-wagon"] )
	wagon_recipe.name = name
	wagon_recipe.ingredients = ingredients
	wagon_recipe.result = name

	data:extend{ wagon_entity, wagon_item, wagon_recipe }

	table.insert( data.raw["technology"][technology].effects, { type = "unlock-recipe", recipe = name } )
end

Senpais.Functions.Create.Grid = function( name, width, height, category )
	local grid = table_deepcopy( data.raw["equipment-grid"]["large-equipment-grid"] )
	grid.name = name
	grid.width = width
	grid.height = height
	grid.equipment_categories = category

	data:extend{ grid }
end