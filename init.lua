--[[
	**********************************************
	***                        Soy                               ***
	**********************************************
	
	If you want use Soy with farming_redo from TenPlus, then set
	
	farming_default = false
	
	else true.
	
	if you want to add a Recipt to get additional Soy-Seeds, then set
	
	additional_seed = true
	
	else false.
	
]]--
local farming_default = true

-- looking if farming_redo is activ?
if(farming.mod ~= nil and farming.mod == "redo") then

	farming_default = false

end


-- Switch true to use the Recipe for additional Seeds.
local additional_seeds = true

if (farming_default) then

	print("[MOD] " .. minetest.get_current_modname() .. " set to default mode.")
	-- Soy
	farming.register_plant("soy:soy", {
		description = "Soy Beans",
		inventory_image = "soy_seed.png",
		steps = 8,
		minlight = 12,
		maxlight = default.LIGHT_MAX,
		fertility = {"grassland"},
		groups = {flammable = 4},
	})
	
	-- Register for Mapgen
	minetest.register_node("soy:wild_soy", {
		description = "Wild Soy",
		paramtype = "light",
		walkable = false,
		drop = { 
				items = { 
						{items = {"soy:seed_soy 3"}},
						{items = {"soy:soy"}},
					}
				},
		drawtype = "plantlike",
		paramtype2 = "facedir",
		tiles = {"soy_soy_8.png"},
		groups = {chopspy=2, oddly_breakable_by_hand=3, flammable=2, plant=1},
		sounds = default.node_sound_wood_defaults(),
		selection_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, -0.35, 0.5}, -- side f
				},
		},
	})

	-- Crafting Recipe to get additional Seeds (Default: additional_seed = false).
	if(additional_seeds) then

		minetest.register_craft({
			output = "soy:seed_soy 4",
			recipe = {
				{"soy:soy"}
			}
		})

	end -- if(additional_seeds)

else

	print("[MOD] " .. minetest.get_current_modname() .. " set to redo mode.")
	minetest.register_node("soy:seed", {
		description = "Soy Seed",
		tiles = {"soy_seed.png"},
		inventory_image = "soy_seed.png",
		wield_image = "soy_seed.png",
		drawtype = "signlike",
		groups = {seed = 1, snappy = 3, attached_node = 1, flammable = 4},
		paramtype = "light",
		paramtype2 = "wallmounted",
		walkable = false,
		sunlight_propagates = true,
		selection_box = farming.select,
		on_place = function(itemstack, placer, pointed_thing)
			return farming.place_seed(itemstack, placer, pointed_thing, "soy:soy_1")
		end,
	})

	minetest.register_craftitem("soy:soy", {
		description = "Soy Bean",
		inventory_image = "soy_soy.png",
		groups = {flammable = 4},
		})
	
	-- Soy definition
	local crop_def = {
		drawtype = "plantlike",
		tiles = {"soy_soy_1.png"},
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		drop =  "",
		selection_box = farming.select,
		groups = {
			snappy = 3, flammable = 4, plant = 1, attached_node = 1,
			not_in_creative_inventory = 1, growing = 1
		},
		sounds = default.node_sound_leaves_defaults()
	}

	-- stage 1
	minetest.register_node("soy:soy_1", table.copy(crop_def))

	-- stage 2
	crop_def.tiles = {"soy_soy_2.png"}
	minetest.register_node("soy:soy_2", table.copy(crop_def))

	-- stage 3
	crop_def.tiles = {"soy_soy_3.png"}
	minetest.register_node("soy:soy_3", table.copy(crop_def))

	-- stage 4
	crop_def.tiles = {"soy_soy_4.png"}
	minetest.register_node("soy:soy_4", table.copy(crop_def))

	-- stage 5
	crop_def.tiles = {"soy_soy_5.png"}
	crop_def.drop = {
		items = {
			{items = {"soy:seed_soy"}, rarity = 1},
		}
	}
	minetest.register_node("soy:soy_5", table.copy(crop_def))

	-- stage 6
	crop_def.tiles = {"soy_soy_6.png"}
	crop_def.drop = {
		items = {
			{items = {"soy:seed"}, rarity = 1},
			{items = {"soy:soy"}, rarity = 2},
		}
	}
	minetest.register_node("soy:soy_6", table.copy(crop_def))

	-- stage 7
	crop_def.tiles = {"soy_soy_7.png"}
	crop_def.drop = {
		items = {
			{items = {"soy:soy"}, rarity = 1},
			{items = {"soy:soy"}, rarity = 2},
			{items = {"soy:seed"}, rarity = 1},
			{items = {"soy:seed"}, rarity = 2},
		}
	}
	minetest.register_node("soy:soy_7", table.copy(crop_def))

	-- stage 8 (final)
	crop_def.tiles = {"soy_soy_8.png"}
	crop_def.groups.growing = 0
	crop_def.drop = {
		items = {
			{items = {"soy:soy"}, rarity = 1},
			{items = {"soy:soy"}, rarity = 2},
			{items = {"soy:soy"}, rarity = 3},
			{items = {"soy:seed"}, rarity = 1},
			{items = {"soy:seed"}, rarity = 2},
			{items = {"soy:seed"}, rarity = 3},
		}
	}
	minetest.register_node("soy:soy_8", table.copy(crop_def))
	
	-- Register for Mapgen
	minetest.register_node("soy:wild_soy", {
		description = "Wild Soy",
		paramtype = "light",
		walkable = false,
		drop = { 
				items = { 
						{items = {"soy:seed 3"}},
						{items = {"soy:soy"}},
					}
				},
		drawtype = "plantlike",
		paramtype2 = "facedir",
		tiles = {"soy_soy_8.png"},
		groups = {chopspy=2, oddly_breakable_by_hand=3, flammable=2, plant=1},
		sounds = default.node_sound_wood_defaults(),
		selection_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, -0.35, 0.5}, -- side f
				},
		},
	})

	-- Crafting Recipe to get additional Seeds (Default: additional_seed = false).
	if(additional_seeds) then

		minetest.register_craft({
			output = "soy:seed 4",
			recipe = {
				{"soy:soy"}
			}
		})

	end -- if(additional_seeds)
	
