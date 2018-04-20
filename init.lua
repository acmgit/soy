--[[
	**********************************************
	***                        Soy                               ***
	**********************************************
	
	If you use normal the default farming, set default to true.
	If you use farming_redo, then set default to false.
]]--

-- Switch true to use farming_redo, default = false
local default = true

if (default == true) then

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

else
	minetest.register_node("soy:soy_seed", {
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
			{items = {"soy:soy_seed"}, rarity = 1},
		}
	}
	minetest.register_node("soy:soy_5", table.copy(crop_def))

	-- stage 6
	crop_def.tiles = {"soy_soy_6.png"}
	crop_def.drop = {
		items = {
			{items = {"soy:soy"}, rarity = 1},
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
			{items = {"soy:soy_seed"}, rarity = 1},
			{items = {"soy:soy_seed"}, rarity = 2},
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
			{items = {"soy:soy_seed"}, rarity = 1},
			{items = {"soy:soy_seed"}, rarity = 2},
			{items = {"soy:soy_seed"}, rarity = 3},
		}
	}
	minetest.register_node("soy:soy_8", table.copy(crop_def))
	
end -- if( default ....)

minetest.register_craft({
	type = "fuel",
	recipe = "soy:soy",
	burntime = 1,
})

-- Crafting Recipe to get additional Seeds.
--[[
minetest.register_craft({
	output = "soy:seed_soy 4",
	recipe = {
		{"soy:soy"}
	}
})
--]]

minetest.register_craftitem("soy:tofu", {
	description = "Tofu",
	inventory_image = "soy_tofu.png",
	groups = {flammable = 1, food = 1, eatable = 1},
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("soy:milk", {
	description = "Soy Milk",
	inventory_image = "soy_milk.png",
	groups = {flammable = 1, food = 1, milk = 1, eatable = 1},
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
		},
})

minetest.register_craft({
	output = "soy:milk",
	recipe = {
			{"soy:soy", "soy:soy", "soy:soy"},
			{"", "vessels:drinking_glass", ""},
		},
})

minetest.register_craft({
	type = "cooking",
	output = "soy:tofu_cooked",
	recipe = "soy:tofu",
	cooktime = 5,
})

if minetest.get_modpath("mobs") then

	minetest.register_craft({
		output = "mobs:meat_raw",
		recipe = {
			{"soy:tofu_cooked", "soy:tofu_cooked", "soy:tofu_cooked"}
		}
	})

	minetest.register_craft({
		output = "mobs:chicken_raw",
		recipe = {
			{"", "soy:tofu_cooked", ""},
			{"", "soy:tofu_cooked", ""},
			{"", "soy:tofu_cooked", ""},
		}
	})

end -- if mobs

-- *** Additional Recipes with other Mods

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