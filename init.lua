
--local stones={}
for i=0,9 do
    --table.insert(stones,"stone:stone"..tostring(i))
    node_box=dofile(minetest.get_modpath("stone").."/nodeboxes/stone"..tostring(i)..".lua")
    minetest.register_node("stone:stone"..tostring(i),{
        description="stone",
        drawtype="mesh",

        pointable=false,

        paramtype="mesh",
        paramtype2="facedir",
        mesh="stone"..tostring(i)..".obj",
        tiles={"nodes_stone.png"},
        groups={stoney=1},
        collision_box={
            type="fixed",
            fixed=node_box,
        },
        selection_box={
            type="fixed",
            fixed=node_box
        }
    })
end

--vertical stones
for i=0,9 do
    --table.insert(stones,"stone:stone"..tostring(i))
    node_box=dofile(minetest.get_modpath("stone").."/nodeboxes/stonewall"..tostring(i)..".lua")
    minetest.register_node("stone:stonewall"..tostring(i),{
        description="stone",
        drawtype="mesh",

        pointable=false,

        paramtype="mesh",
        paramtype2="facedir",
        mesh="stonewall"..tostring(i)..".obj",
        tiles={"nodes_stone.png"},
        groups={stoney=1},
        collision_box={
            type="fixed",
            fixed=node_box,
        },
        selection_box={
            type="fixed",
            fixed=node_box
        }
    })
end

--minetest.register_alias("mapgen_stone","stone:stone")


--[[minetest.register_decoration({
    deco_type="simple",
    place_on="nodes:stone",
    fill_ratio=0.02,
    
    decoration={"stone:stone"}
})]]


minetest.register_lbm({
    name="stone:replace_old_stone",
    nodenames = {"nodes:stone"},
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
                    minetest.set_node(pos,{name="stone:stone"..math.random(0,9),param2=math.random(0,23)})
                else
                    minetest.chat_send_all(dump(pos))
                    minetest.set_node(pos,{name="stone:stonewall"..math.random(0,9),param2=math.random(0,3)})
                end

            end

        end
    end
})
