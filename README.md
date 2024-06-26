# Beautiful Boulders

A Mod for Randomly Generated Rocks in Minetest


## Algorithm Explanation:
1. Given randomly spaced 3d points, generate a convex hull too be used as the rock model.
2. Save the ConvexHull returned by scipy into a .obj file.
3. Generate collision boxes for each vertex with an Axis Aligned Bounding Box starting from the origin (0,0,0) and ending at each point.
4. Save the collision boxes.

# How to use

The mod comes packaged with 20 sample boulders (10 round, 10 vertical)

To regenerate the stones with the default parameters, simply run `generate_stones.py`, and it will save the models and nodeboxes appropriately.

- TODO: Make it easier for people to customize the stone generation (command line arguments, perhaps)

# License

Code: MIT (license text located in the file named LICENSE)

The boulder models and nodeboxes are the product of a general algorithm, and therefore I **do not and cannot** claim ownership over the sample boulders included with this mod, or any boulders generated by the program.

However, if you reside in a country or region or are in a circumstance where I do have rights to the sample boulders or any output of the program, then the outputs of the program may be licensed to you under CC0-1.0.

# Screenshots

![Screenshot from 2023-08-07 15-15-10](https://github.com/regulus79/beautifulboulders/assets/117475203/7d5d89ea-3aef-4467-9bab-605c7cf8d992)
![image](https://github.com/regulus79/beautifulboulders/assets/117475203/2594f991-3f33-49f4-8819-eba954852e3f)
![Screenshot from 2023-08-07 15-13-23](https://github.com/regulus79/beautifulboulders/assets/117475203/45a59bd0-8240-4480-8972-4b52de131cdf)
