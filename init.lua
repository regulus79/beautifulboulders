

for i=0,9 do
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
for i=0,9 do
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


minetest.register_lbm({
    name="beautifulboulders:replace_old_stone",
    nodenames = {"default:stone"},
    run_at_every_load=true,
    action=function(pos,node)
        if math.random()<0.3 then
            if minetest.get_node(pos+vector.new(1,0,0)).name=="air" or
            minetest.get_node(pos+vector.new(0,0,1)).name=="air" or
            minetest.get_node(pos+vector.new(-1,0,0)).name=="air" or
            minetest.get_node(pos+vector.new(0,0,-1)).name=="air"  then
                if minetest.get_node(pos+vector.new(0,1,0)).name=="air" or
                minetest.get_node(pos+vector.new(0,-1,0)).name=="air" then
                    minetest.chat_send_all(dump(pos))
                    minetest.set_node(pos,{name="beautifulboulders:stone"..math.random(0,9),param2=math.random(0,23)})
                else
                    minetest.chat_send_all(dump(pos))
                    minetest.set_node(pos,{name="beautifulboulders:stonevertical"..math.random(0,9),param2=math.random(0,3)})
                end

            end

        end
    end
})
