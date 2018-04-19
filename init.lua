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

minetest.register_craft({
	type = "fuel",
	recipe = "soy:soy",
	burntime = 1,
})

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