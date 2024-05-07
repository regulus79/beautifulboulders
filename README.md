# Beautiful Boulders

A Mod for Randomly Generated Rocks in Minetest


## Algorithm Explanation:
1. Given randomly spaced 3d points, generate a convex hull too be used as the rock model.
2. Save the ConvexHull returned by scipy into a .obj file.
3. Generate collision boxes for each vertex with an Axis Aligned Bounding Box starting from the origin (0,0,0) and ending at each point.
4. Save the collision boxes.

# How to use

Run `generate_stones.py` to generate stones, then enter a minetest world with the mod enabled, and the stones will appear.

![Screenshot from 2023-08-07 15-15-10](https://github.com/regulus79/beautifulboulders/assets/117475203/7d5d89ea-3aef-4467-9bab-605c7cf8d992)
![image](https://github.com/regulus79/beautifulboulders/assets/117475203/2594f991-3f33-49f4-8819-eba954852e3f)
![Screenshot from 2023-08-07 15-13-23](https://github.com/regulus79/beautifulboulders/assets/117475203/45a59bd0-8240-4480-8972-4b52de131cdf)