end -- if( default ....)


minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.004,
		spread = {x = 100, y = 100, z = 100},
		seed = 7133,
		octaves = 3,
		persist = 0.6
	},
	y_min = 10,
	y_max = 90,
	decoration = "soy:wild_soy",
})

minetest.register_craft({
	type = "fuel",
	recipe = "soy:soy",
	burntime = 1,
})

minetest.register_craftitem("soy:tofu", {
	description = "Tofu",
	inventory_image = "soy_tofu.png",
	groups = {flammable = 1, food = 1, eatable = 1},
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("soy:milk", {
	description = "Soy Milk",
	inventory_image = "soy_milk.png",
	groups = {flammable = 1, food = 1, food_milk = 1, eatable = 1},
	on_use = minetest.item_eat(1),
})

minetest.register_craftitem("soy:tofu_cooked", {
	description = "Tofu (cooked)",
	inventory_image = "soy_tofu_cooked.png",
	groups = {flammable = 1, food = 1, eatable = 1},
	on_use = minetest.item_eat(3),
})

minetest.register_craft({
	output = "soy:tofu",
	recipe = {
			{"soy:soy", "soy:soy", "soy:soy"},
			{"soy:soy", "soy:soy", "soy:soy"},
			{"soy:soy", "soy:soy", "soy:soy"},
		},
})

minetest.register_craft({
	output = "soy:milk",
	recipe = {
			{"soy:soy", "soy:soy", "soy:soy"},
			{"", "soy:soy", ""},
			{"", "vessels:drinking_glass", ""},
		},
})

minetest.register_craft({
	type = "cooking",
	output = "soy:tofu_cooked",
	recipe = "soy:tofu",
	cooktime = 5,
})

-- *** Additional Recipes with other Mods

if minetest.get_modpath("mobs") then

	minetest.register_craft({
		output = "mobs:meat_raw",
		recipe = {
			{"soy:tofu", "soy:tofu", "soy:tofu"}
		}
	})

	minetest.register_craft({
		output = "mobs:chicken_raw",
		recipe = {
			{"", "", "soy:tofu"},
			{"", "soy:tofu", ""},
			{"soy:tofu", "", ""},
		}
	})

end -- if mobs

if minetest.get_modpath("animalmaterials") then

	minetest.register_craft({
		output = "animalmaterials:milk",
		recipe = {
			{"soy:milk", "soy:milk", "soy:milk"},
			{"", "vessels:glass_bottle", ""}
		},
		replacements = {{"soy:milk", "vessels:drinking_glass"}}
	})
	
end -- if animalmaterials

print("[MOD] " .. minetest.get_current_modname() .. " loaded.")