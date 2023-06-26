
local cave_stone_prob=0.3

local num_normal_stones=10
local num_vertical_stones=10

for i=0,num_normal_stones-1 do
    node_box=dofile(minetest.get_modpath("beautifulboulders").."/nodeboxes/stone"..tostring(i)..".lua")
    minetest.register_node("beautifulboulders:stone"..tostring(i),{
        description="stone",
        drawtype="mesh",

        --pointable=false,

        paramtype="mesh",
        paramtype2="facedir",
        mesh="stone"..tostring(i)..".obj",
        tiles={"default_stone.png"},
        groups={cracky=3,stone=1},
        drop="default:cobble",
        collision_box={
            type="fixed",
            fixed=node_box,
        },
        --[[selection_box={
            type="fixed",
            fixed=node_box
        }]]
    })
end

--vertical stones
for i=0,num_vertical_stones-1 do
    node_box=dofile(minetest.get_modpath("beautifulboulders").."/nodeboxes/stonevertical"..tostring(i)..".lua")
    minetest.register_node("beautifulboulders:stonevertical"..tostring(i),{
        description="stone",
        drawtype="mesh",

        --pointable=false,

        paramtype="mesh",
        paramtype2="facedir",
        mesh="stonevertical"..tostring(i)..".obj",
        tiles={"default_stone.png"},
        groups={cracky=3,stone=1},
        drop="default:cobble",
        collision_box={
            type="fixed",
            fixed=node_box,
        },
        --[[selection_box={
            type="fixed",
            fixed=node_box
        }]]
    })
end
--[[
minetest.register_decoration({
    deco_type="simple",
    decoration = "beautifulboulders:stonevertical",
    place_on="default:dirt_with_grass",
    fill_ratio=11,
    flags="all_floors"
})
]]

for i=0,num_normal_stones-1 do
    minetest.register_decoration({
		name = "beautifulboulders:surfacestone"..tostring(i),
		deco_type = "simple",
		place_on = {"default:dirt_with_grass","default:desert_sand","default:sand"},
        fill_ratio=0.001,
		decoration = "beautifulboulders:stone"..tostring(i),
        flags="force_placement",
        place_offset_y=-1,
	})
end

local c_stone=minetest.get_content_id("default:stone")
local c_air=minetest.get_content_id("air")
local vertical_c_ids={}
local normal_c_ids={}
for i=0,9 do
    table.insert(vertical_c_ids,minetest.get_content_id("beautifulboulders:stonevertical"..tostring(i)))
end
for i=0,9 do
    table.insert(normal_c_ids,minetest.get_content_id("beautifulboulders:stone"..tostring(i)))
end

minetest.register_on_generated(function(minp,maxp,blockseed)
    local vm=minetest.get_mapgen_object("voxelmanip")
    local emin,emax=vm:read_from_map(minp,maxp)
    local area=VoxelArea:new{
        MinEdge=emin,
        MaxEdge=emax
    }
    data=vm:get_data()
    param2=vm:get_param2_data()
    for x=minp.x,maxp.x do
        for y=minp.y,maxp.y do
            for z=minp.z,maxp.z do
                local idx=area:index(x,y,z)
                if data[idx]==c_stone and math.random()<cave_stone_prob then
                    if (data[area:index(x+1,y,z)]==c_air or data[area:index(x,y,z+1)]==c_air or data[area:index(x-1,y,z+1)]==c_air or data[area:index(x+1,y,z-1)]==c_air) then
                        data[idx]=vertical_c_ids[math.random(#vertical_c_ids)]
                        param2[idx]=math.random(0,3)
                    elseif (data[area:index(x,y-1,z)]==c_air or data[area:index(x,y+1,z)]==c_air) then
                        data[idx]=normal_c_ids[math.random(#normal_c_ids)]
                        param2[idx]=math.random(0,23)
                    end
                end
            end
        end
    end
    vm:set_data(data)
    vm:set_param2_data(param2)
    vm:write_to_map(true)
end)
