import random
import numpy as np
from scipy.spatial import ConvexHull

#
# Algorithm Explanation:
# Step 1: Given randomly spaced 3d points, generate a convex hull too be used as the rock model
# Step 2: Save the ConvexHull returned by scipy into a .obj file.
# Step 3: Generate collision boxes for each vertex with an Axis Aligned Bounding Box starting from the origin (0,0,0) and ending at each point.
# Step 4: Save the collision boxes.
#

# Parameters:
# 1. Filename: String (not including .obj at the end)
# 2. Points: a numpy array with a size of (n, 3), n being the number of points
def save_stone_obj(filename,points):
    mean_of_points=points.mean(axis=0)
    points-=mean_of_points
    hull=ConvexHull(points)

    verts=hull.vertices
    faces=hull.simplices
    new_faces=[]
    normals=[]

    for idx,i in enumerate(faces):
        normal=np.cross(points[i[0]]-points[i[1]],points[i[1]]-points[i[2]])
        mean_of_face=points[i].mean(axis=0)
        dotproduct=np.sign(normal.dot(mean_of_face))

        if dotproduct<0:
            new_faces.append(i[[1,0,2]])
        else:
            new_faces.append(i)
        
        #normal=-torch.randn(3,)
        normals.append(normal)
    
    with open("models/"+filename+".obj","w") as file:
        for i in points:
            file.write(f"v {i[0]} {i[1]} {i[2]}\n")
        for i in normals:
            file.write(f"vn {i[0]} {i[1]} {i[2]}\n")
        for i in faces:
            file.write(f"vt {1} {0}\n")
            file.write(f"vt {0} {1}\n")
            file.write(f"vt {0} {0}\n")
        for i,face in enumerate(faces):
            file.write(f"f {new_faces[i][0]+1}/{i*3+1}/{i+1} {new_faces[i][1]+1}/{i*3+2}/{i+1} {new_faces[i][2]+1}/{i*3+3}/{i+1}\n")
    
    num_boxes=0
    with open("nodeboxes/"+filename+".lua","w") as file:
        file.write("return {")

        for i in verts:
            min_pos=np.concatenate((np.array([[0,0,0]]),np.expand_dims(points[i],axis=0))).min(axis=0)
            max_pos=np.concatenate((np.array([[0,0,0]]),np.expand_dims(points[i],axis=0))).max(axis=0)
            min_pos[0]*=-1
            max_pos[0]*=-1
            file.write("{"+f"{min_pos[0]}, {min_pos[1]}, {min_pos[2]}, {max_pos[0]}, {max_pos[1]}, {max_pos[2]}"+"},\n")
        file.write("}")
    print("Faces:",len(faces))
    print("Verts:",len(verts))

if __name__=="__main__":
    #Wall Stones
    for i in range(10):
        name="stonevertical"+str(i)
        scale=np.array([0.7,1.4,0.7])
        num_points=random.randrange(20,30)
        points=np.random.randn(num_points,3)
        points=points/(np.expand_dims(np.linalg.norm(points,axis=1),axis=1))*scale
        save_stone_obj(name,points)
        print(name, scale, num_points)

    #Boulders
    for i in range(10):
        name="stone"+str(i)
        scale=1+random.random()/2
        num_points=random.randrange(20,30)
        points=np.random.randn(num_points,3)
        points=points/(np.expand_dims(np.linalg.norm(points,axis=1),axis=1))*scale
        save_stone_obj(name,points)
        print(name, scale, num_points)
