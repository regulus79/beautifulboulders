This is the folder where the generated collision box definitions go.

The nodeboxes are just lua files is the format of:
```lua
return {
    {x1, y1, z1, x2, y2, z2},
    {x1, y1, z1, x2, y2, z2},
    --And so on...
}
```
This is so that when doing ```dofile()`` in init.lua, it returns the collision box in a nice table (no parsing required).